# Database Design — AutoWash Pro

This document proposes relational database schemas (Postgres recommended) for the AutoWash Pro project. Use UUID primary keys, created_at/updated_at timestamps, soft deletes (deleted_at), and appropriate indexes.

## Common conventions
- PK: id UUID
- FK: referenced_id UUID
- Use JSONB for flexible fields (e.g., analytics metadata, promotional details)
- Encrypt sensitive columns (phone) at rest if required

---

## SU26SWP01 — AutoWash Pro Schema (Core Tables)

### Customers
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| name | TEXT | |
| phone_encrypted | TEXT | encrypted |
| default_tier_id | UUID FK -> tiers.id | |
| created_at | TIMESTAMP | |

### Vehicles
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| owner_id | UUID FK -> customers.id | indexed |
| plate | TEXT | unique per owner |
| vehicle_type | TEXT | enum: car, motorbike |

### Tiers
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| name | TEXT | Member, Silver, Gold, Platinum |
| priority | INT | |
| booking_window_days | INT | |

### Bookings
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| slot_id | UUID | |
| vehicle_id | UUID FK -> vehicles.id | |
| status | TEXT | enum: booked, cancelled, completed |
| price_cents | INT | |
| created_at | TIMESTAMP | |

### LoyaltyPoints
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| customer_id | UUID FK -> customers.id | |
| points | INT | |
| reason | TEXT | |
| accrual_date | TIMESTAMP | |
| expires_at | TIMESTAMP | |

Promotions, RedemptionRecords, Transactions, AnalyticsEvents tables recommended.

Relationships: Customer 1..* Vehicles; Customer 1..* Bookings; Tier 1..* Customers

---

## Indexing & Performance
- Index foreign keys and commonly filtered columns (status, scheduled_at).
- Use partial indexes for active records (WHERE deleted_at IS NULL).
- Archive historical events to analytics tables for faster OLTP.

## Backup & Compliance
- Daily logical backups, point-in-time recovery for critical datasets.
- PII encryption and retention policies per local law.
