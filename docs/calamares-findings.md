# Ghi chú nghiên cứu Calamares

Calamares dùng `settings.conf` làm cấu hình cấp cao để xác định chuỗi module; cấu hình module và branding nên được đóng gói riêng trong `/etc/calamares` thay vì sửa file mẫu trong chính Calamares.[1]

Trên Ubuntu Noble, APT có các gói `calamares` phiên bản ứng viên 3.3.5-0ubuntu4 và `calamares-settings-kubuntu` phiên bản 1:24.04.40. Gói Kubuntu có thể dùng làm nền cấu hình/branding, sau đó MinOS đặt cấu hình riêng trong `/etc/calamares` để không phụ thuộc vào tên Kubuntu.

Trang packages.ubuntu.com với URL đã thử mở báo “No such package”, nên khi build cần tin vào tên package đã kiểm tra bằng APT và không dùng URL đó làm nguồn khẳng định.

[1]: https://calamares.codeberg.page/docs/deploy-configuration/ "Calamares Documentation: Configuration"
