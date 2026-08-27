# Calamares trong MinOS Desktop

MinOS dùng **Calamares** làm trình cài đặt đồ họa từ Live Cinnamon session. `LB_DEBIAN_INSTALLER=false` là chủ ý: live-build không nhúng Debian Installer, còn Calamares quản lý workflow locale, keyboard, partition, user, bootloader và unpack filesystem Live.

> Cài đặt có thể xóa dữ liệu nếu người dùng chọn sai ổ hoặc sai phân vùng. Hãy sao lưu, đọc kỹ trang summary, và thử flow trong máy ảo trước khi cài lên thiết bị thật.

| Lựa chọn | Hành vi |
| --- | --- |
| Start MinOS | Khởi động Live Cinnamon, không ghi ổ đĩa nếu không chạy installer |
| Install from desktop | Mở launcher **Install MinOS Desktop** trong menu Cinnamon sau khi đã thử Live session |

## Cấu hình MinOS

Cấu hình được lưu trong `config/includes.chroot/etc/calamares/`. Branding `minos` có `branding.desc` và `show.qml`, dùng slideshow API 2. `unpackfs.conf` lấy source filesystem từ `/cdrom/live/filesystem.squashfs`, vì image dùng `live-boot` và layout `/live`.

Slideshow có sáu trang tự chuyển sau 6,5 giây, song ngữ English/tiếng Việt: giới thiệu MinOS, desktop workflow, Live/installer, app catalog & Flatpak, hardware & Wi-Fi, và dual boot/update choice. Slideshow chỉ giới thiệu hệ thống trong giai đoạn cài đặt; nó không thay thế các màn hình locale hoặc partition, và cần kiểm tra runtime QML khi ISO boot được.

## Ngôn ngữ và app catalog

English (`en_US.UTF-8`) là mặc định. Image cũng có `vi_VN.UTF-8`, Vietnamese language packs và Fcitx5 Unikey để người dùng chọn trong installer hoặc sau cài đặt. Flatpak + Flathub system-wide được cài, và **MinOS App Center** mở Linux Mint Software Manager. Flatpak phân biệt cài đặt system-wide và per-user; system-wide remote có thể dùng cho mọi user.[1]

Chrome, Firefox, VLC, File Roller, Timeshift, Bottles, WPS Office, Warpinator và WebApp Manager được đưa vào image. Bottles/WPS Office được tải từ Flathub trong build; WPS Office vẫn chịu điều khoản license của upstream. Zalo là launcher Chrome Web App, không phải binary Zalo Linux không chính thức.

## Cập nhật và GPU

Launcher **MinOS Update Center** mở `mintupdate`. Mint Update Manager hiển thị thông báo khi có update, nhưng MinOS không có script tự chạy `mintupdate-cli upgrade`, `apt upgrade`, `pkcon update`, `flatpak update` hoặc `curl` để nâng cấp. Người dùng xem và tự xác nhận từng cập nhật.[3]

`minos-gpu-driver.service` không thực thi trong Live session. Trên hệ thống đã cài, nó có thể gọi `ubuntu-drivers` để đề xuất/cài NVIDIA driver phù hợp. Kernel, firmware, microcode và Mesa đã có trong image, nhưng không bảo đảm mọi adapter Wi-Fi, chipset hay game Windows được hỗ trợ.

## Dual boot Windows

`os-prober` và `GRUB_DISABLE_OS_PROBER=false` được cấu hình để GRUB sau cài đặt có thể tạo entry Windows. Điều này phụ thuộc Windows/EFI partition có thể dò được từ hệ thống đã cài; BitLocker, phân vùng bị khóa, firmware setting, hư filesystem hoặc scan policy có thể khiến Windows không xuất hiện. Cần kiểm thử trên disk/VM có Windows trước khi xem đây là tính năng đã xác nhận.

## Checklist runtime

| Kiểm tra | Tiêu chí đạt |
| --- | --- |
| Live desktop | Cinnamon, Start icon, wallpaper, English default và Wi-Fi policy xuất hiện đúng |
| Calamares | Launcher mở được; slideshow QML chuyển đủ sáu trang; source filesystem unpack đúng |
| Cài đặt | ext4 manual + automatic, user, LightDM/Cinnamon và GRUB boot được |
| Post-install | Update Center mở mintupdate; Flatpak remote nhận diện được; Bottles/WPS/Zalo Web launchers hiện diện; locale VI có thể chọn |
| Dual boot | `update-grub` thấy Windows trên môi trường test hợp lệ |

## References

[1]: https://docs.flatpak.org/en/latest/using-flatpak.html "Flatpak documentation: Using Flatpak"
[2]: https://calamares.io/docs/ "Calamares documentation"
[3]: https://linuxmint-user-guide.readthedocs.io/en/latest/mintupdate.html "Linux Mint User Guide: Update Manager"
