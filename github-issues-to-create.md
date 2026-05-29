# GitHub Issues to Create — AutoWash Pro

Repository: TayDuy/carwash-management-system
Assignees: @TayDuy, @Bui-Thi-Huong, @HungBeast, @phamtiendung-2005, @tuhnse183528-design

Below are issue titles, labels, assignees, and bodies for the AutoWash Pro project. Use `gh issue create` or GitHub UI to create each.

## 1. EPIC: AutoWash Pro — Architecture & CI
Labels: epic
Assignees: @TayDuy

Define architecture, CI/CD, stack, repo structure, infra IaC, environment setup. Acceptance: README with setup steps and CI pipeline.

---

## 2. AW: Auth & User Management
Labels: backend
Assignees: @TayDuy

Implement registration/login (phone+password), JWT auth, phone verification, password reset, user profile APIs. AC: API tests and Postman collection.

---

## 3. AW: Vehicle & Booking APIs
Labels: backend,frontend
Assignees: @TayDuy, @Bui-Thi-Huong

Implement Vehicles, Booking endpoints, slot model, tier-based availability and priority queueing logic. AC: booking race-condition handling and unit tests.

---

## 4. AW: Loyalty Engine & Tiering
Labels: backend,ml
Assignees: @HungBeast, @phamtiendung-2005

Design and implement loyalty points accrual, expiry (12 months), auto tier upgrade/downgrade monthly, redemption flow. Include batch jobs for expiry and recalculation.

---

## 5. AW: Admin Dashboard & Promotions
Labels: admin,frontend
Assignees: @phamtiendung-2005

Admin UI to manage tiers, points, promotions, targeted campaigns. Include analytics endpoints and export.

---

## 6. AW: Frontend - Booking Calendar & Account
Labels: frontend
Assignees: @Bui-Thi-Huong, @tuhnse183528-design

Implement responsive booking calendar, vehicle selector, account pages, loyalty wallet UI, and booking confirmation flows.

---

## 7. Cross-project: OpenAPI / API Mocks
Labels: docs,backend
Assignees: @TayDuy

Convert api-design.md into OpenAPI spec, provide mock server for frontend development.

---

## 8. Cross-project: Database Schema & Migrations
Labels: database
Assignees: @TayDuy

Implement DB schemas, migrations, and seed data for dev environment (Postgres, UUIDs, indexes).

---

## 9. Cross-project: UI Component Library & Design System
Labels: frontend
Assignees: @tuhnse183528-design, @Bui-Thi-Huong

Create reusable component library for buttons, forms, modals, calendar, and theme tokens.

---

## 10. Cross-project: Testing & CI Policies
Labels: testing,ci
Assignees: @TayDuy

Add unit/integration test coverage goals, end-to-end test suites, and CI gates.

---

## 11. Cross-project: Privacy, Security, Compliance
Labels: security,compliance
Assignees: @HungBeast

Implement PII encryption, audit logs, RBAC, and data retention policies.

---

## 12. [Feature] Review & Feedback System

**Title**: [Feature] Review & Feedback System
**Labels**: feature, backend, frontend
**Assignees**: @TayDuy

### Description
Implement the review and feedback system allowing customers to rate completed bookings.

### Requirements
- Customers can submit 1-5 star rating + optional comment after booking completion (BR-45)
- One review per booking constraint (BR-46)
- Reviews < 3 stars trigger alert to branch manager (BR-47)
- Branch reviews dashboard for managers

### Acceptance Criteria
- [ ] POST /api/bookings/:id/reviews endpoint
- [ ] Review submission page at /bookings/:id/review
- [ ] Branch reviews dashboard at /admin/branches/:id/reviews
- [ ] Low-rating alert notification system
- [ ] Database: Reviews table with unique booking constraint

---

## 13. [Feature] Staff Management Module

**Title**: [Feature] Staff Management Module
**Labels**: feature, backend, frontend, admin
**Assignees**: @TayDuy

### Description
Implement staff management functionality including staff profiles, employment types, and branch assignments.

### Requirements
- Each staff member assigned to one primary branch (BR-61)
- Employment type: Full-time or Part-time (BR-62, BR-63)
- Probation tracking (BR-69)
- Branch manager can view their branch staff (BR-70)

### Acceptance Criteria
- [ ] Staff CRUD API endpoints
- [ ] Staff list page at /admin/branches/:id/staff
- [ ] Staff profile with employment type and branch assignment
- [ ] Database: Staff table

---

## 14. [Feature] Shift Scheduling System

**Title**: [Feature] Shift Scheduling System
**Labels**: feature, backend, frontend, admin
**Assignees**: @TayDuy

### Description
Implement shift scheduling for staff members with overlap detection.

### Requirements
- Each shift has start/end time (BR-71)
- No overlapping shifts per staff (BR-72)
- Calendar/timeline view for shift management

### Acceptance Criteria
- [ ] POST /api/admin/shifts endpoint with overlap validation
- [ ] Shift management page at /admin/branches/:id/shifts
- [ ] Calendar view with drag-and-drop
- [ ] Database: Shifts table

---

## 15. [Feature] Attendance Tracking System

**Title**: [Feature] Attendance Tracking System
**Labels**: feature, backend, frontend, admin
**Assignees**: @TayDuy

### Description
Implement attendance tracking with check-in/check-out, auto-absence marking, and monthly summaries.

### Requirements
- Staff check-in/check-out with actual timestamps (BR-64, BR-65)
- Auto-absent marking for no-shows (BR-66)
- Soft delete only for records (BR-73)
- Auto-calculate total hours and overtime (BR-74, BR-75)
- Monthly attendance summary (BR-76)
- Leave request approval workflow (BR-77)
- Late attendance dashboard display (BR-78)

### Acceptance Criteria
- [ ] Check-in/check-out API endpoints
- [ ] Attendance dashboard at /admin/branches/:id/attendance
- [ ] Staff self-service page at /staff/attendance
- [ ] Monthly summary generation
- [ ] Leave request approval workflow
- [ ] Database: AttendanceRecords table with soft delete

---

## 16. [Feature] Branch Management System

**Title**: [Feature] Branch Management System
**Labels**: feature, backend, frontend, admin
**Assignees**: @TayDuy

### Description
Implement multi-branch management with independent configuration and data isolation.

### Requirements
- Each branch has capacity, operating hours, service availability (BR-81, BR-85, BR-87)
- Branch manager data access restriction (BR-82)
- Cross-branch booking support (BR-83)
- Per-branch revenue tracking (BR-86)
- Branch activate/deactivate (BR-88)
- Per-branch promotion support (BR-90)

### Acceptance Criteria
- [ ] Branch CRUD API endpoints
- [ ] Branch list page at /admin/branches
- [ ] Branch settings page at /admin/branches/:id/settings
- [ ] Branch revenue dashboard at /admin/branches/:id/revenue
- [ ] Data access restriction by branch manager role
- [ ] Database: Branches table

---

## 17. [Feature] Voucher & Promotion Engine

**Title**: [Feature] Voucher & Promotion Engine
**Labels**: feature, backend, frontend, admin
**Assignees**: @TayDuy

### Description
Implement voucher management and promotional campaign engine.

### Requirements
- Admin-only promotion creation (BR-41)
- Voucher validation with expiry check (BR-53, BR-54, BR-56)
- No double-discount stacking (BR-55, BR-59)
- Max 1 voucher + 1 tier benefit per order (BR-52)
- Auto-voucher for frequent customers (BR-48)
- VIP retention offers (BR-50)

### Acceptance Criteria
- [ ] Voucher validation API endpoint
- [ ] Admin promotions page at /admin/promotions
- [ ] Admin vouchers page at /admin/vouchers
- [ ] Customer voucher wallet at /my-vouchers
- [ ] Auto-voucher generation job
- [ ] VIP retention check job
- [ ] Database: Vouchers table

---

## 18. [Chore] Update Business Rules Documentation to 100 Rules

**Title**: [Chore] Update Business Rules Documentation to 100 Rules
**Labels**: docs, chore
**Assignees**: @TayDuy

### Description
Update all project documentation to reflect the expanded 100 business rules covering:
- Staff & Attendance (BR-61 to BR-80)
- Branch Management (BR-81 to BR-90)
- Review & Feedback (BR-45 to BR-47)
- Voucher & Promotions (BR-48 to BR-60)
- Security & Compliance (BR-91 to BR-100)

### Files Updated
- [ ] business-rules.md (English)
- [ ] business-rules-vi.md (Vietnamese)
- [ ] Requirements.md
- [ ] database-design.md
- [ ] api-design.md
- [ ] frontend-pages.md
- [ ] acceptance-criteria.md

---

End of list.
