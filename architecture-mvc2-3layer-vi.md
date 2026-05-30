# Kiến trúc MVC2 và 3-Layer trong hệ thống AutoWash Pro

Tài liệu này mô tả cách hệ thống **AutoWash Pro** kết hợp mô hình **MVC2** và **Kiến trúc 3 Lớp (3-Layer Architecture)** sử dụng **Spring Boot (Backend)** và **C# Blazor (Frontend)**.

## 1. Sự kết hợp giữa MVC2 và 3-Layer
Theo mô hình client-server hiện đại:
- **View (Giao diện):** Được tách biệt hoàn toàn sang Frontend sử dụng **C# Blazor WebAssembly** (chạy trực tiếp trên trình duyệt bằng WebAssembly).
- **Controller và Model:** Nằm ở Backend sử dụng **Spring Boot** (Java).
- Bản thân Backend Spring Boot được tổ chức theo **Kiến trúc 3 Lớp** để đảm bảo dễ bảo trì và mở rộng.

## 2. Mô hình 3-Layer (Backend Spring Boot)

### Tầng 1: Presentation Layer (Controller Layer)
- **Nhiệm vụ:** Tiếp nhận HTTP Request từ Blazor Frontend, xác thực JWT, validate dữ liệu (DTO), và trả về HTTP Response (JSON). Tầng này không chứa logic nghiệp vụ.
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
│   │   ├── controller/CustomerController.java
│   │   ├── service/CustomerService.java
│   │   ├── repository/CustomerRepository.java
│   │   └── entity/Customer.java
│   │
│   ├── branch/                          (NGHIỆP VỤ CHI NHÁNH & NHÂN SỰ)
│   │   ├── controller/BranchController.java
│   │   ├── service/BranchService.java
│   │   ├── repository/BranchRepository.java
│   │   └── entity/Branch.java
│   │
│   └── loyalty/                         (NGHIỆP VỤ ĐIỂM THƯỞNG & VOUCHER)
│       ├── controller/LoyaltyController.java
│       ├── service/LoyaltyService.java
│       ├── repository/LoyaltyPointsRepository.java
│       └── entity/LoyaltyPoints.java
```

### Frontend (C# Blazor WebAssembly - Vai trò MVC View)
Ở mô hình Blazor, chúng ta viết giao diện bằng HTML kết hợp với C# code (`.razor`) thay vì JavaScript/React.

```text
frontend/
├── AutoWash.Frontend.csproj             (File quản lý project C# Blazor)
├── Program.cs                           (Cấu hình DI, đăng ký HttpClient gọi Backend)
├── wwwroot/                             (Các file tĩnh)
│   ├── css/app.css
│   └── index.html
│
├── Services/                            (Lớp gọi API Spring Boot Backend qua HTTP)
│   ├── HttpInterceptorService.cs        (Tự động gắn JWT Token vào request)
│   ├── IBookingService.cs
│   ├── BookingService.cs                (Gọi API /api/v1/bookings)
│   ├── ICustomerService.cs
│   └── IAuthService.cs
│
├── Models/                              (Các DTOs (Model) mapping từ dữ liệu Backend)
│   ├── BookingRequest.cs
│   ├── BookingResponse.cs
│   └── CustomerProfile.cs
│
├── Components/                          (Thành phần UI chia nhỏ dùng chung)
│   ├── Common/                          (Nút, Input, Modal...)
│   ├── Booking/                     
│   │   ├── BranchSelector.razor         (Giao diện chọn chi nhánh)
│   │   ├── TimeSlotPicker.razor         (Giao diện chọn giờ)
│   │   └── VehiclePicker.razor          (Giao diện chọn xe)
│   └── Layout/
│       ├── MainLayout.razor
│       └── NavMenu.razor
│
├── Pages/                               (CÁC TRANG HIỂN THỊ CHÍNH - Tầng VIEW)
│   ├── Auth/
│   │   └── Login.razor
│   │
│   ├── Customer/                        (Khu vực User)
│   │   ├── Dashboard.razor              (Xem lịch sắp tới, điểm Loyalty)
│   │   ├── MyVehicles.razor             
│   │   └── MyVouchers.razor
│   │
│   ├── Booking/                         (Luồng đặt lịch chính)
│   │   ├── CreateBooking.razor          
│   │   └── BookingSuccess.razor   
│   │
│   └── Admin/                           (Khu vực Quản trị viên & Nhân viên)
│       ├── BranchManagement.razor       
│       └── StaffManagement.razor        
│
├── _Imports.razor                       (Khai báo các thư viện using chung)
└── App.razor                            (Cấu hình Routing cho ứng dụng)
```
