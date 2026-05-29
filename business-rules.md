# Business Rules

This document lists enforceable business rules for all three projects. Each rule includes scope, enforcement type, priority, and notes.

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
| BR-G1 | All | All user actions that modify persistent state require authentication | System | High | JWT-based sessions or OAuth |
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

## SU26SWP02 (Career Roadmap) Rules

| ID | Rule | Enforcement | Priority | Notes |
|---|---|---|---:|---|
| BR-C01 | LLM responses may include external links but must not expose API keys | System | High | Sanitize outputs; proxy external calls if needed |
| BR-C02 | Market scraping must respect robots.txt and rate limits | System | High | Use scheduled jobs & caching |
| BR-C03 | Students control which GitHub repos are synced/shared publicly | System | High | OAuth scopes and consent screens required |
| BR-C04 | Generated reports (PDF) must not contain PII unless user consents | System | Medium | Consent checkbox on generation |

---

## SU26SWP03 (Horse Racing)

| ID | Rule | Enforcement | Priority | Notes |
|---|---|---|---:|---|
| BR-H01 | Only Admins or assigned referees may publish official race results | System | High | Results in "draft" until published |
| BR-H02 | Registrations must be approved before a horse is scheduled in a race | System/Admin | High | Admin action required for approval |
| BR-H03 | Betting/prediction mechanics must clearly mark results as unofficial unless validated | System | High | Distinguish between predictive features and official results |

---

## Out of Scope
- Payment gateway implementation (SU26SWP01)
- Handling financial refunds and chargebacks (SU26SWP01)


