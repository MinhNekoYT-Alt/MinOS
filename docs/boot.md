# Boot và branding MinOS

Tài liệu này mô tả **cấu hình source hiện tại**, không thay thế kết quả test BIOS/UEFI trên máy ảo. ISO MinOS được dựng theo mô hình `live-build` ISO hybrid, sử dụng `live-boot` và `live-config`; kernel cùng initrd của Live image nằm dưới `/live`.[1]

| Chế độ | Thành phần | Hiển thị theo yêu cầu | Trạng thái cần xác minh |
| --- | --- | --- | --- |
| BIOS / Legacy | Syslinux / isolinux | Splash 640×480 chỉ có **chim cánh cụt không chữ** trên nền tối; menu có tiêu đề `Welcome to MinOS` và một lựa chọn `Start MinOS`. | Menu và `/live/vmlinuz`, `/live/initrd.img` trong VM BIOS. |
| UEFI | Firmware mainboard, sau đó GRUB EFI standalone | Nếu firmware cung cấp logo hãng, logo này xuất hiện trước bootloader. Sau đó GRUB MinOS dùng nền xanh trích từ wallpaper người dùng đã cung cấp, **không có mascot và không có chữ MinOS**; menu chỉ có `Start MinOS`. | EFI El Torito entry và Live boot trong OVMF (Secure Boot off). |
| Hệ thống đã cài | GRUB được tạo khi cài đặt | Menu GRUB có thể hiển thị MinOS và Windows nếu `os-prober` tìm thấy Windows khi chạy `update-grub`. | Cần kiểm thử với một đĩa Windows thật hoặc disk VM thứ hai. |

> Firmware chạy trước bất kỳ bootloader nào trong ISO. MinOS **không thể buộc** máy UEFI hiển thị logo nhà sản xuất, thay logo firmware, hoặc giữ logo đó nếu chính firmware không cung cấp tùy chọn. Source chỉ tránh ghi đè màn hình ấy trước khi GRUB bắt đầu.

## BIOS / Legacy

`tools/update_brand_assets.py` cập nhật wallpaper và full logo từ asset người dùng, rồi tạo `assets/minos-penguin-only.png`. `tools/make_boot_splash.py` dùng riêng mascot này để sinh `config/includes.binary/isolinux/splash.png` và mirror Syslinux. Không có chữ `MinOS` trong splash BIOS.

Noble `live-build` vẫn có nhánh Syslinux cũ đòi `bootlogo` archive. Source cung cấp archive rỗng hợp lệ tại `config/bootloaders/{isolinux,syslinux}/bootlogo`, nhằm giữ local menu/splash custom thay vì quay lại theme gfxboot Ubuntu không tương thích.

## UEFI

Sau khi `lb build` tạo raw ISO BIOS hybrid, `tools/add_uefi_boot.sh` tạo `BOOTX64.EFI`, tạo FAT EFI image và dùng `xorriso` để replay BIOS El Torito catalog rồi bổ sung UEFI El Torito entry. Helper nhúng `assets/minos-grub-background.png`: đó là bản nền xanh của wallpaper do người dùng cung cấp đã được loại toàn bộ penguin/wordmark. Asset này chỉ xuất hiện **sau** firmware; nó không thay thế màn hình logo do firmware quản lý trước GRUB.

Helper không chainload shim và không ký GRUB standalone. Do đó **Secure Boot chưa được hỗ trợ** trong development build hiện tại. Kiểm thử UEFI trước bằng OVMF với Secure Boot tắt; phát hành cho máy bật Secure Boot đòi hỏi quy trình signing và chain of trust riêng.

## Dùng thử và cài đặt

Chọn `Start MinOS` luôn mở Live Cinnamon. Từ desktop, người dùng có thể thử phần cứng, mạng, âm thanh và wallpaper, sau đó mở launcher **Install MinOS Desktop** để chạy Calamares. Calamares hiển thị slideshow giới thiệu trong quá trình cài đặt.

| Mục đích | Vị trí source |
| --- | --- |
| Cấu hình live-build | `auto/config` |
| Menu BIOS template | `config/bootloaders/isolinux/live.cfg.in` |
| Splash BIOS mascot-only | `config/includes.binary/isolinux/splash.png` |
| Asset mascot | `assets/minos-penguin-only.png` |
| Nền GRUB UEFI sạch | `assets/minos-grub-background.png` |
| UEFI helper | `tools/add_uefi_boot.sh` |
| Launcher installer | `config/includes.chroot/usr/share/applications/minos-installer.desktop` |
| Xác minh ISO | `verify-minos.sh`, `tools/test_xorriso_uefi.sh` |

## Quy trình xác minh bắt buộc

Sau build thành công, chạy `xorriso -report_el_torito plain`, liệt kê file ISO, và kiểm tra kernel/initrd `/live` trước khi boot. Sau đó boot một lần bằng QEMU BIOS và một lần bằng QEMU + OVMF UEFI với Secure Boot off. Việc menu chỉ có một entry không miễn trừ kiểm thử launcher Calamares trong Live session.

## References

[1]: https://manpages.ubuntu.com/manpages/noble/man7/live-build.7.html "Ubuntu Noble live-build manual"
