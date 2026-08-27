# Ghi chú Chrome và driver phần cứng

Google cung cấp repository Linux chính thức cho hệ Debian/Ubuntu và cho biết các package tải từ Google có thể tự cấu hình APT để xác thực cập nhật bằng khóa ký GPG của Google.[1]

Ubuntu khuyến nghị dùng `ubuntu-drivers` cho driver NVIDIA; công cụ này dùng cùng logic với Additional Drivers và có ưu tiên cho driver dựng sẵn, đã ký, phù hợp với Secure Boot.[2]

Định hướng MinOS: cài `linux-firmware` cùng kernel/firmware nền tảng; cài `ubuntu-drivers-common` và `software-properties-qt` để người dùng có công cụ phát hiện phần cứng. Không cài cứng mọi driver GPU độc quyền vào ISO vì dễ gây xung đột, tăng kích thước và không phù hợp với mọi máy. Hook hậu cài đặt sẽ tự phát hiện NVIDIA/AMD/Intel và gọi `ubuntu-drivers install` khi driver proprietary phù hợp có sẵn; nếu không, hệ thống dùng driver kernel/Mesa mã nguồn mở.

Google Chrome sẽ được tích hợp từ package DEB/repository chính thức của Google. Cần tôn trọng giấy phép và điều khoản phân phối của Google; MinOS không nên tự đóng gói lại binary Chrome.

[1]: https://www.google.com/linuxrepositories/ "Google Linux Software Repositories"
[2]: https://ubuntu.com/server/docs/how-to/graphics/install-nvidia-drivers/ "Ubuntu documentation: NVIDIA drivers installation"
