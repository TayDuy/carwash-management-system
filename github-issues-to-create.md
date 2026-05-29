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

End of list.
