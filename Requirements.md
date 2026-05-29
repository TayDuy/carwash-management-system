# Software Requirements — AutoWash Pro

This document consolidates and defines the software requirements for the AutoWash Pro system. All requirements are specified using precise engineering language and the formal "The system shall..." structure to ensure testability and verifiability.

---

## Project SU26SWP01 — AutoWash Pro: Automated Car Wash Management System

### Overview
AutoWash Pro is an automated vehicle wash management platform designed to automate slot booking, loyalty point tracking, and administrative tier management using license-plate recognition (LPR) and CRM integration.

### Context & Problem Statement
- Rapid growth in vehicle ownership in Vietnam has increased demand for wash services. Existing systems lack sophisticated retention mechanisms.
- Current gaps: limited reward schemes ("wash 5 get 1"), no tiered benefits, poor digital tracking of points, history, and perks.

### Objectives
- Optimize slot utilization and increase customer retention rate through a structured loyalty tiering priority system and automated promotions.

### Primary Actors
- Customers (vehicle owners)
- Admins (wash operators)

### Key Features / Functional Requirements

#### 1. Advanced Booking
- **FR-1.1**: The system shall provide tier-based booking windows allowing advance slot reservations according to the customer's loyalty tier:
  - Member tier: up to 7 days in advance.
  - Silver tier: up to 10 days in advance.
  - Gold tier: up to 12 days in advance.
  - Platinum tier: up to 14 days in advance.
- **FR-1.2**: The system shall automatically apply the customer's active tier perks during the checkout transaction calculation.
- **FR-1.3**: The system shall enforce booking concurrency checks, ensuring that no physical wash slot is double-booked.

#### 2. Loyalty Engine
- **FR-2.1**: The system shall track, record, and persist customer loyalty points, monetary transactions, and total visits.
- **FR-2.2**: The system shall run a monthly automated review job to upgrade or downgrade customer tiers based on their total spend over the preceding 30 days.
- **FR-2.3**: The system shall provide mechanisms for customers to redeem loyalty points for monetary discounts, free washes, or add-on services at checkout.
- **FR-2.4**: The system shall expire accrued loyalty points exactly 12 months after the accrual transaction date.

#### 3. Customer Features
- **FR-3.1**: The system shall allow customers to link their account to a unique license plate number and a unique phone number.
- **FR-3.2**: The system shall display points balance, active tier status, and transaction history to authenticated customers.
- **FR-3.3**: The system shall restrict booking slot availability queries according to the authenticated customer's tier booking window policy.

#### 4. Admin Features
- **FR-4.1**: The system shall provide an administrative interface to configure tier thresholds, point accrual rates, perk definitions, and target promotion parameters.
- **FR-4.2**: The system shall generate and display charts showing key performance indicators (KPIs), transaction summaries, and active promotions.

#### 5. Review & Feedback
- **FR-5.1**: The system shall allow customers to submit a review only after completing a booked service.
- **FR-5.2**: The system shall limit each booking to exactly one review submission.
- **FR-5.3**: The system shall automatically trigger an alert notification to the branch manager when a review is rated below 3 stars.

#### 6. Voucher & Promotions
- **FR-6.1**: The system shall automatically issue a discount voucher for the following month to customers who complete 5 or more bookings within a calendar month.
- **FR-6.2**: The system shall automatically send a retention offer to VIP-tier customers who have been inactive for more than 30 consecutive days.
- **FR-6.3**: The system shall enforce a maximum of 1 voucher and 1 tier-based benefit per order.
- **FR-6.4**: The system shall validate all promotional code conditions before application and reject codes that do not meet eligibility requirements.
- **FR-6.5**: The system shall not apply promotions to services that are already discounted.
- **FR-6.6**: The system shall enforce voucher expiration dates and prevent usage of expired vouchers.

#### 7. Staff & Attendance Management
- **FR-7.1**: The system shall assign each staff member to exactly one primary branch with an employment type of Part-time or Full-time.
- **FR-7.2**: The system shall require staff to check-in and check-out for each work shift and record actual timestamps.
- **FR-7.3**: The system shall automatically mark staff as absent if no check-in record exists for a scheduled shift.
- **FR-7.4**: The system shall automatically calculate total working hours, flag overtime hours separately, and compile monthly attendance summaries.
- **FR-7.5**: The system shall enforce that no staff member is assigned two overlapping shifts.
- **FR-7.6**: The system shall require admin approval for all staff leave requests.
- **FR-7.7**: The system shall display late attendance records on the branch management dashboard.

#### 8. Branch Management
- **FR-8.1**: The system shall maintain independent configuration for each branch including vehicle capacity, operating hours, and service availability.
- **FR-8.2**: The system shall restrict branch manager data access exclusively to their assigned branch.
- **FR-8.3**: The system shall allow customers to book services across different branches.
- **FR-8.4**: The system shall track and report revenue separately for each branch.
- **FR-8.5**: The system shall allow system administrators to activate or deactivate branches.

### Constraints & Notes
- **CON-1**: Online payment gateway integration and financial refund transactions are out of scope for implementation.

### Main Entities
- Customer, Booking, LoyaltyPoints, Vehicle, Promotion, Tier, Transaction, Branch, Staff, Shift, Attendance, Review, Voucher

### Timeline (Planned — 16 weeks)
- Phase 1 (Weeks 1–4): Prototype, database design, website setup with account management and booking capabilities.
- Phase 2 (Weeks 5–7): Complete loyalty, promotion, transaction modules; collect synthetic behavioral dataset (~2k records).
- Phase 3 (Weeks 8–9): External survey data collection (target additional ~3k records).
- Phase 4 (Weeks 10–12): Data processing and cleaning.
- Phase 5 (Weeks 13–16): Generate synthetic behavioral data, train ML models, run analytics, prepare paper submissions.

### Research Questions
- What factors most influence customer loyalty tier progression in smart service ecosystems?
- Research objectives: identify factors that most strongly influence upgrades, retention, and long-term engagement.

---

# Merged Design Details

## Common Actors

| Actor | Role / Responsibilities |
|---|---|
| Customer | Accesses services, schedules slot bookings, views points balance and vehicles. |
| Admin | Configures system rules, manages promotions, views performance analytics and KPIs. |
| System (Automated) | Runs monthly tier recalculations, tracks point expiration, enforces booking slot availability constraints. |
| Staff / Branch Manager | Manages shift attendance, views branch-specific data and reports. |

## Key Business Rules (summary)

| ID | Scope | Rule |
|---|---|---|
| BR-G1 | Global | All state-changing actions require secure JWT authentication. |
| BR-G2 | Global | Enforce an append-only audit trail recording user, timestamp, and action for critical events. |
| BR-A01 | AutoWash Pro | Points accrue on completed paid washes only. |
| BR-A02 | AutoWash Pro | Points expire exactly 12 months from the accrual transaction date. |
| BR-A03 | AutoWash Pro | Tier upgrade/downgrade occurs monthly based on preceding 30-day spend metrics. |
| BR-A04 | AutoWash Pro | Priority booking lead time is enforced strictly by loyalty tier. |
| BR-A05 | AutoWash Pro | Redemption transactions cannot exceed the customer's current point balance. |

---

End of document.
