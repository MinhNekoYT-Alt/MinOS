#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
fail=0

require_file() {
  local file="$1"
  if [[ ! -f "$ROOT/$file" ]]; then
    echo "MISSING: $file" >&2
    fail=1
  else
    echo "OK: $file"
  fi
}

require_file README.md
require_file LICENSE
require_file build.sh
require_file build-minos.sh
require_file .github/workflows/build-iso.yml
require_file auto/config
require_file auto/build
require_file assets/minos-logo.png
require_file assets/minos-wallpaper.png
require_file assets/minos-penguin-only.png
require_file assets/minos-grub-background.png
require_file tools/update_brand_assets.py
require_file config/package-lists/minos-common.list.chroot
require_file config/package-lists/minos-cinnamon.list.chroot
require_file config/package-lists/minos-desktop.list.chroot
require_file config/hooks/normal/0100-minos-branding.hook.chroot
require_file config/hooks/normal/0200-minos-flatpak-apps.hook.chroot
require_file config/includes.chroot/etc/os-release
require_file config/includes.chroot/etc/issue
require_file config/includes.chroot/etc/motd
require_file config/includes.chroot/etc/default/locale
require_file config/includes.chroot/etc/locale.gen
require_file config/includes.chroot/etc/minos-edition
require_file config/includes.chroot/etc/gnome-background-properties/minos.xml
require_file config/includes.chroot/usr/share/glib-2.0/schemas/90_minos.gschema.override
require_file config/includes.chroot/etc/default/grub.d/99-minos.cfg
require_file config/includes.chroot/etc/NetworkManager/conf.d/10-minos-wifi-powersave.conf
require_file config/includes.chroot/usr/share/pixmaps/minos-logo.png
require_file config/includes.chroot/usr/share/backgrounds/minos/minos-wallpaper.png
require_file config/includes.chroot/etc/lightdm/lightdm.conf.d/99-minos.conf
require_file config/includes.chroot/etc/xdg/autostart/minos-wallpaper.desktop
require_file config/includes.chroot/etc/xdg/autostart/minos-install-on-boot.desktop
require_file config/includes.chroot/usr/local/bin/minos-apply-wallpaper
require_file config/includes.chroot/usr/local/bin/minos-install-on-boot
require_file config/includes.chroot/usr/share/icons/MinOS/index.theme
require_file config/includes.chroot/usr/share/icons/MinOS/64x64/apps/start-here.png
require_file config/includes.chroot/usr/share/pixmaps/minos-start-icon.png
require_file config/includes.binary/isolinux/splash.png
require_file config/includes.binary/syslinux/splash.png
require_file config/binary_grub/splash.tga
require_file tools/add_uefi_boot.sh
require_file config/includes.chroot/usr/bin/rsvg
require_file config/includes.binary/isolinux/install.cfg
require_file config/includes.binary/syslinux/install.cfg
require_file config/bootloaders/isolinux/live.cfg.in
require_file config/bootloaders/isolinux/install.cfg
require_file config/bootloaders/isolinux/bootlogo
require_file config/bootloaders/syslinux/bootlogo
require_file config/includes.chroot/etc/calamares/modules/unpackfs.conf
require_file docs/boot.md
require_file docs/calamares.md
require_file config/includes.chroot/etc/calamares/settings.conf
require_file config/includes.chroot/etc/calamares/branding/minos/branding.desc
require_file config/includes.chroot/etc/calamares/branding/minos/show.qml
require_file config/includes.chroot/etc/calamares/modules/partition.conf
require_file config/includes.chroot/etc/calamares/modules/displaymanager.conf
require_file config/includes.chroot/usr/share/applications/minos-installer.desktop
require_file config/archives/google-chrome.list.chroot
require_file config/archives/google-chrome.key.chroot
require_file config/archives/linuxmint.list.chroot
require_file config/archives/linuxmint.key.chroot
require_file config/includes.chroot/etc/flatpak/remotes.d/flathub.flatpakrepo
require_file config/includes.chroot/etc/minos/optional-apps.txt
require_file config/includes.chroot/usr/bin/minos-update-center
require_file config/includes.chroot/usr/share/applications/minos-update-center.desktop
require_file config/includes.chroot/usr/share/applications/minos-app-center.desktop
require_file config/includes.chroot/usr/local/share/applications/mintinstall.desktop
require_file config/includes.chroot/usr/bin/minos-software-catalog
require_file config/includes.chroot/usr/share/applications/minos-youtube.desktop
require_file config/includes.chroot/usr/share/applications/minos-facebook.desktop
require_file config/includes.chroot/usr/share/applications/minos-tiktok.desktop
require_file config/includes.chroot/usr/share/applications/minos-zalo.desktop
require_file config/includes.chroot/usr/share/minos/minos-penguin-ascii.txt
require_file config/includes.chroot/usr/local/bin/neofetch
require_file config/includes.chroot/usr/local/sbin/minos-install-gpu-driver
require_file config/includes.chroot/etc/systemd/system/minos-gpu-driver.service
require_file config/includes.chroot/etc/systemd/system/multi-user.target.wants/minos-gpu-driver.service
require_file docs/requirements.md
require_file config/bootloaders/isolinux/ldlinux.c32
require_file config/bootloaders/isolinux/libcom32.c32
require_file config/bootloaders/isolinux/libutil.c32
require_file config/bootloaders/isolinux/menu.c32
require_file config/bootloaders/isolinux/vesamenu.c32

bash -n "$ROOT/build-minos.sh"
bash -n "$ROOT/build.sh"
sh -n "$ROOT/auto/config"
sh -n "$ROOT/auto/build"
sh -n "$ROOT/config/hooks/normal/0100-minos-branding.hook.chroot"
sh -n "$ROOT/config/hooks/normal/0200-minos-flatpak-apps.hook.chroot"
sh -n "$ROOT/config/includes.chroot/usr/local/bin/minos-apply-wallpaper"
sh -n "$ROOT/config/includes.chroot/usr/local/bin/minos-install-on-boot"
sh -n "$ROOT/config/includes.chroot/usr/local/sbin/minos-install-gpu-driver"
sh -n "$ROOT/tools/add_uefi_boot.sh"
bash -n "$ROOT/config/includes.chroot/usr/bin/minos-update-center"
sh -n "$ROOT/config/includes.chroot/usr/bin/minos-software-catalog"
sh -n "$ROOT/config/includes.chroot/usr/local/bin/neofetch"

grep -q '^ID=minos$' "$ROOT/config/includes.chroot/etc/os-release"
grep -q 'MinOS' "$ROOT/config/includes.chroot/etc/issue"
grep -q '^LANG=en_US.UTF-8$' "$ROOT/config/includes.chroot/etc/default/locale"
grep -q '^en_US.UTF-8 UTF-8$' "$ROOT/config/includes.chroot/etc/locale.gen"
grep -q '^vi_VN.UTF-8 UTF-8$' "$ROOT/config/includes.chroot/etc/locale.gen"
grep -q '^language-pack-en$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^language-pack-vi$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^fcitx5-unikey$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^flatpak$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^neofetch$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^timeshift$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^neofetch$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^broadcom-sta-dkms$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^rtl8812au-dkms$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^live-boot$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^live-config$' "$ROOT/config/package-lists/minos-common.list.chroot"
! grep -q '^casper$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q 'MinOS Aurora' "$ROOT/config/includes.chroot/etc/gnome-background-properties/minos.xml"
grep -q '^cinnamon$' "$ROOT/config/includes.chroot/etc/minos-edition"
grep -q '^os-prober$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^cinnamon$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^nemo$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^lightdm$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^mintupdate$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^mintinstall$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^webapp-manager$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^warpinator$' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
! grep -Eq '^(kubuntu-desktop|kde-standard|kde-plasma-desktop|plasma-nm|sddm)$' "$ROOT/config/package-lists/minos-desktop.list.chroot"
grep -q '^greeter-session=slick-greeter$' "$ROOT/config/includes.chroot/etc/lightdm/lightdm.conf.d/99-minos.conf"
grep -q 'minos-apply-wallpaper' "$ROOT/config/includes.chroot/etc/xdg/autostart/minos-wallpaper.desktop"
grep -q 'minos-wallpaper.png' "$ROOT/config/includes.chroot/usr/local/bin/minos-apply-wallpaper"
grep -q 'minos-install' "$ROOT/config/includes.chroot/usr/local/bin/minos-install-on-boot"
grep -q 'Cài đặt MinOS Desktop' "$ROOT/config/includes.chroot/usr/share/applications/minos-installer.desktop"
grep -q 'Install MinOS Desktop' "$ROOT/config/includes.binary/isolinux/install.cfg"
grep -Eq '^[[:space:]]*kernel /live/vmlinuz$' "$ROOT/config/includes.binary/isolinux/install.cfg"
grep -Eq '^[[:space:]]*append initrd=/live/initrd.img boot=live quiet username=minos hostname=minos minos-install$' "$ROOT/config/includes.binary/isolinux/install.cfg"
grep -Eq '^[[:space:]]*kernel /live/vmlinuz$' "$ROOT/config/includes.binary/syslinux/install.cfg"
grep -Eq '^[[:space:]]*append initrd=/live/initrd.img boot=live quiet username=minos hostname=minos minos-install$' "$ROOT/config/includes.binary/syslinux/install.cfg"
grep -q '^LB_MODE="ubuntu"$' "$ROOT/config/common"
grep -q '^LB_INITRAMFS="live-boot"$' "$ROOT/config/common"
grep -q '^LB_INITSYSTEM="systemd"$' "$ROOT/config/common"
grep -q '^LB_BOOTLOADER="syslinux"$' "$ROOT/config/binary"
grep -q '^LB_ZSYNC="false"$' "$ROOT/config/binary"
grep -q '^LB_GRUB_SPLASH="config/binary_grub/splash.tga"$' "$ROOT/config/binary"
grep -q 'efi_path=/EFI/BOOT/efiboot.img' "$ROOT/tools/add_uefi_boot.sh"
grep -q 'linux /live/vmlinuz boot=live' "$ROOT/tools/add_uefi_boot.sh"
grep -q 'background_image -m stretch /boot/grub/minos-grub-background.png' "$ROOT/tools/add_uefi_boot.sh"
grep -q 'minos-grub-background.png=$GRUB_BACKGROUND' "$ROOT/tools/add_uefi_boot.sh"
grep -q 'menu title Welcome to MinOS' "$ROOT/config/bootloaders/isolinux/menu.cfg"
grep -q 'menu label \^Start MinOS' "$ROOT/config/bootloaders/isolinux/live.cfg.in"
! grep -q 'live-failsafe' "$ROOT/config/bootloaders/isolinux/live.cfg.in"
grep -q 'menuentry "Start MinOS"' "$ROOT/tools/add_uefi_boot.sh"
test -x "$ROOT/config/includes.chroot/usr/bin/rsvg"
grep -q 'calamares' "$ROOT/config/package-lists/minos-cinnamon.list.chroot"
grep -q '^google-chrome-stable$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^linux-firmware$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q '^ubuntu-drivers-common$' "$ROOT/config/package-lists/minos-common.list.chroot"
grep -q 'dl.google.com/linux/chrome/deb' "$ROOT/config/archives/google-chrome.list.chroot"
! grep -q 'trusted=yes' "$ROOT/config/archives/google-chrome.list.chroot"
test -s "$ROOT/config/archives/google-chrome.key.chroot"
grep -q '^LB_ARCHIVES="google-chrome linuxmint"$' "$ROOT/config/bootstrap"
grep -q '^deb http://packages.linuxmint.com zena main upstream import backport$' "$ROOT/config/archives/linuxmint.list.chroot"
test -s "$ROOT/config/archives/linuxmint.key.chroot"
grep -q '^Name=flathub$' "$ROOT/config/includes.chroot/etc/flatpak/remotes.d/flathub.flatpakrepo"
grep -q '^Url=https://dl.flathub.org/repo/flathub.flatpakrepo$' "$ROOT/config/includes.chroot/etc/flatpak/remotes.d/flathub.flatpakrepo"
grep -q 'exec mintupdate' "$ROOT/config/includes.chroot/usr/bin/minos-update-center"
! grep -qE '(^|[[:space:]])(apt-get|pkcon|flatpak)[[:space:]]+update' "$ROOT/config/includes.chroot/usr/bin/minos-update-center"
grep -q 'ubuntu-drivers install' "$ROOT/config/includes.chroot/usr/local/sbin/minos-install-gpu-driver"
grep -q 'minos-install-gpu-driver' "$ROOT/config/includes.chroot/etc/systemd/system/minos-gpu-driver.service"
test -f "$ROOT/config/includes.chroot/usr/share/icons/MinOS/64x64/apps/start-here.png"
grep -q 'MINOS_DESKTOP="Cinnamon"' "$ROOT/config/includes.chroot/etc/os-release"
grep -q '^GRUB_DISABLE_OS_PROBER=false$' "$ROOT/config/includes.chroot/etc/default/grub.d/99-minos.cfg"
grep -q '^GRUB_TIMEOUT_STYLE=menu$' "$ROOT/config/includes.chroot/etc/default/grub.d/99-minos.cfg"
grep -q '^wifi.powersave = 2$' "$ROOT/config/includes.chroot/etc/NetworkManager/conf.d/10-minos-wifi-powersave.conf"
! grep '^LB_BOOTAPPEND_LIVE=' "$ROOT/config/binary" | grep -q 'splash'
grep -q 'LB_DEBIAN_INSTALLER="false"' "$ROOT/config/binary"
file "$ROOT/config/includes.binary/isolinux/splash.png" | grep -q 'PNG image data, 640 x 480'
file "$ROOT/config/includes.binary/syslinux/splash.png" | grep -q 'PNG image data, 640 x 480'
file "$ROOT/config/binary_grub/splash.tga" | grep -q 'Targa image data - RGB 1024 x 768'
grep -q '^branding: minos$' "$ROOT/config/includes.chroot/etc/calamares/settings.conf"
grep -q '/cdrom/live/filesystem.squashfs' "$ROOT/config/includes.chroot/etc/calamares/modules/unpackfs.conf"
grep -q 'MinOS Desktop' "$ROOT/config/includes.chroot/etc/calamares/branding/minos/branding.desc"
grep -Eq '^slideshow:[[:space:]]+"show.qml"$' "$ROOT/config/includes.chroot/etc/calamares/branding/minos/branding.desc"
grep -Eq '^slideshowAPI:[[:space:]]+2$' "$ROOT/config/includes.chroot/etc/calamares/branding/minos/branding.desc"
grep -q 'Welcome to MinOS Desktop' "$ROOT/config/includes.chroot/etc/calamares/branding/minos/show.qml"
grep -q 'minos_root' "$ROOT/config/includes.chroot/etc/calamares/modules/partition.conf"
grep -q 'cinnamon-session' "$ROOT/config/includes.chroot/etc/calamares/modules/displaymanager.conf"
grep -q 'efiBootloaderId: "minos"' "$ROOT/config/includes.chroot/etc/calamares/modules/bootloader.conf"
grep -q 'calamares' "$ROOT/config/includes.chroot/usr/share/applications/minos-installer.desktop"
grep -q '^Exec=minos-software-catalog$' "$ROOT/config/includes.chroot/usr/share/applications/minos-app-center.desktop"
grep -q '^Name=MinOS Software$' "$ROOT/config/includes.chroot/usr/local/share/applications/mintinstall.desktop"
grep -q '^Exec=mintinstall$' "$ROOT/config/includes.chroot/usr/local/share/applications/mintinstall.desktop"
grep -q 'com.google.AndroidStudio' "$ROOT/config/includes.chroot/usr/bin/minos-software-catalog"
grep -q 'docs.waydro.id/usage/install-on-desktops' "$ROOT/config/includes.chroot/usr/bin/minos-software-catalog"
grep -q 'youtube.com' "$ROOT/config/includes.chroot/usr/share/applications/minos-youtube.desktop"
grep -q 'facebook.com' "$ROOT/config/includes.chroot/usr/share/applications/minos-facebook.desktop"
grep -q 'tiktok.com' "$ROOT/config/includes.chroot/usr/share/applications/minos-tiktok.desktop"
grep -q 'chat.zalo.me' "$ROOT/config/includes.chroot/usr/share/applications/minos-zalo.desktop"
grep -q 'M i n O S' "$ROOT/config/includes.chroot/usr/share/minos/minos-penguin-ascii.txt"
grep -q -- '--source /usr/share/minos/minos-penguin-ascii.txt' "$ROOT/config/includes.chroot/usr/local/bin/neofetch"
grep -q 'com.usebottles.bottles' "$ROOT/config/includes.chroot/etc/minos/optional-apps.txt"
grep -q 'com.wps.Office' "$ROOT/config/includes.chroot/etc/minos/optional-apps.txt"
grep -q 'com.google.AndroidStudio' "$ROOT/config/includes.chroot/etc/minos/optional-apps.txt"
! grep -q '^flatpak install' "$ROOT/config/hooks/normal/0200-minos-flatpak-apps.hook.chroot"
! grep -q 'mintupdate-cli upgrade' "$ROOT/config/hooks/normal/0200-minos-flatpak-apps.hook.chroot"
test -x "$ROOT/config/hooks/normal/0200-minos-flatpak-apps.hook.chroot"
test -x "$ROOT/config/includes.chroot/usr/bin/minos-software-catalog"
test -x "$ROOT/tools/update_brand_assets.py"
grep -q '^name: Build and Release MinOS Desktop$' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'runs-on: ubuntu-24.04' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'MINOS_BUILD_STAGE=os ./build.sh' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'MINOS_BUILD_STAGE=iso' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'actions/upload-artifact@v4' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'gh release create' "$ROOT/.github/workflows/build-iso.yml"
grep -q 'title="MinOS - Version' "$ROOT/.github/workflows/build-iso.yml"

echo "Shell syntax and branding checks passed."
exit "$fail"
