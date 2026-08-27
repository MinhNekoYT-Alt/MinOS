#!/usr/bin/env bash
set -Eeuo pipefail

# Add a standalone x86_64 GRUB EFI boot image to an existing live-build ISO.
# The existing El Torito BIOS entry is replayed by xorriso, so BIOS remains
# bootable while UEFI receives a minimal GRUB menu. Firmware vendor branding,
# when provided by the motherboard, appears before this bootloader and is not
# replaced by MinOS. The GRUB menu itself uses a clean version of the user
# wallpaper without the MinOS text or penguin mascot.

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 INPUT_ISO OUTPUT_ISO" >&2
  exit 2
fi

INPUT_ISO="$1"
OUTPUT_ISO="$2"
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
for command in grub-mkstandalone dd mkfs.vfat mmd mcopy xorriso; do
  command -v "$command" >/dev/null 2>&1 || {
    echo "Missing required command: $command" >&2
    exit 1
  }
done
[[ -f "$INPUT_ISO" ]] || { echo "Input ISO not found: $INPUT_ISO" >&2; exit 1; }
[[ "$INPUT_ISO" != "$OUTPUT_ISO" ]] || { echo "Input and output ISO must differ." >&2; exit 1; }
GRUB_BACKGROUND="$ROOT/assets/minos-grub-background.png"
[[ -f "$GRUB_BACKGROUND" ]] || { echo "GRUB background not found: $GRUB_BACKGROUND" >&2; exit 1; }

mkdir -p "$(dirname -- "$OUTPUT_ISO")"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

cat > "$WORK/grub.cfg" <<'GRUBCFG'
insmod part_gpt
insmod part_msdos
insmod fat
insmod iso9660
insmod search
insmod search_label
insmod normal
insmod configfile
insmod linux
insmod chain
insmod gfxterm
insmod gfxterm_background
insmod gfxmenu
insmod font
insmod png
insmod all_video

set gfxmode=1024x768,auto
terminal_output gfxterm
background_image -m stretch /boot/grub/minos-grub-background.png
set color_normal=white/black
set color_highlight=white/blue

search --no-floppy --set=root --label MINOS_2404
set timeout=8
set default=0

menuentry "Start MinOS" {
    linux /live/vmlinuz boot=live quiet username=minos hostname=minos
    initrd /live/initrd.img
}
GRUBCFG

grub-mkstandalone \
  --format=x86_64-efi \
  --directory=/usr/lib/grub/x86_64-efi \
  --disable-shim-lock \
  --install-modules='part_gpt part_msdos fat iso9660 search search_label normal configfile linux chain gfxterm gfxterm_background gfxmenu font png all_video efi_gop efi_uga' \
  --output="$WORK/BOOTX64.EFI" \
  "boot/grub/grub.cfg=$WORK/grub.cfg" \
  "boot/grub/minos-grub-background.png=$GRUB_BACKGROUND"

dd if=/dev/zero of="$WORK/efiboot.img" bs=1M count=16 status=none
mkfs.vfat -n MINOS_EFI "$WORK/efiboot.img" >/dev/null
mmd -i "$WORK/efiboot.img" ::/EFI ::/EFI/BOOT
mcopy -i "$WORK/efiboot.img" "$WORK/BOOTX64.EFI" ::/EFI/BOOT/BOOTX64.EFI

rm -f "$OUTPUT_ISO"
xorriso \
  -indev "$INPUT_ISO" \
  -outdev "$OUTPUT_ISO" \
  -map "$WORK/efiboot.img" /EFI/BOOT/efiboot.img \
  -boot_image any replay \
  -boot_image any next \
  -boot_image any efi_path=/EFI/BOOT/efiboot.img \
  -commit -end

xorriso -indev "$OUTPUT_ISO" -report_el_torito plain
