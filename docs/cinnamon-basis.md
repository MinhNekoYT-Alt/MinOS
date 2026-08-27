# Căn cứ kiến trúc Ubuntu–Linux Mint cho MinOS

MinOS giữ **Ubuntu 24.04 Noble amd64** là package base. Linux Mint liệt kê các phát hành 22.x Cinnamon là dựa trên **Ubuntu Noble**, và ghi chú tính năng của Mint 22 cũng xác nhận base Ubuntu 24.04, kernel 6.8 cùng Cinnamon 6.2.[1] [2] Vì vậy, source MinOS dùng các package Cinnamon/Nemo/Mint-Y có candidate trong repository Ubuntu Noble thay vì thêm trực tiếp Linux Mint repository vào APT.

| Thành phần MinOS | Nguồn chiến lược | Lý do |
| --- | --- | --- |
| Cinnamon, Nemo, Cinnamon Control Center | Ubuntu Noble `universe` | Giữ dependency cùng package base Ubuntu |
| Mint-Y icons | Ubuntu Noble `universe` | Cung cấp ngôn ngữ thị giác gần hệ sinh thái Mint mà không trộn repo |
| LightDM + Slick Greeter | Ubuntu Noble `universe` | Session/greeter phù hợp với desktop Cinnamon |
| Timeshift | Ubuntu Noble `universe` | Tiện ích snapshot có candidate trực tiếp |
| Warpinator, WebApp Manager, Mint Update Manager | Optional after-install / Flatpak | Không có candidate trực tiếp trong nguồn Ubuntu Noble đã kiểm tra; không được quảng cáo là preinstalled |

Linux Mint 22 ghi nhận việc hiển thị và cảnh báo Flatpak không xác thực là một điểm bảo mật quan trọng. MinOS vì thế dùng Flatpak/Flathub như app catalog do người dùng chủ động lựa chọn, không seed ứng dụng third-party chưa kiểm tra.[2]

## References

[1]: https://linuxmint.com/download_all.php "Linux Mint supported releases and package bases"
[2]: https://www.linuxmint.com/rel_wilma_whatsnew.php "Linux Mint 22 features and Ubuntu 24.04 package base"
