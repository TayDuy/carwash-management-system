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

## 3. Reference Folder Structure

### Backend (Spring Boot)
```text
backend/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/autowash/pro/
│   │   │       ├── common/                       (Global exceptions, utils)
│   │   │       ├── config/                       (Security, Redis config)
│   │   │       ├── booking/                      (Feature module)
│   │   │       │   ├── controller/               <-- Layer 1
│   │   │       │   ├── service/                  <-- Layer 2
│   │   │       │   ├── repository/               <-- Layer 3
│   │   │       │   ├── entity/                   (DB Models)
│   │   │       │   └── dto/                      (Request/Response)
│   │   │       └── customer/                     (Other feature module)
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/                     (Flyway SQL)
└── pom.xml / build.gradle
```

### Frontend (React)
```text
frontend/
├── src/
│   ├── api/                      (Axios client for Backend API calls)
│   ├── context/                  (Global State Management)
│   ├── hooks/                    (Custom hooks for logic)
│   ├── components/               (Shared UI components)
│   ├── pages/                    (Page layouts - View)
│   │   ├── auth/
│   │   └── booking/
│   ├── routes/                   (Routing configurations)
│   └── App.jsx
├── package.json
└── vite.config.js
```
