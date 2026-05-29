# AutoWash Pro — Business Rules

> **Version:** 1.0  
> **Last Updated:** 2026-05-29  
> **Total Rules:** 90 (of 100 allocated IDs; 10 IDs are reserved/empty)

This document defines the complete set of business rules governing the AutoWash Pro car wash management system. Rules are grouped by functional category and presented in tabular format for easy reference.

> **Skipped IDs (reserved / empty):** BR-04, BR-13, BR-29, BR-49, BR-51, BR-57, BR-58, BR-67, BR-79, BR-96

---

## 1. Global / Account Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-01 | A customer account must be linked to at least one phone number and one license plate. The system uses the license plate as the primary key for automatic identification at the wash station. | System | High | |
| BR-02 | A customer may own multiple vehicles. | System | Medium | |
| BR-03 | Each vehicle must have a valid license plate number. | System | High | |
| BR-05 | Customers must be authenticated to create a booking. | System | High | |
| BR-06 | A customer can only hold one loyalty tier at any given time. | System | High | |
| BR-07 | Customer tier is reviewed and recalculated monthly. | System | Medium | |
| BR-08 | New customers default to the "Member" tier. | System | High | |
| BR-09 | Customers may update their personal information. | System | Low | |
| BR-10 | Customers must verify their phone number during registration. | System | High | |

---

## 2. Booking Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-11 | Each booking must belong to a specific branch. | System | High | |
| BR-12 | A customer cannot create two bookings at the same time. | System | High | |
| BR-14 | Each time slot has a maximum vehicle capacity limit. | System | High | |
| BR-15 | A booking must include at least one service. | System | High | |
| BR-16 | Customers may select multiple add-on services per booking. | System | Medium | |
| BR-17 | A booking may include special notes or instructions. | System | Low | |
| BR-18 | Customers may cancel or modify a booking no later than 1 hour before the scheduled time. | System | High | |
| BR-19 | Bookings arriving more than 15 minutes late shall be marked as "Late". | System | Medium | |
| BR-20 | Booking lifecycle states: Pending, Confirmed, Washing, Completed, Cancelled. | System | High | |

---

## 3. Loyalty Points Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-21 | Customers earn loyalty points upon booking completion. | System | High | |
| BR-22 | Points are calculated based on the final payment amount. | System | High | |
| BR-23 | Points expire after 12 months from accrual date. | System | High | |
| BR-24 | Customers cannot redeem more points than their current balance. | System | High | |
| BR-25 | Each reward requires a minimum point threshold. | System | High | |
| BR-26 | All reward redemption transactions must be logged. | System | High | |
| BR-60 | Points accrual rate: 1 point per 10,000 VND spent. | System | High | |

---

## 4. Tier Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-27 | Tier upgrades are based on cumulative spending thresholds. | System | High | |
| BR-28 | Tier downgrades occur when customers fail to maintain spending requirements. | System | Medium | |
| BR-30 | The system must log all tier change history. | System | High | |
| BR-31 | Member tier: advance booking up to 7 days. | System | High | |
| BR-32 | Silver tier: advance booking up to 10 days. | System | High | |
| BR-33 | Gold tier: advance booking up to 12 days. | System | High | |
| BR-34 | Platinum tier: advance booking up to 14 days. | System | High | |
| BR-35 | Queue priority: higher tier customers receive earlier service priority. | System | High | |
| BR-36 | Customers may hold or deduct points for payment. | System | Medium | |
| BR-37 | Each tier has its own exclusive rewards. | System | Medium | |
| BR-38 | Customers may only enjoy benefits of their current tier. | System | High | |
| BR-39 | Tier calculation is performed automatically every month. | System | High | |
| BR-40 | Tier changes must trigger a notification to the customer. | System | Medium | |

---

## 5. Admin & Promotions Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-41 | Only Admins may create or modify promotional campaigns. | System | High | |
| BR-42 | Staff members cannot manually modify customer points. | System | High | |
| BR-43 | All changes to points and vouchers must be recorded in the audit log. | System | High | |
| BR-44 | The system shall automatically back up data daily. | System | High | |

---

## 6. Review & Feedback Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-45 | Only customers who completed a service may submit a review. | System | High | |
| BR-46 | Each booking may only be reviewed once. | System | Medium | |
| BR-47 | Reviews rated below 3 stars shall trigger an alert to the branch manager. | System | High | |

---

## 7. Retention & Voucher Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-48 | Customers with 5 or more visits per month shall receive a discount voucher for the following month. | System | Medium | |
| BR-50 | VIP customers inactive for more than 30 days shall receive a retention offer automatically. | System | Medium | |
| BR-52 | A single order may apply at most 1 voucher and 1 tier benefit. | System | High | |
| BR-53 | Vouchers have an expiration date. | System | High | |
| BR-54 | Expired vouchers shall not be auto-renewed. | System | High | |
| BR-55 | Promotions do not apply to already-discounted services. | System | High | |
| BR-56 | The system shall validate conditions before applying any promotional code. | System | High | |
| BR-59 | Tier-based promotions are non-cumulative (cannot stack). | System | High | |

---

## 8. Staff & Attendance Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-61 | Each staff member belongs to one primary branch. | System | High | |
| BR-62 | Each staff member must have an employment type. | System | High | |
| BR-63 | Employment types: Part-time, Full-time. | System | Medium | |
| BR-64 | Staff must check-in and check-out for each shift. | System | High | |
| BR-65 | Attendance logs must record actual timestamps. | System | High | |
| BR-66 | Staff who do not check-in shall be marked as absent. | System | High | |
| BR-68 | Part-time staff are subject to monthly hour limits. | System | Medium | |
| BR-69 | Probationary staff are not eligible for incentive bonuses. | System | Medium | |
| BR-70 | Branch managers may view attendance summaries for their branch. | System | Medium | |
| BR-71 | Each shift must have a defined start time and end time. | System | High | |
| BR-72 | Staff cannot be assigned two overlapping shifts. | System | High | |
| BR-73 | Attendance records must not be physically deleted (soft delete only). | System | High | |
| BR-74 | The system shall automatically calculate total working hours. | System | High | |
| BR-75 | Overtime hours must be flagged separately. | System | Medium | |
| BR-76 | Attendance summaries are compiled monthly. | System | Medium | |
| BR-77 | Staff leave requests must be approved by an admin. | System | High | |
| BR-78 | Late attendance must be displayed on the management dashboard. | System | Medium | |
| BR-80 | Attendance data must be backed up periodically. | System | High | |

---

## 9. Branch Management Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-81 | Each branch has its own vehicle capacity. | System | Medium | |
| BR-82 | Branch managers may only access data for their own branch. | System | High | |
| BR-83 | Customers may book across different branches. | System | Medium | |
| BR-84 | Booking history must include branch information. | System | High | |
| BR-85 | Each branch has independent service availability. | System | Medium | |
| BR-86 | Branch revenue must be tracked separately. | System | High | |
| BR-87 | Each branch has its own operating hours. | System | Medium | |
| BR-88 | Admins may activate or deactivate branches. | Admin | Medium | |
| BR-89 | Each branch maintains its own staff roster. | System | Medium | |
| BR-90 | Promotions may be applied on a per-branch basis. | System | Medium | |

---

## 10. Security & Compliance Rules

| ID | Rule | Enforcement | Priority | Notes |
|----|------|-------------|----------|-------|
| BR-91 | Passwords must be hashed before storage in the database. | System | High | |
| BR-92 | Users may only access features permitted by their assigned role. | System | High | |
| BR-93 | The system must maintain audit logs for critical transactions. | System | High | |
| BR-94 | Every loyalty transaction must be traceable. | System | High | |
| BR-95 | Booking data must be synchronized across all branches. | System | High | |
| BR-97 | The system must handle concurrent bookings to prevent overbooking. | System | High | |
| BR-98 | Behavioral logs must be stored for analytics. | System | Medium | |
| BR-99 | System administrators have full system management privileges. | System | High | |
| BR-100 | Customer data must not be shared with third parties without explicit consent. | System | High | |

---

## Out of Scope

The following areas are explicitly **out of scope** for this business rules document and the current version of AutoWash Pro:

- **Payment gateway implementation** — Integration with external payment processors (e.g., VNPay, Momo, Stripe) is not covered.
- **Handling financial refunds and chargebacks** — Refund workflows, dispute resolution, and chargeback processing are deferred to a future phase.
