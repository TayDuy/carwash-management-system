# Frontend Pages & User Flows — AutoWash Pro

Purpose: single reference describing screens, primary actors, key components, and step-by-step user flows for the AutoWash Pro project. Use this to implement UI, wireframes, and route maps.

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

## Common UX Recommendations
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
