# Validation Record

## ISO release validation — 2026-08-27

The current release artifact is `build/MinOS-Desktop-Cinnamon-24.04-amd64.iso`, SHA-256 `c85b056650ea7914f1261d2cca2bad89b235352e42f1600104555101233118b8`. It contains both BIOS and UEFI El Torito boot entries, confirmed with `xorriso -report_el_torito plain`. Its BIOS menu uses the title `Welcome to MinOS` and exactly one `Start MinOS` entry targeting `/live/vmlinuz` and `/live/initrd.img` with `boot=live`.

The BIOS QEMU check displayed the 640×480 mascot-only splash without `ldlinux.c32` failure and showed one selectable `Start MinOS` entry. The source now vendors the matching Syslinux modules (`ldlinux.c32`, `libcom32.c32`, `libutil.c32`, `menu.c32`, `vesamenu.c32`) instead of retaining host-path symlinks.

The UEFI QEMU check using OVMF with Secure Boot disabled showed one GRUB `Start MinOS` entry over the clean abstract blue background. This background has no penguin and no MinOS text. It runs after firmware, so this validation cannot assert or control any manufacturer logo displayed by physical hardware firmware.

Rootfs inspection verified `MinOS Desktop` / Cinnamon identity, the `MinOS Software` Mintinstall label override, the featured catalog and controlled launch paths for Bottles, WPS Office, YouTube, Facebook, TikTok, Android Studio and Waydroid documentation. Optional Flatpak app runtimes are no longer embedded in the ISO. This fixed the prior build abort caused by a `filesystem.squashfs` larger than the legacy 4 GiB ISO-9660 field. The build process also removes stale `chroot/binary` staging before rebuilding, avoiding the previous `mv: cannot overwrite 'chroot/binary'` error; zsync is disabled to avoid stale `.zsync.xz` collision.

Full Cinnamon Live desktop, Calamares installation, installed-disk Windows detection, physical Wi-Fi hardware and Secure Boot are **not yet certified**. A sandbox QEMU run reached graphical boot but did not complete a desktop validation after resource pressure; these tests must be repeated on a sufficiently provisioned VM or physical PC.
