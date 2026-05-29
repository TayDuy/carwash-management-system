# API Design (REST)

This document proposes REST API endpoints for the three projects. Use JSON over HTTPS. Authentication: JWT (Bearer) or OAuth2 where external providers are needed.

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

## SU26SWP02 — Career Roadmap Platform

### Authentication
- POST /api/v1/auth/register
- POST /api/v1/auth/login
- POST /api/v1/auth/oauth/google

### AI Mentor
- POST /api/v1/mentor/query (body: {question, context?}) -> {answer, sources[]}
- GET /api/v1/mentor/history

### Roadmap & Skills
- POST /api/v1/roadmaps (body: {target_role, preferences}) -> {roadmap_id}
- GET /api/v1/roadmaps/{id}
- PATCH /api/v1/roadmaps/{id}/nodes/{node_id} (mark complete)
- GET /api/v1/skills

### Market Pulse
- GET /api/v1/market/trends?skill=
- GET /api/v1/market/jobs?saved_query=

### E-Portfolio
- POST /api/v1/integrations/github/connect (OAuth flow)
- GET /api/v1/portfolio/{user_id}
- GET /api/v1/portfolio/{user_id}/share

Notes: LLM calls should be proxied via server to avoid exposing keys. Scraper endpoints trigger background jobs.

---

## SU26SWP03 — Horse Racing

### Authentication & Users
- POST /api/v1/auth/register
- POST /api/v1/auth/login

### Participants
- POST /api/v1/horses (owner auth) {name, breed, dob, owner_id}
- GET /api/v1/horses/{id}
- POST /api/v1/jockeys

### Tournaments & Races
- POST /api/v1/tournaments {name, start_date, end_date}
- GET /api/v1/tournaments/{id}
- POST /api/v1/tournaments/{id}/races {name, scheduled_at, track}
- POST /api/v1/races/{id}/entries {horse_id, jockey_id}

### Results & Referee
- POST /api/v1/races/{id}/results (referee only) {placements[], notes}
- GET /api/v1/races/{id}/results

### Spectator Features
- GET /api/v1/public/schedule
- GET /api/v1/public/results/{tournament_id}

Notes: Results are "draft" until published by authorized role. Webhooks can be added for live updates.


