# Quy tắc Nghiệp vụ — AutoWash Pro (Phiên bản đầy đủ 100 quy tắc)

> Tài liệu này mô tả toàn bộ 100 quy tắc nghiệp vụ của hệ thống quản lý rửa xe AutoWash Pro, được phân loại theo từng nhóm chức năng.

---

## 1. Quy tắc Tài khoản & Khách hàng

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-01 | Một tài khoản khách hàng bắt buộc phải gắn liền với ít nhất một Số điện thoại và một Biển số xe. Hệ thống dùng Biển số xe làm khóa chính để tự động nhận diện tại trạm. | Hệ thống | Cao | Biển số xe là định danh chính |
| BR-02 | Một khách hàng có thể sở hữu nhiều phương tiện. | Hệ thống | Trung bình | Quan hệ 1-n giữa khách hàng và phương tiện |
| BR-03 | Mỗi phương tiện phải có biển số hợp lệ. | Hệ thống | Cao | Validate định dạng biển số |
| BR-05 | Khách hàng phải đăng nhập để tạo booking. | Hệ thống | Cao | Yêu cầu xác thực trước khi đặt lịch |
| BR-06 | Khách hàng chỉ có một loyalty tier tại một thời điểm. | Hệ thống | Cao | Không được giữ nhiều tier đồng thời |
| BR-07 | Tier của khách được xét lại hàng tháng. | Hệ thống | Trung bình | Đánh giá lại vào đầu mỗi tháng |
| BR-08 | Khách hàng mới mặc định thuộc tier "Member". | Hệ thống | Cao | Tier khởi điểm cho tài khoản mới |
| BR-09 | Khách hàng có thể cập nhật thông tin cá nhân. | Hệ thống | Thấp | Cho phép chỉnh sửa hồ sơ |
| BR-10 | Khách hàng phải xác minh số điện thoại khi đăng ký. | Hệ thống | Cao | Xác minh qua OTP |

---

## 2. Quy tắc Đặt lịch (Booking)

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-11 | Mỗi booking phải thuộc một chi nhánh cụ thể. | Hệ thống | Cao | Bắt buộc chọn chi nhánh khi đặt lịch |
| BR-12 | Khách hàng không được tạo hai booking cùng thời điểm. | Hệ thống | Cao | Tránh trùng lịch cho cùng một khách |
| BR-14 | Một time slot có giới hạn số lượng xe tối đa. | Hệ thống | Cao | Dựa trên capacity của chi nhánh |
| BR-15 | Booking phải có ít nhất một dịch vụ. | Hệ thống | Cao | Không cho phép booking rỗng |
| BR-16 | Khách hàng có thể chọn nhiều add-on services. | Hệ thống | Trung bình | Dịch vụ bổ sung tùy chọn |
| BR-17 | Booking có thể kèm ghi chú đặc biệt. | Hệ thống | Thấp | Ghi chú yêu cầu riêng của khách |
| BR-18 | Khách hàng có thể hủy và chỉnh sửa booking trước giờ hẹn tối thiểu 1 tiếng. | Hệ thống | Cao | Giới hạn thời gian hủy/sửa |
| BR-19 | Booking quá giờ hẹn 15 phút sẽ bị đánh dấu "Late". | Hệ thống | Trung bình | Tự động cập nhật trạng thái trễ |
| BR-20 | Booking có các trạng thái: Pending, Confirmed, Washing, Completed, Cancelled. | Hệ thống | Cao | Quản lý vòng đời booking |

---

## 3. Quy tắc Tích điểm (Loyalty Points)

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-21 | Khách hàng nhận loyalty points sau khi booking hoàn thành. | Hệ thống | Cao | Chỉ tính điểm khi hoàn tất dịch vụ |
| BR-22 | Points được tính dựa trên số tiền thanh toán cuối cùng. | Hệ thống | Cao | Sau khi trừ khuyến mãi và voucher |
| BR-23 | Points hết hạn sau 12 tháng. | Hệ thống | Cao | Tính từ ngày tích lũy |
| BR-24 | Khách hàng không được sử dụng vượt số points hiện có. | Hệ thống | Cao | Kiểm tra số dư trước khi đổi |
| BR-25 | Mỗi reward yêu cầu số points tối thiểu. | Hệ thống | Cao | Ngưỡng điểm tối thiểu cho từng phần thưởng |
| BR-26 | Reward redemption phải được lưu transaction log. | Hệ thống | Cao | Đảm bảo truy vết giao dịch đổi thưởng |
| BR-60 | Mỗi 10,000 VNĐ = 1 điểm. | Hệ thống | Cao | Tỷ lệ quy đổi chuẩn |

---

## 4. Quy tắc Hạng thành viên (Tier)

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-27 | Nâng cấp bậc dựa trên mức chi tiêu. | Hệ thống | Cao | Tổng chi tiêu tích lũy quyết định tier |
| BR-28 | Tier downgrade xảy ra nếu khách không đạt điều kiện duy trì. | Hệ thống | Trung bình | Đánh giá điều kiện duy trì hàng tháng |
| BR-30 | Hệ thống phải lưu lịch sử thay đổi tier. | Hệ thống | Cao | Audit trail cho tier changes |
| BR-31 | Member được booking trước tối đa 7 ngày. | Hệ thống | Cao | Giới hạn đặt lịch trước cho Member |
| BR-32 | Silver được booking trước tối đa 10 ngày. | Hệ thống | Cao | Giới hạn đặt lịch trước cho Silver |
| BR-33 | Gold được booking trước tối đa 12 ngày. | Hệ thống | Cao | Giới hạn đặt lịch trước cho Gold |
| BR-34 | Platinum được booking trước tối đa 14 ngày. | Hệ thống | Cao | Giới hạn đặt lịch trước cho Platinum |
| BR-35 | Hàng chờ ưu tiên: Cấp bậc cao hơn = được ưu tiên sớm hơn. | Hệ thống | Cao | Platinum > Gold > Silver > Member |
| BR-36 | Khách hàng có thể giữ hoặc trừ point cho thanh toán. | Hệ thống | Trung bình | Tùy chọn sử dụng điểm khi thanh toán |
| BR-37 | Mỗi tier có reward riêng. | Hệ thống | Trung bình | Danh mục phần thưởng theo tier |
| BR-38 | Khách hàng chỉ được hưởng benefit của tier hiện tại. | Hệ thống | Cao | Không hưởng benefit tier trước/sau |
| BR-39 | Tier calculation được thực hiện tự động mỗi tháng. | Hệ thống | Cao | Cronjob xử lý tự động |
| BR-40 | Tier changes phải gửi notification cho khách hàng. | Hệ thống | Trung bình | Thông báo qua app/SMS |

---

## 5. Quy tắc Quản trị & Khuyến mãi

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-41 | Chỉ Admin được tạo/chỉnh sửa chương trình khuyến mãi. | Hệ thống | Cao | Phân quyền quản trị khuyến mãi |
| BR-42 | Nhân viên không được sửa điểm khách hàng thủ công. | Hệ thống | Cao | Chống gian lận điểm thưởng |
| BR-43 | Mọi thay đổi điểm và voucher phải lưu audit log. | Hệ thống | Cao | Truy vết mọi thao tác |
| BR-44 | Hệ thống tự động backup dữ liệu mỗi ngày. | Hệ thống | Cao | Backup tự động hàng ngày |

---

## 6. Quy tắc Đánh giá & Phản hồi

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-45 | Chỉ khách đã hoàn thành dịch vụ mới được đánh giá. | Hệ thống | Cao | Trạng thái booking phải là Completed |
| BR-46 | Mỗi booking chỉ được đánh giá 1 lần. | Hệ thống | Trung bình | Không cho phép đánh giá trùng lặp |
| BR-47 | Đánh giá dưới 3 sao, hệ thống gửi cảnh báo cho quản lý. | Hệ thống | Cao | Cảnh báo tự động cho feedback tiêu cực |

---

## 7. Quy tắc Giữ chân khách & Voucher

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-48 | Khách hàng có ≥ 5 lần sử dụng/tháng, nhận voucher giảm giá tháng tiếp theo. | Hệ thống | Trung bình | Khuyến khích khách hàng trung thành |
| BR-50 | Khách VIP lâu không quay lại (>30 ngày), hệ thống gửi ưu đãi giữ chân. | Hệ thống | Trung bình | Chiến lược giữ chân khách VIP |
| BR-52 | Một đơn hàng chỉ áp dụng tối đa 1 voucher, 1 ưu đãi thành viên. | Hệ thống | Cao | Giới hạn cộng dồn ưu đãi |
| BR-53 | Voucher có ngày hết hạn. | Hệ thống | Cao | Bắt buộc có expiry date |
| BR-54 | Voucher hết hạn không được gia hạn tự động. | Hệ thống | Cao | Không auto-renew voucher |
| BR-55 | Khuyến mãi không áp dụng cho dịch vụ đã giảm giá. | Hệ thống | Cao | Tránh giảm giá chồng giảm giá |
| BR-56 | Hệ thống tự động kiểm tra điều kiện trước khi áp dụng mã. | Hệ thống | Cao | Validate mã khuyến mãi tự động |
| BR-59 | Khuyến mãi hạng thành viên không cộng dồn. | Hệ thống | Cao | Chỉ áp dụng một ưu đãi tier |

---

## 8. Quy tắc Nhân sự & Chấm công

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-61 | Mỗi nhân viên thuộc một branch chính. | Hệ thống | Cao | Gắn nhân viên với chi nhánh |
| BR-62 | Nhân viên phải có employment type. | Hệ thống | Cao | Bắt buộc phân loại nhân viên |
| BR-63 | Employment type gồm: Part-time, Full-time. | Hệ thống | Trung bình | Hai loại hình nhân viên |
| BR-64 | Nhân viên phải check-in/check-out mỗi ca làm. | Hệ thống | Cao | Bắt buộc chấm công |
| BR-65 | Attendance logs phải lưu thời gian thực tế. | Hệ thống | Cao | Ghi nhận giờ vào/ra thực tế |
| BR-66 | Nhân viên không check-in sẽ bị đánh absent. | Hệ thống | Cao | Tự động đánh vắng mặt |
| BR-68 | Part-time staff bị giới hạn số giờ làm mỗi tháng. | Hệ thống | Trung bình | Tuân thủ quy định lao động |
| BR-69 | Probation staff chưa được hưởng incentive bonus. | Hệ thống | Trung bình | Chỉ áp dụng sau khi qua thử việc |
| BR-70 | Branch manager có thể xem attendance summary. | Hệ thống | Trung bình | Quyền xem báo cáo chấm công |
| BR-71 | Mỗi shift phải có start time và end time. | Hệ thống | Cao | Bắt buộc định nghĩa thời gian ca |
| BR-72 | Nhân viên không được nhận hai shift trùng thời gian. | Hệ thống | Cao | Tránh xung đột ca làm |
| BR-73 | Attendance records không được xóa vật lý. | Hệ thống | Cao | Chỉ soft delete, bảo toàn dữ liệu |
| BR-74 | Hệ thống tự động tính tổng giờ làm. | Hệ thống | Cao | Tính toán tự động từ attendance logs |
| BR-75 | Overtime phải được đánh dấu riêng. | Hệ thống | Trung bình | Phân biệt giờ thường và tăng ca |
| BR-76 | Attendance summary được tổng hợp hàng tháng. | Hệ thống | Trung bình | Báo cáo tổng hợp cuối tháng |
| BR-77 | Nhân viên nghỉ phép phải được admin phê duyệt. | Hệ thống | Cao | Quy trình duyệt nghỉ phép |
| BR-78 | Late attendance phải hiển thị trên dashboard. | Hệ thống | Trung bình | Cảnh báo đi trễ trên bảng điều khiển |
| BR-80 | Attendance data phải được backup định kỳ. | Hệ thống | Cao | Backup dữ liệu chấm công |

---

## 9. Quy tắc Quản lý Chi nhánh (Branch)

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-81 | Mỗi branch có capacity riêng. | Hệ thống | Trung bình | Sức chứa tối đa theo chi nhánh |
| BR-82 | Branch manager chỉ được truy cập dữ liệu branch mình. | Hệ thống | Cao | Phân quyền truy cập dữ liệu |
| BR-83 | Khách hàng có thể booking nhiều branch khác nhau. | Hệ thống | Trung bình | Không ràng buộc khách với một chi nhánh |
| BR-84 | Booking history phải lưu branch information. | Hệ thống | Cao | Truy vết chi nhánh trong lịch sử |
| BR-85 | Mỗi branch có service availability riêng. | Hệ thống | Trung bình | Danh mục dịch vụ theo chi nhánh |
| BR-86 | Branch revenue phải được thống kê riêng. | Hệ thống | Cao | Báo cáo doanh thu theo chi nhánh |
| BR-87 | Branch có operating hours riêng. | Hệ thống | Trung bình | Giờ hoạt động tùy chi nhánh |
| BR-88 | Admin có thể activate/deactivate branch. | Quản trị viên | Trung bình | Quản lý trạng thái chi nhánh |
| BR-89 | Mỗi branch có staff list riêng. | Hệ thống | Trung bình | Danh sách nhân viên theo chi nhánh |
| BR-90 | Promotion có thể áp dụng theo branch. | Hệ thống | Trung bình | Khuyến mãi riêng từng chi nhánh |

---

## 10. Quy tắc Bảo mật & Tuân thủ

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|----|---------|-----------|---------|---------|
| BR-91 | Password phải được mã hóa trước khi lưu database. | Hệ thống | Cao | Sử dụng hashing algorithm (bcrypt) |
| BR-92 | Người dùng chỉ truy cập được chức năng theo role. | Hệ thống | Cao | Role-based access control (RBAC) |
| BR-93 | Hệ thống phải lưu audit logs cho transaction quan trọng. | Hệ thống | Cao | Ghi nhận mọi giao dịch quan trọng |
| BR-94 | Mọi loyalty transaction phải traceable. | Hệ thống | Cao | Đảm bảo truy vết giao dịch điểm |
| BR-95 | Booking data phải được đồng bộ giữa các branch. | Hệ thống | Cao | Đồng bộ dữ liệu realtime |
| BR-97 | Hệ thống phải xử lý concurrent booking để tránh overbooking. | Hệ thống | Cao | Xử lý đồng thời, tránh quá tải |
| BR-98 | Behavioral logs phải được lưu cho analytics. | Hệ thống | Trung bình | Thu thập dữ liệu hành vi khách hàng |
| BR-99 | System admin có toàn quyền quản trị hệ thống. | Hệ thống | Cao | Quyền cao nhất trong hệ thống |
| BR-100 | Dữ liệu khách hàng không được chia sẻ cho bên thứ ba nếu chưa được cho phép. | Hệ thống | Cao | Tuân thủ quy định bảo mật dữ liệu |

---

## Ngoài phạm vi (Out of Scope)

Các hạng mục sau **không** nằm trong phạm vi nghiệp vụ của hệ thống AutoWash Pro:

| # | Hạng mục ngoài phạm vi | Lý do |
|---|------------------------|-------|
| 1 | Xây dựng và tích hợp cổng thanh toán trực tuyến. | Sử dụng dịch vụ bên thứ ba, không phát triển nội bộ. |
| 2 | Xử lý các nghiệp vụ hoàn tiền tài chính và bồi hoàn giao dịch. | Thuộc phạm vi nghiệp vụ tài chính, nằm ngoài hệ thống quản lý rửa xe. |
