# Dựng MinOS Desktop Cinnamon

MinOS Desktop Cinnamon được dựng trên Ubuntu 24.04 Noble `amd64`. Desktop dùng Cinnamon, Nemo, Mint-Y icons, LightDM và Slick Greeter từ gói Noble, tức giữ binary compatibility với Ubuntu thay vì trộn trực tiếp repository Linux Mint vào APT. Linux Mint 22.x cũng dùng package base Ubuntu Noble, trong khi Cinnamon là edition chính thức của Mint.[1] [2]

> Không thêm repository Linux Mint vào image Ubuntu bằng cách không kiểm soát. Các gói Mint riêng không có sẵn trong Noble, như `mintupdate`, `mintinstall`, Warpinator và WebApp Manager, được để ở dạng lựa chọn manual/Flatpak cho đến khi có quy trình đóng gói và kiểm thử dependency riêng.

| Yêu cầu | Giá trị |
| --- | --- |
| Host dựng | Ubuntu 24.04 `amd64` hoặc môi trường tương thích, có `sudo` và Internet ổn định |
| Desktop image | Cinnamon; không cài KDE Plasma hoặc SDDM |
| Live stack | `live-build`, `live-boot`, `live-config`, systemd |
| Output mong đợi | `build/MinOS-Desktop-Cinnamon-24.04.4-amd64.iso` và `.sha256` |
| Boot | ISO hybrid, Syslinux BIOS + GRUB EFI standalone hậu xử lý; Secure Boot chưa hỗ trợ |

## Lệnh dựng

```bash
git clone https://github.com/MinhNekoYT-Alt/MinOS.git minos
cd minos
chmod +x build.sh
MINOS_EDITION=cinnamon ./build.sh
```

`mint` được chấp nhận làm alias cho `cinnamon`; không truyền biến cũng mặc định Cinnamon. `build.sh` gọi `build-minos.sh`, script này cài các dependency host, ghép package list `minos-common` + `minos-cinnamon`, tạo asset boot, chạy live-build, thêm UEFI El Torito image, rồi tạo SHA-256.

`live-build` tổ chức build thành bootstrap, chroot customization và binary image; log `build/minos-build.log` phải được lưu khi debug.[3] Do live-build Noble có các nhánh Syslinux cũ, source giữ local bootloader templates và `bootlogo` archive tối thiểu. Việc build hoàn tất không thay thế runtime test trong VM.

## Kiểm tra source và ISO

```bash
./auto/config
./verify-minos.sh
sha256sum -c build/MinOS-Desktop-Cinnamon-24.04.4-amd64.iso.sha256
xorriso -indev build/MinOS-Desktop-Cinnamon-24.04.4-amd64.iso -report_el_torito plain
qemu-system-x86_64 -enable-kvm -m 4096 \
  -cdrom build/MinOS-Desktop-Cinnamon-24.04.4-amd64.iso
```

Sau build, cần xác minh: BIOS menu và `/live` paths; UEFI boot bằng OVMF khi Secure Boot tắt; Cinnamon Live session, wallpaper và Start icon; Calamares slideshow; cài lên disk trống; LightDM/Cinnamon sau reboot; MinOS Update Center; Flatpak remote; và cập nhật GRUB khi có Windows test disk.

## Update và app catalog

MinOS Update Center chỉ refresh metadata PackageKit rồi mở GNOME Software; không tự chạy cập nhật. Flatpak remote Flathub được cài system-wide, phù hợp với cơ chế remote toàn hệ thống của Flatpak.[4] Bất kỳ ứng dụng nào được thêm từ Flathub hoặc nguồn third-party đều phải do người dùng review và xác nhận.

## References

[1]: https://linuxmint.com/download_all.php "Linux Mint supported releases and package bases"
[2]: https://www.linuxmint.com/rel_wilma_whatsnew.php "Linux Mint 22 features and Ubuntu 24.04 package base"
[3]: https://manpages.ubuntu.com/manpages/noble/man7/live-build.7.html "Ubuntu Noble live-build manual"
[4]: https://docs.flatpak.org/en/latest/using-flatpak.html "Flatpak documentation: Using Flatpak"
