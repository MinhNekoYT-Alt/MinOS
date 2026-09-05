# 🐧 MinOS Desktop

**© MinhNeko Group** — thuộc quyền sở hữu và phát triển bởi **MinhNeko Group**.

**MinOS Desktop** 💿 là source bundle để dựng một Live ISO **Linux Mint Cinnamon Zena trên nền Ubuntu 24.04 Noble, amd64**. Ubuntu cung cấp kernel, driver và package base; Linux Mint Zena cung cấp lớp desktop/distribution như Cinnamon, `mintupdate`, Software Manager, Warpinator và WebApp Manager.[1] [2] 🚀

> **Trạng thái phát hành:** source đang ở giai đoạn build và kiểm tra boot. Không phát hành ISO như một bản production cho tới khi cả boot BIOS/UEFI, Live desktop và Calamares được kiểm thử trong máy ảo. Không có ISO tải xuống được xác nhận trong repository ở thời điểm này.

| Hạng mục | Thiết kế hiện tại |
| --- | --- |
| Tên image | `MinOS-Desktop-Cinnamon-24.04-amd64.iso` |
| Nền tảng / kiến trúc | Linux Mint 22.3 Zena trên Ubuntu 24.04 Noble / `amd64` |
| Desktop | Cinnamon tinh gọn với Nemo, LightDM, Slick Greeter và icon Mint-Y; không có KDE Plasma runtime |
| Khởi động | ISO hybrid: Syslinux cho BIOS; GRUB EFI standalone hậu xử lý cho UEFI |
| Chế độ sử dụng | Live session và Calamares installer |
| Ngôn ngữ | English (`en_US.UTF-8`) mặc định; gói và locale tiếng Việt được đóng gói để chọn sau đó |
| Ứng dụng nền | Chrome, Firefox, VLC, File Roller, Zalo Web, YouTube/Facebook/TikTok Web Apps, Warpinator, WebApp Manager, Flatpak/Flathub và Timeshift |
| Cài theo lựa chọn | Bottles, WPS Office và Android Studio qua MinOS Software; Waydroid chỉ theo hướng dẫn chính thức có điều kiện |
| Cập nhật | MinOS Update Center mở `mintupdate`; công cụ thông báo update nhưng chỉ cài sau khi người dùng review và xác nhận |

## 📁 Cấu trúc source

`live-build` dùng thư mục cấu hình để tự động hóa và tùy biến quá trình tạo Live image.[1] Source của MinOS giữ package lists trong `config/package-lists/`, file chép vào hệ thống trong `config/includes.chroot/`, và cấu hình binary/boot trong `config/bootloaders/` cùng `config/includes.binary/`. Các bước build được tổ chức qua `auto/config`, `build-minos.sh` và wrapper `build.sh`.

```text
minos/
├── build.sh                         # Lệnh build công khai
├── build-minos.sh                   # Orchestrator: dependency, build, UEFI helper, checksum
├── auto/                            # live-build configuration wrappers
├── assets/                          # Logo và wallpaper nguồn
├── config/
│   ├── archives/                    # Chrome/Mint repositories + binary OpenPGP keyrings
│   ├── bootloaders/                 # Syslinux/isolinux local templates
│   ├── includes.binary/             # BIOS splash và ISO metadata
│   ├── includes.chroot/             # Branding, Calamares, Update Center, locale, Flatpak
│   └── package-lists/               # Common và Cinnamon profile
├── tools/                           # Tạo splash, thêm boot UEFI, test xorriso
└── docs/                            # Ghi chú boot và installer
```

## 🛠️ Dựng ISO

Máy dựng nên là Ubuntu 24.04 `amd64`, có `sudo`, Internet ổn định và dung lượng trống lớn. Script tự cài dependency host gồm `live-build`, `xorriso`, GRUB tools, QEMU và `syslinux-utils` (cung cấp `isohybrid`), sau đó tạo checksum nếu ISO hoàn tất.

```bash
git clone https://github.com/MinhNekoYT-Alt/MinOS.git minos
cd minos
chmod +x build.sh
MINOS_EDITION=cinnamon ./build.sh
```

Chỉ `MINOS_EDITION=cinnamon` hoặc `mint` được hỗ trợ. Kết quả mong đợi là `build/MinOS-Desktop-Cinnamon-24.04-amd64.iso` cùng file `.sha256`. `live-build` phân tách bootstrap, tùy biến chroot và tạo binary image thành các stage riêng, nên log `build/minos-build.log` cần được giữ lại khi báo lỗi.[3]

## ⚙️ GitHub Actions build

Repository có workflow [Build MinOS Desktop ISO](.github/workflows/build-iso.yml). Workflow chạy trên `ubuntu-24.04`, gọi chính `./build.sh`, kiểm tra checksum và xác minh ISO có cả entry BIOS/UEFI trước khi lưu ISO, checksum và log thành artifact của lần chạy. Workflow chỉ build **amd64**, không đưa file ISO nhiều GiB vào Git history. Có thể chạy thủ công từ tab **Actions**, hoặc tự chạy khi thay đổi các file build/branding trên nhánh `main`.

Artifact ISO được giữ 14 ngày trong GitHub Actions. Ngưỡng 4 GiB trong workflow là một điều kiện bảo vệ tính tương thích upload artifact; nếu release tăng vượt ngưỡng, pipeline dừng với lỗi rõ ràng thay vì phát hành một artifact không tải được. Đây là pipeline kiểm tra source và tạo artifact CI, không thay thế thử nghiệm trên phần cứng thật.

## 🖥️ Desktop, ngôn ngữ và ứng dụng

Image cài Cinnamon, Nemo, Cinnamon Control Center, LightDM/Slick Greeter, Mint-Y, Mint Update Manager, **MinOS Software** (Mint Software Manager đã đổi nhãn), Warpinator và WebApp Manager. English là locale mặc định. `language-pack-vi`, GNOME translations tiếng Việt, `vi_VN.UTF-8` và Fcitx5 Unikey được đóng gói như lựa chọn bổ sung; chúng không đổi locale mặc định của Live session.

Flatpak và Flathub system-wide được cấu hình sẵn, nhưng Bottles (`com.usebottles.bottles`), WPS Office (`com.wps.Office`) và Android Studio (`com.google.AndroidStudio`) là các lượt cài **tùy chọn** do người dùng xác nhận trong MinOS Software. Cách này tránh nhúng các runtime lớn vào Live ISO. Zalo, YouTube, Facebook và TikTok có launcher Chrome Web App riêng; không có binary không chính thức được đóng gói. Waydroid không được tự động thêm repository hay tự cài: dự án này cần Wayland session và, với Ubuntu Noble, hướng dẫn chính thức yêu cầu repository Waydroid bổ sung.[6] Flatpak hỗ trợ remote system-wide và per-user; remote system-wide khả dụng với mọi tài khoản.[4]

## 💾 Kiến trúc và tài nguyên

Release hiện tại chỉ tạo **ISO `amd64`**. Không có `arm32` hoặc `arm64`. Yêu cầu bổ sung `amd32` đã được đánh giá nhưng không được bật trong profile này: Ubuntu Noble công bố desktop Live image chính thức cho 64-bit PC và yêu cầu tối thiểu 1024 MiB chỉ để cài image Ubuntu desktop tiêu chuẩn.[7] MinOS là Cinnamon desktop có thêm Calamares, Chrome, driver stack và app catalog; vì vậy dự án không xác nhận rằng **1 core / 1 GB RAM / 5 GB disk** có thể chạy hoặc cài đầy đủ. Kiểm tra thực tế trước phát hành phải dùng môi trường có đủ RAM và dung lượng; xem [docs/requirements.md](docs/requirements.md).

## 🔄 Cập nhật do người dùng quyết định

`minos-update-center` mở `mintupdate`. Update Manager có thể thông báo update khả dụng, nhưng MinOS không gọi `mintupdate-cli upgrade`, `apt upgrade`, `pkcon update`, `flatpak update` hoặc `curl` để tự cài update. Người dùng phải mở Update Center, xem danh sách và xác nhận thao tác trong giao diện. Chính sách này cũng áp dụng cho app Flatpak được cài sau đó.[5]

## 📶 Phần cứng và Wi-Fi

Image bao gồm Linux firmware, firmware SOF, Intel/AMD microcode, Mesa Vulkan/VA-API, `ubuntu-drivers-common`, DKMS, Broadcom STA DKMS và Realtek 8812AU DKMS. Dịch vụ GPU MinOS chỉ chạy trên hệ thống đã cài, bỏ qua Live session, và chỉ yêu cầu `ubuntu-drivers` chọn NVIDIA driver khi có GPU NVIDIA phù hợp. Các driver 8821CE và 88x2BU không có candidate trong Ubuntu Noble nên không được khai báo là cài sẵn. Đây là hỗ trợ cấu hình, **không** là cam kết mọi chipset, Wi-Fi adapter hoặc game Windows sẽ hoạt động.

`/etc/NetworkManager/conf.d/10-minos-wifi-powersave.conf` đặt `wifi.powersave = 2`, tức tắt Wi-Fi powersave cho kết nối do NetworkManager quản lý.

## 💽 Installer và dual boot

Calamares chạy từ Live session, không dùng Debian Installer của live-build. Branding MinOS có slideshow tự lướt qua sáu trang bằng English và tiếng Việt, giới thiệu desktop, Live/installer, app catalog, hardware, Wi-Fi, Windows dual boot và chính sách update.

Sau khi cài, file GRUB `/etc/default/grub.d/99-minos.cfg` bật `GRUB_DISABLE_OS_PROBER=false` và hiển thị menu trong năm giây. `os-prober` có thể phát hiện Windows để `update-grub` tạo mục boot, nhưng việc này chỉ được xác nhận sau thử nghiệm với đĩa Windows thật hoặc VM có Windows; các phân vùng bị mã hóa, không mount được hoặc không cho phép scan có thể không được phát hiện.

## 🎨 Branding boot và giới hạn Secure Boot

BIOS sử dụng Syslinux/isolinux với splash PNG chỉ có mascot chim cánh cụt, không có chữ MinOS, và menu `Welcome to MinOS` / `Start MinOS`. Helper `tools/add_uefi_boot.sh` thêm EFI El Torito image có GRUB dùng nền xanh trích từ wallpaper do người dùng cung cấp, đã loại bỏ toàn bộ mascot và chữ MinOS. Không image ISO nào kiểm soát hoặc bắt buộc được logo hãng do firmware hiển thị trước bootloader. UEFI helper hiện chưa ký, vì vậy Secure Boot phải tắt trong lúc kiểm thử. Xem chi tiết tại [docs/boot.md](docs/boot.md).

## 🔒 Bảo mật dependency bên thứ ba

Chrome stable được cài từ repository Google trong build chroot. Source không dùng `trusted=yes`: `config/archives/google-chrome.key.chroot` là keyring OpenPGP binary được live-build chép vào trust store trước APT update. Các thay đổi về key hoặc repository phải được rà fingerprint, build log và chính sách phân phối của Google trước mỗi release.

## ✅ Kiểm tra trước phát hành

ISO hybrid được thiết kế để dùng từ USB và máy ảo.[3] Trước khi phát hành, cần kiểm tra structural verification, checksum, boot catalog, file `/live`, boot BIOS, boot UEFI (Secure Boot off), Live desktop, Calamares slideshow và install flow. Các bước này chưa được thay thế bằng một claim tương thích trên phần cứng thật.

```bash
./auto/config
./verify-minos.sh
sha256sum build/MinOS-Desktop-Cinnamon-24.04-amd64.iso
xorriso -indev build/MinOS-Desktop-Cinnamon-24.04-amd64.iso -report_el_torito plain
qemu-system-x86_64 -enable-kvm -m 4096 -cdrom build/MinOS-Desktop-Cinnamon-24.04-amd64.iso
```

## 📚 References

[1]: https://linuxmint.com/download_all.php "Linux Mint supported releases and package bases"
[2]: https://www.linuxmint.com/rel_wilma_whatsnew.php "Linux Mint 22 features and Ubuntu 24.04 package base"
[3]: https://manpages.ubuntu.com/manpages/noble/man7/live-build.7.html "Ubuntu Noble live-build manual"
[4]: https://docs.flatpak.org/en/latest/using-flatpak.html "Flatpak documentation: Using Flatpak"
[5]: https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html "Debian Live Manual"
[6]: https://docs.waydro.id/usage/install-on-desktops "Waydroid official desktop installation documentation"
[7]: https://releases.ubuntu.com/noble/ "Ubuntu 24.04 Noble official release images"
