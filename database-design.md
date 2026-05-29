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
| branch_id | UUID FK -> branches.id | |
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

### Branches
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| name | TEXT | |
| address | TEXT | |
| capacity | INT | max vehicles per time slot |
| operating_hours | JSONB | e.g. {"mon": {"open": "08:00", "close": "20:00"}} |
| is_active | BOOLEAN | default true |
| created_at | TIMESTAMP | |

### Staff
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| user_id | UUID FK -> users.id | |
| branch_id | UUID FK -> branches.id | primary branch |
| employment_type | TEXT | enum: full_time, part_time |
| probation_end_date | DATE | nullable |
| is_active | BOOLEAN | default true |
| created_at | TIMESTAMP | |

### Shifts
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| staff_id | UUID FK -> staff.id | |
| branch_id | UUID FK -> branches.id | |
| start_time | TIMESTAMP | |
| end_time | TIMESTAMP | |
| created_at | TIMESTAMP | |

### AttendanceRecords
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| staff_id | UUID FK -> staff.id | |
| shift_id | UUID FK -> shifts.id | |
| check_in | TIMESTAMP | nullable |
| check_out | TIMESTAMP | nullable |
| status | TEXT | enum: present, absent, late |
| overtime_hours | DECIMAL | default 0 |
| deleted_at | TIMESTAMP | soft delete only (BR-73) |

### Reviews
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| booking_id | UUID FK -> bookings.id | unique constraint |
| customer_id | UUID FK -> customers.id | |
| rating | INT | 1-5 stars |
| comment | TEXT | nullable |
| created_at | TIMESTAMP | |

### Vouchers
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| code | TEXT | unique |
| customer_id | UUID FK -> customers.id | nullable (global vouchers) |
| discount_type | TEXT | enum: percentage, fixed_amount |
| discount_value | DECIMAL | |
| min_order_value | DECIMAL | nullable |
| expires_at | TIMESTAMP | |
| is_used | BOOLEAN | default false |
| created_at | TIMESTAMP | |

Promotions, RedemptionRecords, Transactions, AnalyticsEvents tables recommended.

Relationships: Customer 1..* Vehicles; Customer 1..* Bookings; Tier 1..* Customers; Branch 1..* Bookings; Branch 1..* Staff; Staff 1..* Shifts; Shift 1..1 AttendanceRecord; Booking 0..1 Review; Customer 0..* Vouchers

---

## Indexing & Performance
- Index foreign keys and commonly filtered columns (status, scheduled_at).
- Use partial indexes for active records (WHERE deleted_at IS NULL).
- Archive historical events to analytics tables for faster OLTP.

## Backup & Compliance
- Daily logical backups, point-in-time recovery for critical datasets.
- PII encryption and retention policies per local law.
