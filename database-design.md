# Database Design

This document proposes relational database schemas (Postgres recommended) for the three projects. Use UUID primary keys, created_at/updated_at timestamps, soft deletes (deleted_at), and appropriate indexes.

## Common conventions
- PK: id UUID
- FK: referenced_id UUID
- Use JSONB for flexible fields (e.g., analytics metadata, LLM response blobs)
- Encrypt sensitive columns (email, phone) at rest if required

---

## SU26SWP01 — AutoWash Pro Schema (Core Tables)

Customers
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| name | TEXT | |
| phone_encrypted | TEXT | encrypted |
| default_tier_id | UUID FK -> tiers.id | |
| created_at | TIMESTAMP | |

Vehicles
| Column | Type | Notes |
|---|---|---|
| id | UUID PK | |
| owner_id | UUID FK -> customers.id | indexed |
| plate | TEXT | unique per owner |
| vehicle_type | TEXT | enum: car, motorbike |

Tiers
| id | UUID PK | name, priority, booking_window_days |

Bookings
| id | UUID PK | slot_id, vehicle_id FK, status (booked/cancelled/completed), price_cents |

LoyaltyPoints
| id | UUID PK | customer_id FK, points INT, reason, accrual_date, expires_at |

Promotions, RedemptionRecords, Transactions, AnalyticsEvents tables recommended.

Relationships: Customer 1..* Vehicles; Customer 1..* Bookings; Tier 1..* Customers

---

## SU26SWP02 — Career Roadmap Schema

Users
| id | UUID PK |
| name | TEXT |
| email_encrypted | TEXT |
| created_at | TIMESTAMP |

Roadmaps
| id | UUID PK | user_id FK, target_role TEXT, metadata JSONB |

RoadmapNodes
| id | UUID PK | roadmap_id FK, title, description, order_index, status enum |

Portfolios
| id | UUID PK | user_id FK, public_url, summary TEXT, metadata JSONB |

LLMQueries
| id | UUID PK | user_id FK, question TEXT, response JSONB, created_at |

JobTrends
| id | UUID PK | skill TEXT, date, frequency INT, source TEXT |

Relationships: User 1..* Roadmaps; Roadmap 1..* Nodes

---

## SU26SWP03 — Horse Racing Schema

Users (owners, jockeys, admins)

Horses
| id | UUID PK | owner_id FK, name, breed, dob, status |

Jockeys
| id | UUID PK | user_id FK, license_number, rating |

Tournaments
| id | UUID PK | name, start_date, end_date, status |

Races
| id | UUID PK | tournament_id FK, scheduled_at, track, status |

RaceEntries
| id | UUID PK | race_id FK, horse_id FK, jockey_id FK, status |

RaceResults
| id | UUID PK | race_id FK, placements JSONB, referee_id FK, published_at |

Bets (if supported later) and RefereeReports tables recommended.

---

## Indexing & Performance
- Index foreign keys and commonly filtered columns (status, scheduled_at).
- Use partial indexes for active records (WHERE deleted_at IS NULL).
- Archive historical events to analytics tables for faster OLTP.

## Backup & Compliance
- Daily logical backups, point-in-time recovery for critical datasets.
- PII encryption and retention policies per local law.


