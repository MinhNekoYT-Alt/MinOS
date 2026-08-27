# Định hướng thiết kế — MinOS Desktop

## Ba hướng cân nhắc

### 1. Northern Signal

**Very Brief Intro:** Giao diện đêm xanh than với các mảng thông tin chính xác như một màn hình khởi động hệ điều hành. Cảm giác tin cậy, bình tĩnh và kỹ thuật nhưng không nặng nề.

**Probability:** 0.071

### 2. Paper Terminal

**Very Brief Intro:** Chủ nghĩa biên tập tối giản, đặt typography và nhịp đọc lên trước hình ảnh. Phù hợp một dự án hệ điều hành cộng đồng có giọng điệu minh bạch.

**Probability:** 0.048

### 3. Arctic Workshop

**Very Brief Intro:** Không gian tối có chiều sâu vật liệu, lấy cảm hứng từ xưởng chế tác phần mềm và bầu trời cực quang xa. Các yếu tố thương hiệu giống nhãn kỹ thuật được in trên vật liệu thật.

**Probability:** 0.089

## Hướng được chọn: Northern Signal

**Design Movement:** Swiss International Style được diễn giải qua giao diện hệ điều hành đương đại và kỹ thuật information-design.

**Core Principles:** Thứ bậc thông tin phải rõ như màn hình boot; nền tối tạo sự tập trung thay vì gây chói; từng khối nội dung có vai trò vận hành cụ thể; chi tiết thương hiệu xuất hiện như tín hiệu định hướng chứ không phải trang trí ngẫu nhiên.

**Color Philosophy:** Obsidian gần đen làm nền để các thông tin và ảnh wallpaper MinOS nổi lên rõ ràng. Xanh glacier là màu tín hiệu mang ý nghĩa “sẵn sàng / an toàn / được chọn”; trắng ấm chỉ dùng cho nội dung quan trọng, tránh gradient tím và neon.

**Layout Paradigm:** Bố cục theo một “signal rail” dọc lệch trái, dẫn người đọc từ lời hứa thương hiệu sang trạng thái build và tải xuống. Các đoạn băng ngang có chiều rộng không đồng đều, phản chiếu panel hệ điều hành thay vì lưới thẻ đồng đều.

**Signature Elements:** Thanh tín hiệu xanh chạy dọc; nhãn tọa độ kỹ thuật dạng monospaced; hình penguin/MinOS tròn lớn như beacon nhận diện.

**Interaction Philosophy:** Mỗi tương tác là phản hồi rõ và gọn: nút nén nhẹ khi nhấn, liên kết gạch chân chuyển động theo chiều tín hiệu, bộ chuyển EN/VI đổi nội dung tức thì mà không che mất ngữ cảnh.

**Animation:** Fade-up 180–260ms với `cubic-bezier(0.23, 1, 0.32, 1)`, các nhóm nội dung lệch nhau 45ms. Không có motion nền liên tục; trạng thái reduced-motion tắt toàn bộ entrance và hiệu ứng dịch chuyển.

**Typography System:** Space Grotesk cho heading với weight 500–700 và IBM Plex Mono cho nhãn kỹ thuật / số liệu. Nội dung dùng system sans dễ đọc, khoảng chữ heading chặt, body thoáng.

**Brand Essence:** MinOS Desktop là Ubuntu 24.04 KDE Plasma tinh gọn dành cho người muốn một desktop rõ ràng, có branding nhất quán và quyền kiểm soát cập nhật. **Personality:** chính xác, điềm tĩnh, thực tế.

**Brand Voice:** Câu ngắn, có chủ thể rõ ràng và không hứa hẹn vô căn cứ. Headline nói về khả năng cấu hình; CTA nói đúng hành động. Ví dụ: “A clear desktop, built on Ubuntu.” và “Read the build status before you download.”

**Wordmark & Logo:** Mark là huy hiệu penguin cách điệu với đường viền glacier; wordmark chữ MINOS có tracking rộng, hai chấm tín hiệu nhỏ đặt sau chữ S thay vì dùng font mặc định một cách thụ động.

**Signature Brand Color:** **Signal Glacier — #5DE1FF**.
