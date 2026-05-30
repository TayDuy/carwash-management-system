# MVC2 and 3-Layer Architecture in AutoWash Pro

This document describes how the **AutoWash Pro** system integrates the **MVC2** model and **3-Layer Architecture** using **Spring Boot (Backend)** and **React (Frontend)**.

## 1. Integrating MVC2 and 3-Layer Architecture
Following the modern client-server model:
- **View:** Completely decoupled to the Frontend using **React**.
- **Controller and Model:** Handled on the Backend using **Spring Boot**.
- The Spring Boot Backend itself is structured using the **3-Layer Architecture** to ensure maintainability and scalability.

## 2. The 3-Layer Model (Spring Boot Backend)

### Layer 1: Presentation Layer (Controller Layer)
- **Role:** Handles HTTP Requests from React, validates JWTs, validates input data (DTOs), and returns HTTP Responses (JSON). This layer does NOT contain business logic.
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
│   ├── security/                        (Authentication & Authorization)
│   │   ├── JwtTokenProvider.java
│   │   └── JwtAuthenticationFilter.java
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
│   │   ├── controller/
│   │   │   ├── CustomerController.java
│   │   │   └── VehicleController.java
│   │   ├── service/
│   │   │   ├── CustomerService.java
│   │   │   └── VehicleService.java
│   │   ├── repository/
│   │   │   ├── CustomerRepository.java
│   │   │   ├── VehicleRepository.java
│   │   │   └── TierRepository.java      
│   │   ├── entity/
│   │   │   ├── Customer.java
│   │   │   ├── Vehicle.java
│   │   │   └── Tier.java
│   │   └── dto/CustomerProfileDTO.java
│   │
│   ├── branch/                          (BRANCH & STAFF DOMAIN)
│   │   ├── controller/
│   │   │   ├── BranchController.java
│   │   │   └── StaffController.java     
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
│   ├── loyalty/                         (LOYALTY & VOUCHER DOMAIN)
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
│   │       └── BookingCompletedListener.java 
│   │
│   └── review/                          (REVIEW DOMAIN)
│       ├── controller/ReviewController.java
│       ├── service/ReviewService.java
│       ├── repository/ReviewRepository.java
│       └── entity/Review.java
```

### Frontend (React - MVC View Role)
```text
frontend/
├── src/
│   ├── api/                             (API Client Layer)
│   │   ├── axiosClient.js               
│   │   ├── bookingApi.js                
│   │   ├── customerApi.js               
│   │   ├── branchApi.js                 
│   │   └── loyaltyApi.js                
│   │
│   ├── context/                         (Global State Management)
│   │   ├── AuthContext.jsx              
│   │   └── BookingFlowContext.jsx       
│   │
│   ├── hooks/                           (Custom Logic)
│   │   ├── useVehicles.js               
│   │   └── useAvailableSlots.js         
│   │
│   ├── components/                      (Shared UI Components)
│   │   ├── common/                      
│   │   ├── booking/                     
│   │   │   ├── BranchSelector.jsx       
│   │   │   ├── TimeSlotPicker.jsx       
│   │   │   └── VehiclePicker.jsx        
│   │   └── reviews/
│   │       └── StarRating.jsx
│   │
│   ├── pages/                           (MAIN VIEWS)
│   │   ├── auth/
│   │   │   └── Login.jsx
│   │   │
│   │   ├── customer/                    (User Portal)
│   │   │   ├── Dashboard.jsx            
│   │   │   ├── MyVehicles.jsx           
│   │   │   └── MyVouchers.jsx
│   │   │
│   │   ├── booking/                     (Booking Flow)
│   │   │   ├── CreateBookingPage.jsx    
│   │   │   └── BookingSuccessPage.jsx   
│   │   │
│   │   └── admin/                       (Admin & Staff Portal)
│   │       ├── BranchManagement.jsx     
│   │       ├── StaffManagement.jsx      
│   │       └── AttendanceCheck.jsx      
│   │
│   ├── routes/
│   │   ├── AppRoutes.jsx                
│   │   └── PrivateRoute.jsx             
│   │
│   └── App.jsx
```
