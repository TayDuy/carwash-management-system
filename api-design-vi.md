# Thiết kế API (REST) — AutoWash Pro

Tài liệu này mô tả các API Endpoint dạng REST dành cho dự án AutoWash Pro. Dữ liệu truyền tải sử dụng định dạng JSON qua giao thức bảo mật HTTPS. Phương thức xác thực: JWT (Bearer Token).

## Quy ước Chung (Common Conventions)
- **Base URL (Đường dẫn gốc):** `/api/v1`
- **Phân trang (Pagination):** Sử dụng các tham số `page` (trang hiện tại), `per_page` (số bản ghi trên mỗi trang). Cấu trúc phản hồi sẽ luôn bao gồm metadata dạng: `meta {total, page, per_page}`.
- **Định dạng lỗi (Error format):** `{"error":{"code": mã_lỗi, "message": "thông điệp lỗi", "details": { chi tiết lỗi nếu có }}}`
- **Định dạng thời gian (Timestamps):** Chuẩn ISO-8601 múi giờ UTC.
- **Bảo mật:** Tất cả các API thay đổi dữ liệu (Ghi/Xóa/Sửa) bắt buộc phải truyền Header: `Authorization: Bearer <token>`.

---

## Các API cụ thể của AutoWash Pro (SU26SWP01)

### 1. Xác thực tài khoản (Authentication)
*   `POST /api/v1/auth/register`
    *   *Chức năng:* Đăng ký tài khoản khách hàng mới.
    *   *Tham số truyền vào (Body JSON):* `{name, phone, password}` (Tên, Số điện thoại, Mật khẩu).
*   `POST /api/v1/auth/login`
    *   *Chức năng:* Đăng nhập vào hệ thống.
    *   *Tham số truyền vào (Body JSON):* `{phone, password}` (Số điện thoại, Mật khẩu).
    *   *Kết quả phản hồi:* Trả về `{token}` (Mã bảo mật JWT để sử dụng cho các API tiếp theo).

### 2. Khách hàng & Quản lý xe (Customer / Vehicle)
*   `GET /api/v1/customers/me`
    *   *Chức năng:* Lấy thông tin cá nhân chi tiết của khách hàng hiện tại (sau khi đã đăng nhập).
*   `PUT /api/v1/customers/me`
    *   *Chức năng:* Cập nhật thông tin cá nhân của khách hàng hiện tại.
*   `POST /api/v1/customers/vehicles`
    *   *Chức năng:* Thêm thông tin xe mới vào tài khoản.
    *   *Tham số truyền vào (Body JSON):* `{plate, vehicle_type}` (Biển số xe, Loại xe gồm `car` hoặc `motorbike`).
*   `GET /api/v1/customers/vehicles`
    *   *Chức năng:* Lấy danh sách các xe đã được đăng ký trong tài khoản của khách hàng.

### 3. Đặt lịch rửa xe (Booking)
*   `GET /api/v1/bookings?vehicle_id=&start=&end=&tier=`
    *   *Chức năng:* Lấy danh sách các slot đặt lịch trống, lọc theo xe, thời gian bắt đầu/kết thúc và hạng thành viên của khách để áp dụng quyền ưu tiên.
*   `POST /api/v1/bookings`
    *   *Chức năng:* Tạo mới một đơn đặt lịch rửa xe.
    *   *Tham số truyền vào (Body JSON):* `{vehicle_id, slot_id, payment_ref?}` (Mã xe, Mã slot rửa, Mã tham chiếu thanh toán nếu có).
*   `GET /api/v1/bookings/{id}`
    *   *Chức năng:* Xem chi tiết thông tin một đơn đặt lịch theo Mã ID đơn hàng.
*   `DELETE /api/v1/bookings/{id}`
    *   *Chức năng:* Hủy đơn đặt lịch rửa xe đã tạo theo Mã ID.

### 4. Điểm thành viên & Hạng thành viên (Loyalty & Tiers)
*   `GET /api/v1/loyalty/balance`
    *   *Chức năng:* Xem số dư điểm thưởng thành viên hiện tại của khách hàng.
*   `GET /api/v1/loyalty/history`
    *   *Chức năng:* Xem lịch sử tích điểm và đổi điểm của khách hàng (lịch sử giao dịch điểm).
*   `POST /api/v1/loyalty/redeem`
    *   *Chức năng:* Thực hiện quy đổi điểm thưởng lấy ưu đãi (giảm giá hóa đơn, dịch vụ miễn phí...).
    *   *Tham số truyền vào (Body JSON):* `{type, amount, target}` (Loại quy đổi, Số lượng điểm quy đổi, Đối tượng áp dụng).
*   `GET /api/v1/tiers`
    *   *Chức năng:* Xem danh sách tất cả các hạng thành viên hiện có trong hệ thống (Member, Silver, Gold, Platinum) kèm theo các điều kiện thăng hạng.
*   `PUT /api/v1/admin/tiers/{id}`
    *   *Chức năng:* Cập nhật cấu hình của một hạng thành viên (chỉ dành cho tài khoản Admin).

### 5. Quản trị & Phân tích (Admin & Analytics)
*   `GET /api/v1/admin/promotions`
    *   *Chức năng:* Lấy danh sách tất cả các chương trình khuyến mãi hiện có (chỉ dành cho tài khoản Admin).
*   `POST /api/v1/admin/promotions`
    *   *Chức năng:* Tạo mới một chiến dịch khuyến mãi hoặc ưu đãi đặc biệt (chỉ dành cho tài khoản Admin).
*   `GET /api/v1/admin/analytics/kpis?from=&to=`
    *   *Chức năng:* Truy vấn dữ liệu thống kê, biểu đồ doanh thu và các chỉ số vận hành chính (KPIs) trong một khoảng thời gian (chỉ dành cho tài khoản Admin).

---

**⚠️ Lưu ý quan trọng khi triển khai code Backend:**
*   Khi tạo đơn đặt lịch (`Booking`), bắt buộc code Backend phải kiểm tra xem khách hàng có đặt slot nằm trong phạm vi thời gian cho phép của hạng thành viên của họ hay không (FR-1.1).
*   Giao dịch đổi điểm thành viên (`Loyalty Redemption`) phải thực hiện cơ chế đồng thời (atomic transaction) để tránh tình trạng trừ điểm sai sót khi có nhiều yêu cầu xử lý cùng lúc.
