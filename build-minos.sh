#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

if [[ "$(id -u)" -eq 0 ]]; then
  echo "Không nên chạy script này trực tiếp bằng root; hãy chạy bằng tài khoản có sudo." >&2
  exit 2
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "Thiếu sudo trên máy dựng." >&2
  exit 2
fi

export DEBIAN_FRONTEND=noninteractive

case "${MINOS_EDITION:-cinnamon}" in
  cinnamon|mint)
    EDITION="cinnamon"
    DESKTOP_LABEL="Cinnamon"
    FILE_EDITION="Cinnamon"
    ;;
  *)
    echo "MinOS Desktop hiện chỉ hỗ trợ Cinnamon: MINOS_EDITION=cinnamon hoặc mint." >&2
    exit 2
    ;;
esac

sudo apt-get update
sudo apt-get install -y \
  live-build \
  debootstrap \
  squashfs-tools \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64-bin \
  grub-efi-amd64-signed \
  shim-signed \
  mtools \
  dosfstools \
  python3-pil \
  syslinux-utils \
  syslinux-common \
  qemu-system-x86

chmod +x build.sh auto/config auto/build config/hooks/normal/0100-minos-branding.hook.chroot config/hooks/normal/0200-minos-flatpak-apps.hook.chroot config/includes.chroot/usr/local/bin/minos-apply-wallpaper config/includes.chroot/usr/local/bin/minos-install-on-boot config/includes.chroot/usr/local/sbin/minos-install-gpu-driver config/includes.chroot/usr/bin/minos-update-center config/includes.chroot/usr/bin/minos-software-catalog tools/make_boot_splash.py tools/add_uefi_boot.sh

# Assemble the selected desktop edition from the common package list.
cp config/package-lists/minos-common.list.chroot config/package-lists/minos-desktop.list.chroot
cat "config/package-lists/minos-${EDITION}.list.chroot" >> config/package-lists/minos-desktop.list.chroot
printf '%s\n' "$EDITION" > config/includes.chroot/etc/minos-edition

# Remove stale/root-owned stages before materializing live-build configuration.
sudo rm -rf .build

# Generate boot splash assets and the live-build configuration.
python3 tools/make_boot_splash.py
./auto/config

# Remove stale build stages but keep the project configuration.
sudo lb clean --all || true
sudo rm -rf chroot/binary chroot/chroot chroot.tmp

# Build the ISO hybrid image. Logs are retained for troubleshooting.
LOG_FILE="$PROJECT_DIR/build/minos-build.log"
mkdir -p "$PROJECT_DIR/build"
sudo lb build 2>&1 | tee "$LOG_FILE"

ISO_SOURCE=""
for candidate in live-image-amd64.hybrid.iso live-image-amd64.iso binary.hybrid.iso binary.iso; do
  if [[ -f "$PROJECT_DIR/$candidate" ]]; then
    ISO_SOURCE="$PROJECT_DIR/$candidate"
    break
  fi
done

if [[ -z "$ISO_SOURCE" ]]; then
  ISO_SOURCE="$(find "$PROJECT_DIR" -maxdepth 1 -type f -name '*.iso' -print -quit || true)"
fi

if [[ -z "$ISO_SOURCE" || ! -f "$ISO_SOURCE" ]]; then
  echo "Không tìm thấy ISO đầu ra. Xem $LOG_FILE để biết lỗi chi tiết." >&2
  exit 1
fi

ISO_WITH_UEFI="$PROJECT_DIR/build/.minos-uefi.iso"
./tools/add_uefi_boot.sh "$ISO_SOURCE" "$ISO_WITH_UEFI"

ISO_OUTPUT="$PROJECT_DIR/build/MinOS-Desktop-${FILE_EDITION}-24.04-amd64.iso"
cp --preserve=mode,timestamps "$ISO_WITH_UEFI" "$ISO_OUTPUT"
rm -f "$ISO_WITH_UEFI"
sha256sum "$ISO_OUTPUT" | tee "$ISO_OUTPUT.sha256"

sudo chown -R "$(id -u):$(id -g)" "$PROJECT_DIR/build" "$ISO_SOURCE" "$ISO_OUTPUT" 2>/dev/null || true

echo
echo "Edition:  $DESKTOP_LABEL"
echo "Đã tạo: $ISO_OUTPUT"
echo "SHA256:  $ISO_OUTPUT.sha256"
