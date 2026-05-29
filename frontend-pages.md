# Frontend Pages & User Flows

Purpose: single reference describing screens, primary actors, key components, and step-by-step user flows for the three projects (AutoWash Pro, Career Roadmap, Horse Racing). Use this to implement UI, wireframes, and route maps.

Conventions
- Screen: named UI view; Route: suggested path
- Primary actor: who primarily uses the screen
- Key components: main UI pieces
- Flow steps: numbered user steps, pre/post conditions, error states

---

## 1) AutoWash Pro (SU26SWP01)

Overview: booking + loyalty + admin dashboards. Responsive mobile-first design.

Screens

| Screen | Route | Primary Actor | Key components |
|---|---|---|---|
| Landing / Home | / | Visitor | Hero, CTA, features, login/signup modal |
| Auth: Login / Register | /login, /register | Customer, Admin | Form, social OAuth, validation |
| Booking Calendar | /booking | Customer | Calendar, slot list, tier filter, priority badge, vehicle selector |
| Booking Details / Confirm | /booking/:id | Customer | Slot summary, points use toggle, perks, confirm button |
| My Account | /account | Customer | Profile, vehicles, loyalty balance, history list |
| Loyalty Wallet | /loyalty | Customer | Points ledger, tier status, redeem CTA |
| Admin Dashboard | /admin | Admin | KPIs, tier config link, promotions table |
| Tier Management | /admin/tiers | Admin | Tier list, create/edit modal, thresholds |
| Promotion Builder | /admin/promotions | Admin | Audience selector, schedule, preview |
| Reports & Analytics | /admin/analytics | Admin | Charts, filters, export CSV |
| Notifications / Inbox | /notifications | Customer/Admin | Read/unread list, deep links |

Primary User Flows

1. Signup & Add Vehicle
   - Pre: user on /register
   - Steps: fill name/phone/password → verify (sms/email) → login → navigate to /account → Add Vehicle (plate, type) → save
   - Success: vehicle listed and selectable in booking flow
   - Errors: duplicate plate, invalid phone -> inline validation

2. Tiered Booking (Customer)
   - Pre: authenticated, vehicle added
   - Steps: /booking → choose date → system shows slots with tier availability/priority badges → select slot → booking details show auto-applied perks and points option → confirm → receive booking confirmation and calendar invite
   - Post: booking appears in /account history; loyalty points may be reserved
   - Edge: slot race condition -> show "slot unavailable" and suggest alternatives

3. Redeem Loyalty (Customer)
   - Pre: sufficient points in /loyalty
   - Steps: choose redemption (discount/free wash) → preview final price → confirm -> points debited (atomic) → show receipt
   - Error: insufficient balance -> disable confirm; show earn-more suggestions

4. Configure Tier & Promotion (Admin)
   - Pre: Admin logged in, role verified
   - Steps: /admin/tiers -> edit threshold -> save -> system runs recalculation job (indicated) → /admin/promotions -> create campaign targeting tiers -> schedule -> preview -> publish
   - Post: targeted customers see promotion in /notifications or email

Edge & Accessibility Notes
- All forms must provide ARIA labels, error text, and keyboard navigation
- Mobile: Booking calendar compact view, priority badges displayed as icons
- Offline: show cached loyalty balance, queue actions for retry

API interactions (examples)
- GET /api/v1/bookings?date= -> fill calendar
- POST /api/v1/bookings -> create booking
- POST /api/v1/loyalty/redeem -> redeem
- Websocket/webhook for live slot updates and admin push notifications

---

## 2) Career Roadmap Platform (SU26SWP02)

Overview: AI mentor chat, dynamic roadmaps, e-portfolio management, market trends.

Screens

| Screen | Route | Primary Actor | Key components |
|---|---|---|---|
| Landing / Home | / | Visitor / Student | Product intro, features, signup CTA |
| Auth | /login, /register | Student, Mentor | Forms, OAuth Google, email verification |
| Dashboard | /dashboard | Student | Roadmap progress, quick actions, recent advice |
| Career Chat | /mentor/chat | Student | Chat transcript, input box, suggested follow-ups, source links |
| Roadmap Builder | /roadmaps/new | Student | Role selector, generated skill-tree, drag/drop nodes |
| Roadmap Viewer | /roadmaps/:id | Student | Node list, progress percent, mark complete action |
| Skill Node Detail | /roadmaps/:id/nodes/:nid | Student | Resources list, practice tasks, time estimate |
| Portfolio | /portfolio | Student | Repo sync status, generated summary, share link |
| Market Trends | /market | Student/Admin | Trend charts, top skills, saved queries |
| Admin: Scraper Jobs | /admin/scrapers | Admin | Job status, last-run, errors |

Primary User Flows

1. AI Mentor Q&A
   - Pre: authenticated or guest with rate limits
   - Steps: /mentor/chat -> ask a question -> UI shows "Thinking…" -> server proxies LLM, returns answer + sources -> user can rate answer, save to history or request clarification
   - Post: conversation stored in /api/v1/mentor/history
   - Edge/Error: LLM rate-limit or error -> show fallback content and suggest search

2. Generate Roadmap
   - Pre: student chooses Target Role
   - Steps: /roadmaps/new -> choose role and preferences -> system generates skill tree (progressive loading) -> user customizes nodes -> save -> shareable roadmap URL created
   - Post: nodes persisted; student can mark nodes complete triggering progress update

3. GitHub Sync & Portfolio Generation
   - Pre: student authorizes GitHub OAuth
   - Steps: Connect OAuth -> list public repos -> select repos to include -> server fetches README, extracts summary -> generate portfolio preview -> publish share link
   - Error: OAuth revoked -> show reconnect instructions

Admin & Background Flows
- Configure scraper schedules and view job logs (/admin/scrapers)
- Run manual re-scrape for a skill or query

Accessibility & UX
- Chat must be accessible (aria-live for new messages)
- Roadmap editor keyboard operations (expand/collapse nodes)
- Export to PDF modal with consent for PII

API interactions
- POST /api/v1/mentor/query
- POST /api/v1/roadmaps
- POST /api/v1/integrations/github/connect (OAuth) -> background sync jobs

---

## 3) Horse Racing Tournament Management (SU26SWP03)

Overview: registration, scheduling, live race updates, result publication, spectator features.

Screens

| Screen | Route | Primary Actor | Key components |
|---|---|---|---|
| Public Home / Schedule | / | Spectator | Upcoming tournaments, search, register interest |
| Auth / Dashboard | /login, /dashboard | Owner, Jockey, Admin | Account summary, role switcher |
| Participant Portal | /participant | Owner/Jockey | Horse list, registration statuses |
| Tournament Builder | /admin/tournaments/new | Admin | Create tournament, date pickers, tracks |
| Race Editor | /admin/tournaments/:id/races | Admin | Create races, assign referees, assign jockeys/horses |
| Race Detail (Live) | /races/:id | Spectator | Entrants, live timing, betting/predictions UI (if any) |
| Results Manager | /admin/races/:id/results | Referee/Admin | Enter placements, add infractions, save as draft, publish |
| Leaderboards | /leaderboards | Spectator | Rankings by tournament/season |

Primary User Flows

1. Register Horse (Owner)
   - Pre: authenticated owner
   - Steps: /participant -> Add Horse -> fill details -> upload documents (vaccination, ID) -> submit for approval -> Admin reviews -> status updated
   - Edge: missing docs -> validation

2. Schedule Race (Admin)
   - Pre: tournament exists
   - Steps: /admin/tournaments/:id -> Add Race -> set scheduled_at -> assign referee -> publish schedule -> notify participants
   - Post: participants confirm via email/portal

3. Record & Publish Results (Referee)
   - Pre: race completed
   - Steps: /admin/races/:id/results -> Enter placements and times -> flag infractions -> Save Draft -> after checks, Publish -> public endpoints reflect official results
   - Edge: dispute -> create referee report and set result status to "under review"

4. Spectator Live View & Predict
   - Pre: race in-progress or scheduled
   - Steps: /races/:id -> view live telemetry/timing -> submit unofficial predictions -> receive notification when results published
   - Note: clearly label predictions as unofficial

Admin & Compliance Notes
- Result publishing requires role-based authorization and audit trail
- File uploads (documents) scanned for allowed types and stored securely

API interactions
- POST /api/v1/tournaments
- POST /api/v1/races/{id}/entries
- POST /api/v1/races/{id}/results (referee only)
- Public GET endpoints for schedule and results

---

## Cross-project UX Recommendations
- Unified auth and profile components for reuse (account dropdown, role switcher)
- Reusable notification component and toast service (websocket-backed)
- Standardize date/time and timezone display across apps
- Internationalization-ready strings; RTL not required but design for translations
- Accessibility: color contrast, keyboard navigation, semantic markup

## Deliverables for Designers & Engineers
- Low-fidelity wireframes for each screen
- High-fidelity prototypes for core flows: Booking, Mentor Chat, Result Publishing
- Component library (React/Vue) with documented props and states
- Route map and OpenAPI-backed mock server for front-end dev


End of frontend-pages.md
