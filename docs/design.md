# Thiết kế MinOS Desktop Cinnamon

## Tầm nhìn

MinOS Desktop là bản phân phối cộng đồng dựa trên Ubuntu, hướng tới một desktop dễ nhận biết, nhẹ và quen thuộc. Hình ảnh trung tâm là chim cánh cụt MinOS với xanh than, xanh glacier và điểm nhấn cam; chữ **MinOS** nằm dưới biểu tượng trong các lockup dùng cho boot, wallpaper và tài liệu.

Từ thay đổi desktop hiện tại, MinOS dùng **Cinnamon** là desktop duy nhất. Image giữ Ubuntu 24.04 Noble làm package base và chọn Cinnamon, Nemo, Mint-Y icons, LightDM/Slick Greeter—những thành phần Linux Mint ecosystem có trong Noble—thay vì trộn trực tiếp kho Linux Mint vào APT.[1] [2]

| Lớp | Thành phần | Vai trò |
| --- | --- | --- |
| Nền tảng | Ubuntu 24.04 Noble, `amd64` | Kernel, firmware, drivers, APT và base packages |
| Live system | `live-boot`, `live-config`, `live-build`, ISO hybrid | Khởi động thử, tạo root filesystem và medium USB |
| Desktop | Cinnamon, Nemo, LightDM/Slick Greeter, Mint-Y icons | Phiên đồ họa thực dụng theo hướng Linux Mint |
| Nhận diện | `/etc/os-release`, logo, wallpaper, Cinnamon schema override | Hiển thị MinOS Desktop ở các điểm người dùng nhìn thấy |
| Tùy biến | Package lists, includes, chroot hook | Giữ thay đổi có thể lặp lại và kiểm soát bằng Git |

`live-build` tự động hóa các stage bootstrap, chroot và binary image từ configuration directory.[3] Nội dung hệ điều hành tách khỏi logic build: package list cung cấp dependency, `includes.chroot` chép cấu hình/asset, còn chroot hook xử lý metadata và schema cache.

## Chính sách component

MinOS không mạo nhận là Linux Mint chính thức và không nhập repository Linux Mint không kiểm soát. Các tính năng Mint-only không có candidate phù hợp trong Ubuntu Noble—như Mint Update Manager, Software Manager, Warpinator hoặc WebApp Manager—được để dưới dạng lựa chọn after-install hoặc Flatpak. MinOS Update Center dùng GNOME Software và không tự cài update nền.

Không đặt password chung, secret, token hay user quản trị cố định trong source. Mỗi public release cần checksum, test report BIOS/UEFI, test Live/Calamares và rà giấy phép/trademark riêng.

## Lộ trình

| Phiên bản | Nội dung |
| --- | --- |
| Aurora 0.1 | Live Cinnamon, penguin Start icon, wallpaper, Chrome/Firefox/VLC, Calamares, Flatpak và Timeshift |
| Aurora 0.2 | Xác minh installer, LightDM/Cinnamon, Flathub remote và Update Center trong VM |
| Aurora 0.3 | Kiểm thử hardware mở rộng, dual boot Windows và accessibility |
| 1.0 | Build tái lập, signed release path, test matrix và chính sách cập nhật dài hạn |

## References

[1]: https://linuxmint.com/download_all.php "Linux Mint supported releases and package bases"
[2]: https://www.linuxmint.com/rel_wilma_whatsnew.php "Linux Mint 22 features and Ubuntu 24.04 package base"
[3]: https://manpages.ubuntu.com/manpages/noble/man7/live-build.7.html "Ubuntu Noble live-build manual"
