# Kiến trúc MVC2 và 3-Layer trong hệ thống AutoWash Pro

Tài liệu này mô tả cách hệ thống **AutoWash Pro** kết hợp mô hình **MVC2** và **Kiến trúc 3 Lớp (3-Layer Architecture)** sử dụng **Spring Boot (Backend)** và **React (Frontend)**.

## 1. Sự kết hợp giữa MVC2 và 3-Layer
Theo mô hình client-server hiện đại:
- **View (Giao diện):** Được tách biệt hoàn toàn sang Frontend sử dụng **React**.
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

## 3. Cấu trúc thư mục tham khảo

### Backend (Spring Boot)
```text
backend/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/autowash/pro/
│   │   │       ├── common/                       (Global exceptions, utils)
│   │   │       ├── config/                       (Security, Redis config)
│   │   │       ├── booking/                      (Module tính năng)
│   │   │       │   ├── controller/               <-- Layer 1
│   │   │       │   ├── service/                  <-- Layer 2
│   │   │       │   ├── repository/               <-- Layer 3
│   │   │       │   ├── entity/                   (DB Models)
│   │   │       │   └── dto/                      (Request/Response)
│   │   │       └── customer/                     (Module tính năng khác)
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/                     (Flyway SQL)
└── pom.xml / build.gradle
```

### Frontend (React)
```text
frontend/
├── src/
│   ├── api/                      (Axios client, gọi API Backend)
│   ├── context/                  (Quản lý Global State)
│   ├── hooks/                    (Custom hooks chứa logic)
│   ├── components/               (UI components dùng chung)
│   ├── pages/                    (Giao diện các trang - View)
│   │   ├── auth/
│   │   └── booking/
│   ├── routes/                   (Quản lý điều hướng)
│   └── App.jsx
├── package.json
└── vite.config.js
```
