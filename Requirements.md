# Software Requirements

This document consolidates and refines the requirement entries found in topic.csv into a professional Software Requirements document. Each project section includes: project code, overview, problems, primary actors, functional requirements, main entities, notes, timeline (if provided), and research questions.

---

## Project SU26SWP01 — AutoWash Pro: Smart Automated Car Wash Management System

### Overview
AutoWash Pro is a smart, automated car/motorbike wash management system that integrates AI and CRM technologies to improve customer experience, optimize operations, and increase revenue through advance booking, license-plate recognition (LPR) automation, and a multi-tier loyalty program.

### Context & Problem Statement
- Rapid growth in vehicle ownership in Vietnam has increased demand for wash services. Existing systems lack sophisticated retention mechanisms.
- Current gaps: limited reward schemes ("wash 5 get 1"), no tiered benefits, poor digital tracking of points, history, and perks.

### Objectives
- Increase repeat rate and customer lifetime value via a loyalty engine, tiered booking priority, and data-driven promotions.

### Primary Actors
- Customers (vehicle owners)
- Admins (wash operators)

### Key Features / Functional Requirements
1. Advanced Booking
   - Tier-based booking windows and priority queueing (e.g., Member: 7 days, Silver: 10 days, Gold: 12 days, Platinum: 14 days).
   - Auto-apply perks at checkout.
2. Loyalty Engine
   - Track points, spend, and visits.
   - Auto-upgrade / downgrade tiers (review monthly).
   - Redemption options: points → discounts, free washes, add-ons.
   - Points expire after 12 months.
3. Customer Features
   - Link account to license plate + phone.
   - View points balance and wash history.
   - Tier-based priority booking and perks.
4. Admin Features
   - Configure tier rules, point rates, perks, and targeted promotions (e.g., "Send to Silver+ only").
   - Performance analytics and promotions management.

### Constraints & Notes
- Online payment and refund management are out of scope for implementation by the team.

### Main Entities
- Customer, Booking/Wash History, Promotion, Loyalty Points, Vehicle

### Timeline (Planned — 16 weeks)
- Phase 1 (Weeks 1–4): Prototype, survey, website with account & booking; initial data collection.
- Phase 2 (Weeks 5–7): Complete loyalty, promotion, transaction modules; collect synthetic behavioral dataset (~2k records).
- Phase 3 (Weeks 8–9): External survey data collection (target additional ~3k records).
- Phase 4 (Weeks 10–12): Data processing and cleaning.
- Phase 5 (Weeks 13–16): Generate synthetic behavioral data, train ML models, run analytics, prepare paper submissions.

### Research Questions
- What factors most influence customer loyalty tier progression in smart service ecosystems?
- Research objectives: identify factors that most strongly influence upgrades, retention, and long-term engagement.

---

## Project SU26SWP02 — Personalized Career Orientation & Learning Roadmap Platform

### Overview
A platform to help Software Engineering students choose career tracks, generate prioritized learning roadmaps, manage e-portfolios, and receive personalized AI-driven career advice and market insights.

### Context & Problem Statement
- University curricula can lag industry needs; students face choice paralysis and produce disconnected portfolios that do not convey a coherent story to employers.

### Primary Actors
- SE Students, Academic Counselors, Industry Mentors

### Functional Requirements (by feature)
1. AI Virtual Mentor
   - FR1.1: Natural-language chat interface for career questions.
   - FR1.2: Integrate LLM APIs (e.g., GPT-4/Gemini) to provide technical career advice.
   - FR1.3: Analyze uploaded transcripts and public GitHub profiles to personalize responses.
2. Dynamic Roadmap
   - FR2.1: Users select a Target Career Role (e.g., DevOps, Mobile).
   - FR2.2: Auto-generate a hierarchical skill tree showing prioritized learning nodes.
   - FR2.3: Provide ≥2 curated learning resources per node.
   - FR2.4: Allow marking nodes as Completed and update progress in real time.
3. Skill Gap Analysis
   - FR3.1: Users input/select current technical skills from a predefined list.
   - FR3.2: Map current skills to Target Role requirements.
   - FR3.3: Generate visual/PDF report identifying missing skills and urgent priorities.
4. Market Pulse
   - FR4.1: Scheduled scraping of major IT job portals (daily).
   - FR4.2: Perform keyword frequency analysis on job descriptions to identify trending technologies.
   - FR4.3: Display interactive trend charts for demand of specific skills.
5. E-Portfolio Management
   - FR5.1: Link GitHub accounts and synchronize public repos.
   - FR5.2: Use AI to extract and summarize project objectives and tech stacks from README.md.
   - FR5.3: Generate unique shareable E-Portfolio URLs.
6. User Management
   - FR6.1: Support Email/Password and Google OAuth 2.0 authentication.
   - FR6.2: Persist user chat history, skill assessments, and roadmap progress.

### Main Entities
- Student Profile, Tech Path, Skill Node, Course Repository, Job Trend, Mentor Session

### Research Questions
1. How can AI identify a student's latent talent (e.g., logical thinking vs. UI/UX flair) from coding patterns?
2. How effective is a dynamic roadmap that updates based on real-time job trend analysis?

---

## Project SU26SWP03 — Horse Racing Tournament Management System

### Overview
A management platform for governing horse racing tournaments: registration, scheduling, race management, results tracking, rankings, and bet/result prediction support.

### Context & Problem Statement
- Current horse racing event management is manual and error-prone. Organizers need reliable systems for scheduling, results, and communications.

### Primary Actors
- Horse Owners, Jockeys, Race Referees, Spectators, Admins

### Functional Requirements (actor-focused)
- Horse Owner Capabilities
  - Register an account and horses.
  - Register horses for tournaments and manage horse information.
  - Hire/select jockeys; view schedules and race assignments; track performance and rankings.
- Jockey Capabilities
  - Register and accept/decline race assignments.
  - View assigned races and horse info; track personal race history and stats.
- Race Referee Capabilities
  - Verify horse information before races.
  - Monitor races, record and process infractions, confirm official results, and prepare referee reports.
- Spectator Capabilities
  - View tournament and race information, live results, leaderboards.
  - Make result predictions and receive notifications about outcomes.
- Admin Capabilities
  - Manage user accounts and role-based permissions.
  - Manage tournament and race information, scheduling, participant assignments, referee assignments.
  - Approve registrations, publish official results, and manage prize distributions.

### Main Entities
- Horse Owner, Jockey, Horse, Tournament, Race, Registration, Race Result, Bet, Prize, Referee Report

---

End of document.

---

# Merged Design Details

This section consolidates Business Rules, API design, Database entities, and UI pages for the three projects. Detailed files: business-rules.md, api-design.md, database-design.md (in repository root).

## Common Actors

| Actor | Role / Responsibilities |
|---|---|
| Customer / Student / Spectator | Use services: booking, roadmap, view races; own accounts and data |
| Admin | Configure system settings, approve registrations, publish results, manage tiers/promotions |
| Service Staff / Referee / Mentor | Domain actions: verify results, manage horses, provide mentorship |
| System (Automated) | Loyalty engine, LPR, LLM mentor, scrapers, scheduled jobs |

## Key Business Rules (summary)

| ID | Scope | Rule |
|---|---|---|
| BR-G1 | All | All state-changing actions require authentication (JWT/OAuth) |
| BR-G2 | All | Audit trail for critical events (user, timestamp, action) |
| BR-A02 | AutoWash Pro | Points expire after 12 months from accrual |
| BR-A04 | AutoWash Pro | Higher-tier users have earlier booking windows |
| BR-C02 | Career Roadmap | Market scraping must respect robots.txt and rate limits |
| BR-H01 | Horse Racing | Only admins/referees may publish official race results |

(Full rule set: see business-rules.md)

## Suggested Database Entities (summarized)

| Project | Core Entities |
|---|---|
| AutoWash Pro | Customers, Vehicles, Tiers, Bookings, LoyaltyPoints, Promotions, Transactions |
| Career Roadmap | Users, Roadmaps, RoadmapNodes, Portfolios, LLMQueries, JobTrends |
| Horse Racing | Users, Horses, Jockeys, Tournaments, Races, RaceEntries, RaceResults |

Notes: Use UUID PKs, created_at/updated_at, soft deletes, JSONB for flexible fields. See database-design.md for DDL sketches.

## Representative REST APIs (summary)

Base: /api/v1 — JSON over HTTPS; Authorization: Bearer <token>

| Area | Sample Endpoints |
|---|---|
| Auth | POST /api/v1/auth/register, POST /api/v1/auth/login |
| AutoWash — Booking | GET /api/v1/bookings, POST /api/v1/bookings, DELETE /api/v1/bookings/{id} |
| AutoWash — Loyalty | GET /api/v1/loyalty/balance, POST /api/v1/loyalty/redeem |
| Career — Mentor | POST /api/v1/mentor/query, GET /api/v1/mentor/history |
| Career — Roadmaps | POST /api/v1/roadmaps, PATCH /api/v1/roadmaps/{id}/nodes/{node_id} |
| Racing — Tournament | POST /api/v1/tournaments, POST /api/v1/tournaments/{id}/races |
| Racing — Results | POST /api/v1/races/{id}/results (referee only), GET /api/v1/public/schedule |

(Full endpoints and notes: see api-design.md)

## Suggested Frontend Pages (by project)

### AutoWash Pro
| Page | Purpose |
|---|---|
| Landing / Home | Marketing, sign-up/login |
| Booking Calendar | Tier-aware booking UI with priority windows |
| My Account | Profile, vehicles, loyalty balance, history |
| Admin Dashboard | Tier config, promotions, KPIs |

### Career Roadmap
| Page | Purpose |
|---|---|
| Dashboard | Roadmap progress, recommendations |
| Career Chat | LLM-powered advice UI with history |
| Roadmap Editor | Visual skill-tree editor, mark nodes complete |
| Portfolio | Generated shareable portfolio page |

### Horse Racing
| Page | Purpose |
|---|---|
| Tournament Dashboard | Create/manage tournaments/races |
| Race Detail | Live updates, entrants, results |
| Participant Portal | Horse/jockey management |
| Public Schedule | Spectator-facing schedule and leaderboards |

## GitHub Documentation Structure (recommended)

- /README.md — Project overview and quick start
- /Requirements.md — This merged requirements document (human-readable)
- /business-rules.md — Detailed business rules
- /api-design.md — Full REST API reference (expand with OpenAPI later)
- /database-design.md — Schema and indexing guidance
- /docs/ — Additional guides, diagrams, migrations

## Next steps
1. Convert api-design.md into OpenAPI spec (yaml) and add to /api/openapi.yaml
2. Create ER diagrams from database-design.md and add to /docs/diagrams/
3. Add contribution guidelines and PR template for design discussions

End of document.
