#!/usr/bin/env bash
set -Eeuxo pipefail

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/tree/EFI/BOOT" "$work/tree/boot/grub"
printf 'test\n' > "$work/tree/root.txt"
grub-mkimage -d /usr/lib/grub/i386-pc -O i386-pc -p /boot/grub -o "$work/core.img" biosdisk iso9660
cat /usr/lib/grub/i386-pc/cdboot.img "$work/core.img" > "$work/tree/boot/grub/grub_eltorito"
printf 'insmod all_video\ninsmod gfxterm\n' > "$work/grub.cfg"
grub-mkstandalone --format=x86_64-efi --directory=/usr/lib/grub/x86_64-efi --output="$work/BOOTX64.EFI" "boot/grub/grub.cfg=$work/grub.cfg"
dd if=/dev/zero of="$work/efiboot.img" bs=1M count=16 status=none
mkfs.vfat "$work/efiboot.img" >/dev/null
mmd -i "$work/efiboot.img" ::/EFI ::/EFI/BOOT
mcopy -i "$work/efiboot.img" "$work/BOOTX64.EFI" ::/EFI/BOOT/BOOTX64.EFI
xorriso -as mkisofs -quiet -r -J -V TEST -o "$work/base.iso" -b boot/grub/grub_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table "$work/tree"
tools/add_uefi_boot.sh "$work/base.iso" "$work/uefi.iso"
xorriso -indev "$work/uefi.iso" -report_el_torito plain
xorriso -indev "$work/uefi.iso" -find /EFI/BOOT -type f
file "$work/uefi.iso"
