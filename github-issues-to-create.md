# GitHub Issues to Create

Repository: TayDuy/carwash-management-system
Assignees: @TayDuy, @Bui-Thi-Huong, @HungBeast, @phamtiendung-2005, @tuhnse183528-design

Below are issue titles, labels, assignees, and bodies. Use `gh issue create` or GitHub UI to create each.

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

## 7. EPIC: Career Roadmap — Architecture & Data Pipeline
Labels: epic
Assignees: @HungBeast

Define architecture, LLM integration approach, scraper pipelines, data storage, and background job infra.

---

## 8. CR: Mentor Chat & LLM Integration
Labels: backend,ml
Assignees: @HungBeast

Proxy LLM API calls, conversation history storage, safety/sanitization, rate limits, and fallback content.

---

## 9. CR: Roadmap Generator & UI
Labels: frontend,backend
Assignees: @Bui-Thi-Huong, @HungBeast

Generate hierarchical skill-trees for target roles, allow customization, mark nodes complete, progress tracking.

---

## 10. CR: GitHub Integration & Portfolio Generator
Labels: integration,frontend
Assignees: @phamtiendung-2005, @Bui-Thi-Huong

OAuth flow for GitHub, repo selection, README extraction, AI summarization, and shareable portfolio page.

---

## 11. CR: Market Scraper & Trend Analysis
Labels: backend,data
Assignees: @HungBeast

Scheduled scrapers respecting robots.txt, keyword frequency analysis, store trends, and expose trend APIs.

---

## 12. CR: Frontend - Dashboard & Roadmap Editor
Labels: frontend
Assignees: @tuhnse183528-design, @Bui-Thi-Huong

Student dashboard, roadmap editor with drag/drop, resource links, export to PDF with consent.

---

## 13. EPIC: Horse Racing — Architecture & Compliance
Labels: epic
Assignees: @TayDuy

Define schema, roles/permissions, document approval flows, file uploads, and audit logging.

---

## 14. HR: Participant Registration & Approval
Labels: backend,admin
Assignees: @phamtiendung-2005

Owner/jockey registration, document upload, admin approval workflow, notifications.

---

## 15. HR: Tournament & Race Scheduling
Labels: backend,frontend
Assignees: @TayDuy, @phamtiendung-2005

CRUD for tournaments/races, assign referees, participant assignment, calendar export.

---

## 16. HR: Results Management & Referee Workflows
Labels: admin
Assignees: @phamtiendung-2005

Draft/publish results, infractions handling, referee reports, audit trail and dispute flow.

---

## 17. HR: Spectator UI & Public Schedule
Labels: frontend
Assignees: @Bui-Thi-Huong, @tuhnse183528-design

Public pages: schedule, live race view, leaderboards, predictions (label as unofficial).

---

## 18. Cross-project: OpenAPI / API Mocks
Labels: docs,backend
Assignees: @TayDuy

Convert api-design.md into OpenAPI spec, provide mock server for frontend development.

---

## 19. Cross-project: Database Schema & Migrations
Labels: database
Assignees: @TayDuy

Implement DB schemas, migrations, and seed data for dev environment (Postgres, UUIDs, indexes).

---

## 20. Cross-project: UI Component Library & Design System
Labels: frontend
Assignees: @tuhnse183528-design, @Bui-Thi-Huong

Create reusable component library for buttons, forms, modals, calendar, and theme tokens.

---

## 21. Cross-project: Testing & CI Policies
Labels: testing,ci
Assignees: @TayDuy

Add unit/integration test coverage goals, end-to-end test suites, and CI gates.

---

## 22. Cross-project: Privacy, Security, Compliance
Labels: security,compliance
Assignees: @HungBeast

Implement PII encryption, audit logs, RBAC, and data retention policies.

---

End of list.
