# MinOS Desktop: phạm vi kiến trúc và tài nguyên

**MinOS Desktop** hiện là ISO Live/installer Cinnamon dành cho **PC `amd64`**. Artifact phát hành không có `arm32`, `arm64` hoặc `amd32`. Đây không phải giới hạn tùy tiện: base Ubuntu Noble phát hành desktop Live image chính thức cho PC 64-bit, và ngay image desktop Ubuntu tiêu chuẩn cũng nêu mức tối thiểu 1024 MiB RAM để cài đặt.[1]

| Hạng mục | Trạng thái MinOS hiện tại | Kết luận sử dụng |
| --- | --- | --- |
| Kiến trúc phát hành | `amd64` | Được build và kiểm tra cấu trúc BIOS/UEFI trong source này. |
| `amd32` / i386 | Không có artifact | Không tuyên bố hỗ trợ hoặc phát hành ISO 32-bit trên profile Noble+Cinnamon này. |
| `arm32` / `arm64` | Không có artifact | Đã loại ra khỏi phạm vi dự án hiện tại. |
| 1 core / 1 GB RAM | Không được xác nhận | Không đủ cơ sở để hứa Cinnamon Live desktop, Calamares và Chrome chạy ổn định. |
| 5 GB disk | Không được xác nhận | Không phù hợp để cam kết cho installation đầy đủ; app lớn được đưa thành cài đặt tùy chọn. |

Khi đánh giá chroot release sau khi chỉ giữ metadata Flathub và chuyển Bottles/WPS Office/Android Studio sang cài theo lựa chọn, profile vẫn có khoảng **1.628** package và thư mục rootfs chưa nén đo được khoảng **11 GB** trong môi trường build. Số đo này bao gồm nội dung và metadata của image build, không phải công bố dung lượng cài đặt cuối cùng; nó cho thấy rõ 5 GB không thể là cam kết an toàn cho profile desktop hiện tại.

> Mục tiêu “chạy được ở 1 GB RAM và cài trong 5 GB” chỉ có thể là một edition khác, phải bỏ hoặc thay thế các thành phần desktop/app hiện tại và cần benchmark riêng. Nó không được gán nhầm cho MinOS Desktop Cinnamon hiện tại.

## Hướng dùng đúng

Để giảm tải, người dùng chọn cài Bottles, WPS Office và Android Studio trong MinOS Software khi cần. Waydroid không được tự cài, vì tài liệu chính thức yêu cầu Wayland và, trên các Ubuntu release cũ hơn 26.10 như Noble, repository Waydroid bổ sung.[2] Điều này giảm kích thước Live ISO và tránh áp đặt repository bên thứ ba lên mọi máy.

## References

[1]: https://releases.ubuntu.com/noble/ "Ubuntu 24.04 Noble official release images"
[2]: https://docs.waydro.id/usage/install-on-desktops "Waydroid official desktop installation documentation"
