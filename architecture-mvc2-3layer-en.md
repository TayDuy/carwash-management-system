# MVC2 and 3-Layer Architecture in AutoWash Pro

This document describes how the **AutoWash Pro** system integrates the **MVC2** model and **3-Layer Architecture** using **Spring Boot (Backend)** and **C# Blazor (Frontend)**.

## 1. Integrating MVC2 and 3-Layer Architecture
Following the modern client-server model:
- **View:** Completely decoupled to the Frontend using **C# Blazor WebAssembly** (running directly in the browser via WebAssembly).
- **Controller and Model:** Handled on the Backend using **Spring Boot** (Java).
- The Spring Boot Backend itself is structured using the **3-Layer Architecture** to ensure maintainability and scalability.

## 2. The 3-Layer Model (Spring Boot Backend)

### Layer 1: Presentation Layer (Controller Layer)
- **Role:** Handles HTTP Requests from the Blazor Frontend, validates JWTs, validates input data (DTOs), and returns HTTP Responses (JSON). This layer does NOT contain business logic.
- **Components:** Classes annotated with `@RestController`.
- **Examples:** `BookingController`, `AuthController`.

### Layer 2: Business Logic Layer (Service Layer)
- **Role:** Processes the core business rules, interacts with Cache/Message Brokers, and communicates with the Data Access Layer.
- **Components:** Classes annotated with `@Service`.
- **Examples:** `BookingService` (checks slot availability, customer status), `LoyaltyService`.

### Layer 3: Data Access Layer (Repository Layer)
- **Role:** Interacts directly with the PostgreSQL database via Spring Data JPA to perform CRUD operations.
- **Components:** Interfaces annotated with `@Repository` and `Entities`.
- **Examples:** `BookingRepository`, `CustomerRepository`.

## 3. Detailed Folder Structure by Domain (Database Entities)

The diagram below maps directly to the actual database entities designed for AutoWash Pro (Customers, Vehicles, Tiers, Bookings, LoyaltyPoints, Branches, Staff, Shifts, AttendanceRecords, Reviews, Vouchers).

### Backend (Spring Boot - 3-Layer)
```text
backend/
├── src/main/java/com/autowash/pro/
│   ├── AutoWashApplication.java
│   │
│   ├── common/                          (Shared core code)
│   │   ├── exceptions/GlobalExceptionHandler.java
│   │   ├── dto/ApiResponse.java         
│   │   └── utils/SecurityUtils.java
│   │
│   ├── booking/                         (BOOKING DOMAIN - Core)
│   │   ├── controller/                  <-- Layer 1
│   │   │   └── BookingController.java   
│   │   ├── service/                     <-- Layer 2
│   │   │   ├── BookingService.java
│   │   │   └── impl/BookingServiceImpl.java
│   │   ├── repository/                  <-- Layer 3
│   │   │   └── BookingRepository.java
│   │   ├── entity/                      (Maps to Bookings table)
│   │   │   └── Booking.java
│   │   └── dto/
│   │       ├── BookingRequestDTO.java
│   │       └── BookingResponseDTO.java
│   │
│   ├── customer/                        (CUSTOMER & VEHICLE DOMAIN)
│   │   ├── controller/CustomerController.java
│   │   ├── service/CustomerService.java
│   │   ├── repository/CustomerRepository.java
│   │   └── entity/Customer.java
│   │
│   ├── branch/                          (BRANCH & STAFF DOMAIN)
│   │   ├── controller/BranchController.java
│   │   ├── service/BranchService.java
│   │   ├── repository/BranchRepository.java
│   │   └── entity/Branch.java
│   │
│   └── loyalty/                         (LOYALTY & VOUCHER DOMAIN)
│       ├── controller/LoyaltyController.java
│       ├── service/LoyaltyService.java
│       ├── repository/LoyaltyPointsRepository.java
│       └── entity/LoyaltyPoints.java
```

### Frontend (C# Blazor WebAssembly - MVC View Role)
In the Blazor model, we write UI using HTML combined with C# code (`.razor`) instead of JavaScript/React.

```text
frontend/
├── AutoWash.Frontend.csproj             (C# Blazor Project File)
├── Program.cs                           (DI Configuration, HttpClient Setup)
├── wwwroot/                             (Static web assets)
│   ├── css/app.css
│   └── index.html
│
├── Services/                            (API Client Layer connecting to Backend)
│   ├── HttpInterceptorService.cs        (Automatically attaches JWT Tokens)
│   ├── IBookingService.cs
│   ├── BookingService.cs                (Calls /api/v1/bookings)
│   ├── ICustomerService.cs
│   └── IAuthService.cs
│
├── Models/                              (DTOs mapped from Backend)
│   ├── BookingRequest.cs
│   ├── BookingResponse.cs
│   └── CustomerProfile.cs
│
├── Components/                          (Shared UI Components)
│   ├── Common/                          
│   ├── Booking/                     
│   │   ├── BranchSelector.razor         
│   │   ├── TimeSlotPicker.razor         
│   │   └── VehiclePicker.razor          
│   └── Layout/
│       ├── MainLayout.razor
│       └── NavMenu.razor
│
├── Pages/                               (MAIN VIEWS)
│   ├── Auth/
│   │   └── Login.razor
│   │
│   ├── Customer/                        (User Portal)
│   │   ├── Dashboard.razor              
│   │   ├── MyVehicles.razor             
│   │   └── MyVouchers.razor
│   │
│   ├── Booking/                         (Booking Flow)
│   │   ├── CreateBooking.razor          
│   │   └── BookingSuccess.razor   
│   │
│   └── Admin/                           (Admin & Staff Portal)
│       ├── BranchManagement.razor       
│       └── StaffManagement.razor        
│
├── _Imports.razor                       (Global using directives)
└── App.razor                            (Routing Configuration)
```
