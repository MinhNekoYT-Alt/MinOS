import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation {
    id: presentation

    function nextSlide() {
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 6500
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.nextSlide()
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Image {
            source: "logo.png"
            width: 250; height: 250
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 42
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 310
            color: "#FFFFFF"
            font.pixelSize: 30
            font.bold: true
            text: "Welcome to MinOS Desktop"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 354
            color: "#9FCBFF"
            font.pixelSize: 18
            text: "Chào mừng đến với MinOS Desktop"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 402
            width: parent.width - 120
            color: "#D9E8FF"
            font.pixelSize: 17
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "A focused Linux Mint Cinnamon desktop built on Ubuntu 24.04 for everyday work, creativity and play.\nMinOS dùng lớp desktop Linux Mint Cinnamon trên nền Ubuntu 24.04, gọn gàng cho công việc, sáng tạo và giải trí."
        }
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 90
            color: "#FFFFFF"
            font.pixelSize: 28
            font.bold: true
            text: "A familiar, focused desktop"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 138
            color: "#9FCBFF"
            font.pixelSize: 17
            text: "Giao diện quen thuộc, nhẹ và tập trung"
        }
        Text {
            anchors.centerIn: parent
            width: parent.width - 170
            color: "#E6F0FF"
            font.pixelSize: 19
            lineHeight: 1.35
            wrapMode: Text.WordWrap
            text: "MinOS uses a lean Cinnamon desktop, shaped by the practical workflow people expect from Ubuntu and Linux Mint.\n\nEnjoy a responsive panel, a branded MinOS Start button, dark visuals and a desktop designed to stay comfortable on modest hardware.\n\nMinOS dùng Cinnamon tinh gọn, có luồng làm việc thực dụng theo hệ sinh thái Ubuntu và Linux Mint, tối ưu cho cả máy cấu hình vừa phải."
        }
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 90
            color: "#FFFFFF"
            font.pixelSize: 28
            font.bold: true
            text: "Try first, install when ready"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 138
            color: "#9FCBFF"
            font.pixelSize: 17
            text: "Dùng thử trước, cài đặt khi sẵn sàng"
        }
        Text {
            anchors.centerIn: parent
            width: parent.width - 170
            color: "#E6F0FF"
            font.pixelSize: 19
            lineHeight: 1.35
            wrapMode: Text.WordWrap
            text: "You can explore the complete Live session without changing your disks. When you are ready, Calamares guides you through installation with support for ext4, Btrfs and XFS.\n\nBạn có thể trải nghiệm Live session mà không thay đổi ổ đĩa. Khi sẵn sàng, Calamares sẽ hướng dẫn cài đặt với ext4, Btrfs hoặc XFS."
        }
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 90
            color: "#FFFFFF"
            font.pixelSize: 28
            font.bold: true
            text: "Ready for everyday apps"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 138
            color: "#9FCBFF"
            font.pixelSize: 17
            text: "Sẵn sàng cho các ứng dụng hằng ngày"
        }
        Text {
            anchors.centerIn: parent
            width: parent.width - 170
            color: "#E6F0FF"
            font.pixelSize: 19
            lineHeight: 1.35
            wrapMode: Text.WordWrap
            text: "MinOS includes Google Chrome, Firefox, VLC, File Roller, Bottles, WPS Office and a Zalo Web launcher. Mint Software Manager includes Flatpak and Flathub for additional applications.\n\nMinOS có sẵn Chrome, Firefox, VLC, File Roller, Bottles, WPS Office và launcher Zalo Web. Trung tâm ứng dụng Mint có Flatpak/Flathub để mở rộng phần mềm."
        }
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 90
            color: "#FFFFFF"
            font.pixelSize: 28
            font.bold: true
            text: "Hardware-aware by design"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 138
            color: "#9FCBFF"
            font.pixelSize: 17
            text: "Tương thích phần cứng theo hướng an toàn"
        }
        Text {
            anchors.centerIn: parent
            width: parent.width - 170
            color: "#E6F0FF"
            font.pixelSize: 19
            lineHeight: 1.35
            wrapMode: Text.WordWrap
            text: "Modern firmware, Ubuntu hardware enablement, Mesa and ubuntu-drivers work together to support common Wi-Fi, graphics and chipset hardware. NVIDIA installation is hardware-aware and requires network access.\n\nMinOS ưu tiên driver phù hợp thay vì ép driver không tương thích. Wi-Fi powersave được tắt mặc định để kết nối ổn định hơn."
        }
    }

    Slide {
        Rectangle { anchors.fill: parent; color: "#07152E" }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 90
            color: "#FFFFFF"
            font.pixelSize: 28
            font.bold: true
            text: "Your computer, your choice"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 138
            color: "#9FCBFF"
            font.pixelSize: 17
            text: "Máy tính của bạn, lựa chọn của bạn"
        }
        Text {
            anchors.centerIn: parent
            width: parent.width - 170
            color: "#E6F0FF"
            font.pixelSize: 19
            lineHeight: 1.35
            wrapMode: Text.WordWrap
            text: "MinOS can coexist with Windows when Windows is installed on another partition or drive. GRUB can detect it and show a boot menu for MinOS Desktop or Windows. Mint Update Manager notifies you about updates; you choose when to review and apply them.\n\nMinOS có thể dùng song song với Windows; GRUB sẽ tạo menu chọn MinOS hoặc Windows khi phát hiện hệ điều hành này. Mint Update Manager thông báo cập nhật, còn bạn quyết định thời điểm cài đặt."
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }
}
