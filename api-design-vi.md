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

---

### 7. Quản lý Chi nhánh (Branch Management)

#### `GET /api/branches`
*   *Chức năng:* Lấy danh sách tất cả các chi nhánh đang hoạt động.
*   *Xác thực:* Công khai (Public).
*   *Kết quả phản hồi:* `200 OK` — Mảng chứa các đối tượng chi nhánh (id, name, address, capacity, operating_hours, is_active).

#### `GET /api/branches/:id`
*   *Chức năng:* Lấy thông tin chi tiết của một chi nhánh theo ID.
*   *Xác thực:* Đã đăng nhập (Authenticated).
*   *Kết quả phản hồi:* `200 OK` — Đối tượng thông tin chi nhánh.

#### `POST /api/admin/branches`
*   *Chức năng:* Tạo mới một chi nhánh.
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ name, address, capacity, operating_hours }`.
*   *Kết quả phản hồi:* `201 Created`.

#### `PUT /api/admin/branches/:id`
*   *Chức năng:* Cập nhật thông tin chi tiết của một chi nhánh.
*   *Xác thực:* Quản trị viên (Admin).
*   *Kết quả phản hồi:* `200 OK`.

#### `PATCH /api/admin/branches/:id/status`
*   *Chức năng:* Kích hoạt hoặc tạm ngưng hoạt động của một chi nhánh (BR-88).
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ is_active: boolean }`.
*   *Kết quả phản hồi:* `200 OK`.

#### `GET /api/admin/branches/:id/revenue`
*   *Chức năng:* Lấy báo cáo doanh thu của chi nhánh (BR-86).
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Tham số truy vấn (Query):* `period` (lọc theo `daily`, `weekly`, `monthly`).
*   *Kết quả phản hồi:* `200 OK` — Đối tượng chứa dữ liệu doanh thu.

---

### 8. Quản lý Nhân viên (Staff Management)

#### `GET /api/branches/:branchId/staff`
*   *Chức năng:* Lấy danh sách nhân viên của một chi nhánh (BR-89).
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Kết quả phản hồi:* `200 OK` — Mảng chứa các đối tượng nhân viên.

#### `POST /api/admin/staff`
*   *Chức năng:* Đăng ký thông tin cho một nhân viên mới (BR-61, BR-62).
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ user_id, branch_id, employment_type, probation_end_date? }`.
*   *Kết quả phản hồi:* `201 Created`.

#### `PUT /api/admin/staff/:id`
*   *Chức năng:* Cập nhật thông tin chi tiết của nhân viên.
*   *Xác thực:* Quản trị viên (Admin).
*   *Kết quả phản hồi:* `200 OK`.

---

### 9. Ca làm & Chấm công (Shift & Attendance)

#### `POST /api/admin/shifts`
*   *Chức năng:* Tạo mới và phân lịch ca làm việc cho nhân viên (BR-71, BR-72).
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Tham số truyền vào (Body JSON):* `{ staff_id, branch_id, start_time, end_time }`.
*   *Ràng buộc kiểm tra (Validation):* Không được phân trùng ca làm việc cho cùng một nhân viên trong cùng một khung giờ.
*   *Kết quả phản hồi:* `201 Created`.

#### `GET /api/branches/:branchId/shifts`
*   *Chức năng:* Lấy danh sách các ca làm việc của một chi nhánh.
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Tham số truy vấn (Query):* `date`, `staff_id`.
*   *Kết quả phản hồi:* `200 OK`.

#### `POST /api/attendance/check-in`
*   *Chức năng:* Nhân viên thực hiện Check-in vào ca làm (BR-64, BR-65).
*   *Xác thực:* Nhân viên (Staff).
*   *Tham số truyền vào (Body JSON):* `{ shift_id }`.
*   *Kết quả phản hồi:* `200 OK` — Hệ thống ghi nhận lại thời gian thực tế bắt đầu ca làm.

#### `POST /api/attendance/check-out`
*   *Chức năng:* Nhân viên thực hiện Check-out khi hết ca (BR-64, BR-65).
*   *Xác thực:* Nhân viên (Staff).
*   *Tham số truyền vào (Body JSON):* `{ shift_id }`.
*   *Kết quả phản hồi:* `200 OK` — Hệ thống ghi nhận lại thời gian thực tế kết thúc ca làm và tự động tính toán tổng số giờ làm việc thực tế.

#### `GET /api/branches/:branchId/attendance/summary`
*   *Chức năng:* Lấy báo cáo tổng hợp tình hình chấm công hàng tháng của chi nhánh (BR-70, BR-76).
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Tham số truy vấn (Query):* `month`, `year`.
*   *Kết quả phản hồi:* `200 OK` — Báo cáo tổng hợp số giờ làm việc, số giờ tăng ca (overtime), số ngày vắng (absences), và các lần đi trễ.

#### `POST /api/admin/leave-requests`
*   *Chức năng:* Nhân viên nộp đơn xin nghỉ phép (BR-77).
*   *Xác thực:* Nhân viên (Staff).
*   *Tham số truyền vào (Body JSON):* `{ shift_id, reason }`.
*   *Kết quả phản hồi:* `201 Created`.

#### `PATCH /api/admin/leave-requests/:id`
*   *Chức năng:* Quản trị viên phê duyệt hoặc từ chối đơn xin nghỉ phép (BR-77).
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ status: approved|rejected }`.
*   *Kết quả phản hồi:* `200 OK`.

---

### 10. Đánh giá & Phản hồi (Reviews)

#### `POST /api/bookings/:bookingId/reviews`
*   *Chức năng:* Khách hàng gửi đánh giá cho đơn đặt lịch đã hoàn thành (BR-45, BR-46).
*   *Xác thực:* Khách hàng (Customer).
*   *Tham số truyền vào (Body JSON):* `{ rating (1-5), comment? }`.
*   *Ràng buộc kiểm tra (Validation):* Đơn đặt lịch bắt buộc phải ở trạng thái Completed. Mỗi đơn đặt lịch chỉ được phép đánh giá tối đa 1 lần.
*   *Tác vụ đi kèm (Side Effect):* Nếu đánh giá dưới 3 sao (rating < 3), hệ thống sẽ gửi một thông báo cảnh báo tới Quản lý chi nhánh (BR-47).
*   *Kết quả phản hồi:* `201 Created`.

#### `GET /api/bookings/:bookingId/reviews`
*   *Chức năng:* Lấy thông tin đánh giá của một đơn đặt lịch.
*   *Xác thực:* Đã đăng nhập (Authenticated).
*   *Kết quả phản hồi:* `200 OK` — Đối tượng chứa thông tin đánh giá hoặc 404.

#### `GET /api/branches/:branchId/reviews`
*   *Chức năng:* Lấy danh sách tất cả các đánh giá của một chi nhánh.
*   *Xác thực:* Quản trị viên (Admin) / Quản lý chi nhánh (Branch Manager).
*   *Tham số truy vấn (Query):* `min_rating`, `max_rating`, `page`, `limit`.
*   *Kết quả phản hồi:* `200 OK` — Mảng danh sách đánh giá có phân trang.

---

### 11. Mã giảm giá & Khuyến mãi (Vouchers & Promotions)

#### `GET /api/customers/:customerId/vouchers`
*   *Chức năng:* Lấy danh sách các mã giảm giá (voucher) đang hoạt động của khách hàng.
*   *Xác thực:* Khách hàng (Customer).
*   *Kết quả phản hồi:* `200 OK` — Mảng chứa các đối tượng mã giảm giá.

#### `POST /api/vouchers/validate`
*   *Chức năng:* Kiểm tra và xác thực tính hợp lệ của mã giảm giá trước khi áp dụng vào đơn đặt lịch (BR-56).
*   *Xác thực:* Đã đăng nhập (Authenticated).
*   *Tham số truyền vào (Body JSON):* `{ code, order_total, services[] }`.
*   *Ràng buộc kiểm tra (Validation):* Kiểm tra hạn sử dụng (BR-53, BR-54), kiểm tra nguyên tắc không áp dụng trùng lặp giảm giá (BR-55) và các quy tắc áp dụng ưu đãi cộng dồn (BR-59).
*   *Kết quả phản hồi:* `200 OK` — `{ valid, discount_amount, reason? }`.

#### `POST /api/admin/vouchers`
*   *Chức năng:* Tạo mới một mã giảm giá hoặc chương trình ưu đãi (BR-41).
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ code, discount_type, discount_value, min_order_value?, expires_at, customer_id?, branch_id? }`.
*   *Kết quả phản hồi:* `201 Created`.

#### `POST /api/admin/promotions`
*   *Chức năng:* Tạo mới một chiến dịch khuyến mãi diện rộng (BR-41).
*   *Xác thực:* Quản trị viên (Admin).
*   *Tham số truyền vào (Body JSON):* `{ name, description, start_date, end_date, discount_type, discount_value, applicable_branches[], applicable_tiers[] }`.
*   *Kết quả phản hồi:* `201 Created`.
