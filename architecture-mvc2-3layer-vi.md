# Kiến trúc MVC2 và 3-Layer trong hệ thống AutoWash Pro

Tài liệu này mô tả cách hệ thống **AutoWash Pro** kết hợp mô hình **MVC2** và **Kiến trúc 3 Lớp (3-Layer Architecture)** sử dụng **Spring Boot (Backend)** và **React / JavaScript (Frontend)**.

## 1. Sự kết hợp giữa MVC2 và 3-Layer
Theo mô hình client-server hiện đại:
- **View (Giao diện):** Được tách biệt hoàn toàn sang Frontend sử dụng **React (JavaScript)**.
- **Controller và Model:** Nằm ở Backend sử dụng **Spring Boot**.
- Bản thân Backend Spring Boot được tổ chức theo **Kiến trúc 3 Lớp** để đảm bảo dễ bảo trì và mở rộng.

## 2. Mô hình 3-Layer (Backend Spring Boot)

### Tầng 1: Presentation Layer (Controller Layer)
- **Nhiệm vụ:** Tiếp nhận HTTP Request từ React, xác thực JWT, validate dữ liệu (DTO), và trả về HTTP Response (JSON). Tầng này không chứa logic nghiệp vụ.
- **Thành phần:** Các class `@RestController`.
- **Ví dụ:** `BookingController`, `AuthController`.

### Tầng 2: Business Logic Layer (Service Layer)
- **Nhiệm vụ:** Xử lý các quy tắc nghiệp vụ cốt lõi (Business Rules), gọi Cache/Message Broker và giao tiếp với Data Access Layer.
- **Thành phần:** Các class `@Service`.
- **Ví dụ:** `BookingService` (kiểm tra giờ trống, trạng thái khách hàng), `LoyaltyService`.

### Tầng 3: Data Access Layer (Repository Layer)
- **Nhiệm vụ:** Giao tiếp trực tiếp với cơ sở dữ liệu PostgreSQL thông qua Spring Data JPA để thực hiện các thao tác CRUD.
- **Thành phần:** Các interface `@Repository` và các `Entity`.
- **Ví dụ:** `BookingRepository`, `CustomerRepository`.

## 3. Cấu trúc thư mục chi tiết theo Domain (Database Entities)

Sơ đồ dưới đây ánh xạ trực tiếp các thực thể từ thiết kế cơ sở dữ liệu (Customers, Vehicles, Tiers, Bookings, LoyaltyPoints, Branches, Staff, Shifts, AttendanceRecords, Reviews, Vouchers) vào mô hình thực tế.

### Backend (Spring Boot - 3-Layer)
```text
backend/
├── src/main/java/com/autowash/pro/
│   ├── AutoWashApplication.java
│   │
│   ├── common/                          (Code dùng chung toàn dự án)
│   │   ├── exceptions/GlobalExceptionHandler.java
│   │   ├── dto/ApiResponse.java         
│   │   └── utils/SecurityUtils.java
│   │
│   ├── security/                        (Xác thực & Phân quyền)
│   │   ├── JwtTokenProvider.java
│   │   └── JwtAuthenticationFilter.java
│   │
│   ├── booking/                         (NGHIỆP VỤ ĐẶT LỊCH - Trọng tâm)
│   │   ├── controller/                  <-- Layer 1
│   │   │   └── BookingController.java   (API: POST /bookings, GET /bookings/{id})
│   │   ├── service/                     <-- Layer 2
│   │   │   ├── BookingService.java
│   │   │   └── impl/BookingServiceImpl.java
│   │   ├── repository/                  <-- Layer 3
│   │   │   └── BookingRepository.java
│   │   ├── entity/                      (Map với bảng Bookings)
│   │   │   └── Booking.java
│   │   └── dto/
│   │       ├── BookingRequestDTO.java
│   │       └── BookingResponseDTO.java
│   │
│   ├── customer/                        (NGHIỆP VỤ KHÁCH HÀNG & XE)
│   │   ├── controller/
│   │   │   ├── CustomerController.java
│   │   │   └── VehicleController.java
│   │   ├── service/
│   │   │   ├── CustomerService.java
│   │   │   └── VehicleService.java
│   │   ├── repository/
│   │   │   ├── CustomerRepository.java
│   │   │   ├── VehicleRepository.java
│   │   │   └── TierRepository.java      (Bảng Tiers - Hạng thành viên)
│   │   ├── entity/
│   │   │   ├── Customer.java
│   │   │   ├── Vehicle.java
│   │   │   └── Tier.java
│   │   └── dto/CustomerProfileDTO.java
│   │
│   ├── branch/                          (NGHIỆP VỤ CHI NHÁNH & NHÂN SỰ)
│   │   ├── controller/
│   │   │   ├── BranchController.java
│   │   │   └── StaffController.java     (Bao gồm cả quản lý Shift & Attendance)
│   │   ├── service/
│   │   │   ├── BranchService.java
│   │   │   └── StaffService.java
│   │   ├── repository/
│   │   │   ├── BranchRepository.java
│   │   │   ├── StaffRepository.java
│   │   │   ├── ShiftRepository.java
│   │   │   └── AttendanceRecordRepository.java
│   │   └── entity/
│   │       ├── Branch.java
│   │       ├── Staff.java
│   │       ├── Shift.java
│   │       └── AttendanceRecord.java
│   │
│   ├── loyalty/                         (NGHIỆP VỤ ĐIỂM THƯỞNG & VOUCHER)
│   │   ├── controller/
│   │   │   ├── LoyaltyController.java
│   │   │   └── VoucherController.java
│   │   ├── service/
│   │   │   ├── LoyaltyService.java
│   │   │   └── VoucherService.java
│   │   ├── repository/
│   │   │   ├── LoyaltyPointsRepository.java
│   │   │   └── VoucherRepository.java
│   │   ├── entity/
│   │   │   ├── LoyaltyPoints.java
│   │   │   └── Voucher.java
│   │   └── event/                       (RabbitMQ Listeners - Asynchronous)
│   │       └── BookingCompletedListener.java (Lắng nghe để cộng điểm tự động)
│   │
│   └── review/                          (NGHIỆP VỤ ĐÁNH GIÁ)
│       ├── controller/ReviewController.java
│       ├── service/ReviewService.java
│       ├── repository/ReviewRepository.java
│       └── entity/Review.java
```

### Frontend (React / JavaScript - Vai trò MVC View)
```text
frontend/
├── src/
│   ├── api/                             (Lớp giao tiếp với Backend)
│   │   ├── axiosClient.js               (Base Axios kèm JWT)
│   │   ├── bookingApi.js                (Gọi API booking/)
│   │   ├── customerApi.js               (Gọi API customer/)
│   │   ├── branchApi.js                 (Gọi API branch/)
│   │   └── loyaltyApi.js                (Gọi API loyalty/)
│   │
│   ├── context/                         (Global State - Giống Model nội bộ của Client)
│   │   ├── AuthContext.jsx              (Lưu Token và thông tin User hiện tại)
│   │   └── BookingFlowContext.jsx       (Lưu state tạm thời khi user đang trải qua nhiều bước đặt lịch)
│   │
│   ├── hooks/                           (Tách logic ra khỏi giao diện)
│   │   ├── useVehicles.js               (Lấy danh sách xe của user)
│   │   └── useAvailableSlots.js         (Lấy slot trống từ backend dựa trên Branch)
│   │
│   ├── components/                      (Thành phần UI chia nhỏ)
│   │   ├── common/                      (Nút, Input, Modal...)
│   │   ├── booking/                     
│   │   │   ├── BranchSelector.jsx       (Giao diện chọn chi nhánh)
│   │   │   ├── TimeSlotPicker.jsx       (Giao diện chọn giờ)
│   │   │   └── VehiclePicker.jsx        (Giao diện chọn xe)
│   │   └── reviews/
│   │       └── StarRating.jsx
│   │
│   ├── pages/                           (CÁC TRANG HIỂN THỊ CHÍNH - Tầng VIEW)
│   │   ├── auth/
│   │   │   └── Login.jsx
│   │   │
│   │   ├── customer/                    (Khu vực User)
│   │   │   ├── Dashboard.jsx            (Xem lịch sắp tới, điểm Loyalty)
│   │   │   ├── MyVehicles.jsx           (Quản lý xe - Thêm/Xóa xe)
│   │   │   └── MyVouchers.jsx
│   │   │
│   │   ├── booking/                     (Luồng đặt lịch chính)
│   │   │   ├── CreateBookingPage.jsx    (Trang đặt lịch mới)
│   │   │   └── BookingSuccessPage.jsx   
│   │   │
│   │   └── admin/                       (Khu vực Quản trị viên & Nhân viên)
│   │       ├── BranchManagement.jsx     (Xem công suất các chi nhánh)
│   │       ├── StaffManagement.jsx      (Quản lý lịch làm việc/Shifts)
│   │       └── AttendanceCheck.jsx      (Chấm công)
│   │
│   ├── routes/
│   │   ├── AppRoutes.jsx                (Map URL với Component, ví dụ: /booking -> CreateBookingPage)
│   │   └── PrivateRoute.jsx             (Chặn chưa đăng nhập không cho vào đặt lịch)
│   │
│   └── App.jsx
```
