# Ghi chú nghiên cứu boot

1. Tài liệu Ubuntu về casper mô tả tham số `quiet splash` trên dòng kernel/isolinux để giảm thông tin hiển thị trong lúc Live CD khởi động; khi debug thì nên bỏ hai tham số này.[1]
2. Logo firmware của mainboard có thể được firmware UEFI vẽ trước khi bootloader/OS chạy. ISO MinOS không thể xóa phần đó, nhưng GRUB có thể hiển thị splash riêng sau khi được nạp.
3. Nhánh BIOS/legacy dùng bootloader kiểu Syslinux/isolinux trong ISO và có thể dùng ảnh splash riêng. MinOS dùng logo đầy đủ chim cánh cụt kèm wordmark “MinOS”.
4. Live-build hỗ trợ `--grub-splash`, nhưng với `LB_BOOTLOADER=syslinux` nhánh GRUB2 nội bộ bị bỏ qua. Vì vậy bản MinOS dùng `tools/add_uefi_boot.sh` để tạo GRUB standalone và EFI El Torito cho UEFI; BIOS vẫn dùng Syslinux/isolinux với PNG splash tương ứng.

[1]: https://wiki.ubuntu.com/DebuggingCasper "Ubuntu Wiki: DebuggingCasper"
