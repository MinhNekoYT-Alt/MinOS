# Repository Linux Mint Zena

MinOS sử dụng lớp distribution desktop của **Linux Mint 22.3 Zena** trên nền package base Ubuntu Noble. Repository Linux Mint chính thức liệt kê `mintupdate` phiên bản 7.1.4, cùng `mintinstall`, `mintdrivers`, `mintwelcome`, `mint-themes`, `mint-y-icons`, Warpinator và WebApp Manager trong release Zena.[1]

Keyring release `linuxmint-keyring` 2022.06.21 đã được tải qua một mirror HTTPS của Linux Mint, kiểm tra metadata package và trích key public. Fingerprint cần được giữ là:

> `302F 0738 F465 C153 5761 F965 A661 6109 451B BBF2` — Linux Mint Repository Signing Key.

| Source | Cấu hình MinOS |
| --- | --- |
| Ubuntu | Noble: `main restricted universe multiverse` cho kernel, driver và phần lớn binary packages |
| Linux Mint | Zena: `main upstream import backport` cho distribution layer Mint như `mintupdate` |
| Signing | Keyring binary trong `config/archives/linuxmint.key.chroot`; không dùng `trusted=yes` |
| Update policy | `mintupdate` thông báo khi có metadata mới; chỉ user thao tác trong UI mới bắt đầu cài đặt |

Tài liệu User Guide của Linux Mint xác nhận Update Manager quản lý software/security updates, trình bày kernel riêng và có `mintupdate-cli` cho kịch bản automation. MinOS chỉ dùng application GUI `mintupdate` và notification của nó; **không** gọi `mintupdate-cli upgrade`, `apt upgrade`, `pkcon update` hoặc `curl` tự động. Timeshift được giữ trong image để người dùng có thể tạo snapshot và khôi phục hệ điều hành nếu update gây regression; snapshot không bao gồm dữ liệu cá nhân.[4]

## References

[1]: http://packages.linuxmint.com/list.php?release=Zena "Linux Mint Zena repository package list"
[2]: http://packages.linuxmint.com/search.php?keyword=mintupdate "Linux Mint repository: mintupdate search"
[3]: http://packages.linuxmint.com/search.php?keyword=linuxmint-keyring "Linux Mint repository: linuxmint-keyring search"
[4]: https://linuxmint-user-guide.readthedocs.io/en/latest/mintupdate.html "Linux Mint User Guide: Update Manager"
