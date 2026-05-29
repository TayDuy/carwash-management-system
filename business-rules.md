# Business Rules

This document lists enforceable business rules for the AutoWash Pro project. Each rule includes scope, enforcement type, priority, and notes.

## Rule Table Legend
| Field | Meaning |
|---|---|
| ID | Unique rule identifier |
| Scope | Project or Global |
| Rule | Business rule description |
| Enforcement | System / Admin / Manual |
| Priority | High / Medium / Low |

---

## Global Rules

| ID | Scope | Rule | Enforcement | Priority | Notes |
|---|---:|---|---|---:|---|
| BR-G1 | All | All user actions that modify persistent state require authentication | System | High | JWT-based sessions |
| BR-G2 | All | Audit trail must record user, timestamp, and action for critical events | System | High | Stored in append-only logs |
| BR-G3 | All | PII must be stored encrypted-at-rest and masked in UIs | System/Admin | High | Follow local data regulations |

---

## SU26SWP01 (AutoWash Pro) Rules

| ID | Rule | Enforcement | Priority | Notes |
|---|---|---|---:|---|
| BR-A01 | Loyalty points accrue on completed paid washes only | System | High | Exclude cancelled/no-show bookings |
| BR-A02 | Points expire after 12 months from accrual date | System | High | Batch job to expire points monthly |
| BR-A03 | Tier upgrade/downgrade occurs monthly based on last 30-day metrics | System | Medium | Configurable thresholds via admin UI |
| BR-A04 | Booking priority: higher tier can reserve earlier windows | System | High | Enforce in booking availability queries |
| BR-A05 | Redemption cannot exceed current point balance | System | High | Atomic check-and-debit transaction |
| BR-A06 | Online payment is Out of Scope | Admin | Low | Team will not implement payment/refund gateway |

---

## Out of Scope
- Payment gateway implementation
- Handling financial refunds and chargebacks
