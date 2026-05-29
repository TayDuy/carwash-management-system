# API Design (REST) — AutoWash Pro

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
