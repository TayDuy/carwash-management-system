# Quy tắc Nghiệp vụ — AutoWash Pro

Tài liệu này liệt kê các quy tắc nghiệp vụ bắt buộc phải áp đặt đối với dự án AutoWash Pro. Mỗi quy tắc bao gồm mã ID, nội dung quy tắc, hình thức áp đặt, mức độ ưu tiên và ghi chú chi tiết.

## Chú giải bảng quy tắc
| Trường | Ý nghĩa |
|---|---|
| ID | Mã định danh duy nhất của quy tắc |
| Scope | Phạm vi áp dụng (Dự án hoặc Toàn cục) |
| Rule | Mô tả nội dung quy tắc nghiệp vụ |
| Enforcement | Hình thức áp đặt (Hệ thống / Quản trị viên / Thủ công) |
| Priority | Mức độ ưu tiên (Cao / Trung bình / Thấp) |

---

## Quy tắc Toàn cục (Global Rules)

| ID | Phạm vi | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|---|---:|---|---|---:|---|
| BR-G1 | Toàn bộ | Tất cả các hành động của người dùng làm thay đổi trạng thái dữ liệu bền vững đều yêu cầu phải xác thực thành công. | Hệ thống | Cao | Sử dụng cơ chế phiên xác thực bằng JWT |
| BR-G2 | Toàn bộ | Nhật ký hệ thống (Audit trail) phải ghi lại thông tin người dùng, mốc thời gian và hành động đối với tất cả sự kiện quan trọng. | Hệ thống | Cao | Lưu trữ trong các bản ghi log chỉ được phép ghi thêm (append-only) |
| BR-G3 | Toàn bộ | Thông tin cá nhân nhạy cảm (PII) phải được mã hóa khi lưu trữ (at-rest) và được làm mờ trên các giao diện người dùng hiển thị công khai. | Hệ thống/Quản trị | Cao | Tuân thủ các quy định pháp luật về bảo vệ dữ liệu cục bộ |

---

## Quy tắc riêng của AutoWash Pro (SU26SWP01)

| ID | Quy tắc | Hình thức | Ưu tiên | Ghi chú |
|---|---|---|---:|---|
| BR-A01 | Điểm thưởng thành viên chỉ được tích lũy dựa trên các lượt rửa xe đã hoàn thành và đã thanh toán thành công. | Hệ thống | Cao | Loại trừ hoàn toàn các đơn đặt lịch bị khách hủy hoặc khách bùng slot (No-show) |
| BR-A02 | Điểm tích lũy sẽ tự động hết hạn sau 12 tháng kể từ ngày được ghi nhận giao dịch tích lũy. | Hệ thống | Cao | Chạy tác vụ tự động (batch job) hàng tháng để rà soát và xóa các điểm hết hạn |
| BR-A03 | Việc nâng hạng hoặc hạ hạng thành viên được thực hiện tự động hàng tháng dựa trên chỉ số chi tiêu của 30 ngày gần nhất. | Hệ thống | Trung bình | Các ngưỡng chi tiêu quy định thăng/hạ hạng có thể cấu hình linh hoạt qua giao diện của Admin |
| BR-A04 | Ưu tiên đặt lịch: thành viên có thứ hạng cao hơn sẽ được phép đặt chỗ trước ở các khung thời gian sớm hơn. | Hệ thống | Cao | Áp đặt trực tiếp thông qua logic kiểm tra trong các câu lệnh truy vấn tìm slot trống |
| BR-A05 | Số điểm quy đổi ưu đãi không được phép vượt quá số dư điểm hiện có trong tài khoản của khách hàng. | Hệ thống | Cao | Áp dụng cơ chế kiểm tra và trừ điểm đồng thời (atomic transaction) để tránh lỗi bất đồng bộ |
| BR-A06 | Tích hợp các cổng thanh toán trực tuyến nằm ngoài phạm vi thực hiện của dự án này. | Quản trị viên | Thấp | Nhóm phát triển sẽ không hiện thực hóa cổng thanh toán hoặc cơ chế xử lý hoàn tiền trực tuyến |

---

## Nằm ngoài phạm vi thực hiện (Out of Scope)
*   Xây dựng và tích hợp cổng thanh toán trực tuyến.
*   Xử lý các nghiệp vụ hoàn tiền tài chính và bồi hoàn giao dịch.
