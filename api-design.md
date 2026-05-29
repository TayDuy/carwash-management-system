# API Design — AutoWash Pro

This document proposes REST API endpoints for the AutoWash Pro project. Use JSON over HTTPS. Authentication: JWT (Bearer).

## Common Conventions
- Base URL: /api/v1
- Pagination: page, per_page; responses include meta {total, page, per_page}
- Error format: {"error":{"code":...,"message":"...","details":{}}}
- Timestamps ISO-8601 UTC
- All write endpoints require Authorization: Bearer <token>

---

## SU26SWP01 — AutoWash Pro

### Authentication
- POST /api/v1/auth/register (body: {name, phone, password})
- POST /api/v1/auth/login (body: {phone, password}) -> {token}

### Customer / Vehicle
- GET /api/v1/customers/me
- PUT /api/v1/customers/me
- POST /api/v1/customers/vehicles (body: {plate, vehicle_type})
- GET /api/v1/customers/vehicles

### Booking
- GET /api/v1/bookings?vehicle_id=&start=&end=&tier=
- POST /api/v1/bookings (body: {vehicle_id, slot_id, payment_ref?})
- GET /api/v1/bookings/{id}
- DELETE /api/v1/bookings/{id}

### Loyalty & Tiers
- GET /api/v1/loyalty/balance
- GET /api/v1/loyalty/history
- POST /api/v1/loyalty/redeem (body: {type, amount, target})
- GET /api/v1/tiers
- PUT /api/v1/admin/tiers/{id} (admin)

### Admin & Analytics
- GET /api/v1/admin/promotions
- POST /api/v1/admin/promotions
- GET /api/v1/admin/analytics/kpis?from=&to=

Notes: Booking creation must check tier booking windows and priority. Loyalty redemption must be atomic.

---

### 7. Branch Management

#### `GET /api/branches`
- Description: List all active branches
- Auth: Public
- Response: `200 OK` — Array of branch objects (id, name, address, capacity, operating_hours, is_active)

#### `GET /api/branches/:id`
- Description: Get branch details
- Auth: Authenticated
- Response: `200 OK` — Branch object

#### `POST /api/admin/branches`
- Description: Create a new branch
- Auth: Admin
- Body: { name, address, capacity, operating_hours }
- Response: `201 Created`

#### `PUT /api/admin/branches/:id`
- Description: Update branch details
- Auth: Admin
- Response: `200 OK`

#### `PATCH /api/admin/branches/:id/status`
- Description: Activate or deactivate a branch (BR-88)
- Auth: Admin
- Body: { is_active: boolean }
- Response: `200 OK`

#### `GET /api/admin/branches/:id/revenue`
- Description: Get branch revenue report (BR-86)
- Auth: Admin / Branch Manager
- Query: period (daily, weekly, monthly)
- Response: `200 OK` — Revenue data object

---

### 8. Staff Management

#### `GET /api/branches/:branchId/staff`
- Description: List staff members for a branch (BR-89)
- Auth: Admin / Branch Manager
- Response: `200 OK` — Array of staff objects

#### `POST /api/admin/staff`
- Description: Register a new staff member (BR-61, BR-62)
- Auth: Admin
- Body: { user_id, branch_id, employment_type, probation_end_date? }
- Response: `201 Created`

#### `PUT /api/admin/staff/:id`
- Description: Update staff details
- Auth: Admin
- Response: `200 OK`

---

### 9. Shift & Attendance

#### `POST /api/admin/shifts`
- Description: Create a shift assignment (BR-71, BR-72)
- Auth: Admin / Branch Manager
- Body: { staff_id, branch_id, start_time, end_time }
- Validation: No overlapping shifts for same staff member
- Response: `201 Created`

#### `GET /api/branches/:branchId/shifts`
- Description: List shifts for a branch
- Auth: Admin / Branch Manager
- Query: date, staff_id
- Response: `200 OK`

#### `POST /api/attendance/check-in`
- Description: Staff check-in (BR-64, BR-65)
- Auth: Staff
- Body: { shift_id }
- Response: `200 OK` — Records actual timestamp

#### `POST /api/attendance/check-out`
- Description: Staff check-out (BR-64, BR-65)
- Auth: Staff
- Body: { shift_id }
- Response: `200 OK` — Records actual timestamp, calculates hours

#### `GET /api/branches/:branchId/attendance/summary`
- Description: Monthly attendance summary (BR-70, BR-76)
- Auth: Admin / Branch Manager
- Query: month, year
- Response: `200 OK` — Summary with total hours, overtime, absences, late records

#### `POST /api/admin/leave-requests`
- Description: Staff submits leave request (BR-77)
- Auth: Staff
- Body: { shift_id, reason }
- Response: `201 Created`

#### `PATCH /api/admin/leave-requests/:id`
- Description: Admin approves/rejects leave request (BR-77)
- Auth: Admin
- Body: { status: approved|rejected }
- Response: `200 OK`

---

### 10. Reviews

#### `POST /api/bookings/:bookingId/reviews`
- Description: Submit a review for a completed booking (BR-45, BR-46)
- Auth: Customer
- Body: { rating (1-5), comment? }
- Validation: Booking must be Completed. Only 1 review per booking.
- Side Effect: If rating < 3, alert notification sent to branch manager (BR-47)
- Response: `201 Created`

#### `GET /api/bookings/:bookingId/reviews`
- Description: Get review for a booking
- Auth: Authenticated
- Response: `200 OK` — Review object or 404

#### `GET /api/branches/:branchId/reviews`
- Description: Get all reviews for a branch
- Auth: Admin / Branch Manager
- Query: min_rating, max_rating, page, limit
- Response: `200 OK` — Paginated review array

---

### 11. Vouchers & Promotions

#### `GET /api/customers/:customerId/vouchers`
- Description: List customer's active vouchers
- Auth: Customer
- Response: `200 OK` — Array of voucher objects

#### `POST /api/vouchers/validate`
- Description: Validate a voucher code before applying (BR-56)
- Auth: Authenticated
- Body: { code, order_total, services[] }
- Validation: Check expiry (BR-53, BR-54), no double-discount (BR-55), stacking rules (BR-59)
- Response: `200 OK` — { valid, discount_amount, reason? }

#### `POST /api/admin/vouchers`
- Description: Create a voucher or promotion (BR-41)
- Auth: Admin
- Body: { code, discount_type, discount_value, min_order_value?, expires_at, customer_id?, branch_id? }
- Response: `201 Created`

#### `POST /api/admin/promotions`
- Description: Create a promotional campaign (BR-41)
- Auth: Admin
- Body: { name, description, start_date, end_date, discount_type, discount_value, applicable_branches[], applicable_tiers[] }
- Response: `201 Created`
