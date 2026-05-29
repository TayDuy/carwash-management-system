# Frontend Pages — AutoWash Pro

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

---

## 5. Review Pages

### 5.1 Submit Review Page
- **Route**: `/bookings/:id/review`
- **Access**: Customer
- **Purpose**: Allow customers to submit a star rating (1-5) and optional text comment after booking completion (BR-45).
- **Features**:
  - Star rating selector (1-5 stars, interactive)
  - Text area for optional comment
  - Submit button (disabled if booking is not Completed)
  - Success confirmation modal
- **Validation**: Only accessible for bookings with status `Completed` and no existing review (BR-46).

### 5.2 Branch Reviews Dashboard
- **Route**: `/admin/branches/:id/reviews`
- **Access**: Admin, Branch Manager
- **Purpose**: View all customer reviews for a specific branch.
- **Features**:
  - Average rating display with star visualization
  - Filter by rating (1-5)
  - Alert badge for reviews < 3 stars (BR-47)
  - Paginated review list with customer info, rating, comment, and date
  - Export to CSV

---

## 6. Staff & Attendance Pages

### 6.1 Staff List Page
- **Route**: `/admin/branches/:id/staff`
- **Access**: Admin, Branch Manager
- **Purpose**: View and manage staff members assigned to a branch (BR-61, BR-89).
- **Features**:
  - Table: Name, Employment Type (Full-time/Part-time), Probation Status, Active Status
  - Add Staff modal (select user, employment type, probation end date)
  - Edit/Deactivate staff
  - Filter by employment type

### 6.2 Shift Management Page
- **Route**: `/admin/branches/:id/shifts`
- **Access**: Admin, Branch Manager
- **Purpose**: Create and manage shift schedules (BR-71, BR-72).
- **Features**:
  - Calendar/timeline view showing shifts by day
  - Create Shift modal (select staff, start time, end time)
  - Overlap detection warning (BR-72)
  - Drag-and-drop shift rescheduling
  - Color-coded by staff member

### 6.3 Attendance Dashboard
- **Route**: `/admin/branches/:id/attendance`
- **Access**: Admin, Branch Manager
- **Purpose**: View and manage attendance records (BR-70, BR-76).
- **Features**:
  - Daily view: List of staff with check-in/check-out times, status (present/absent/late)
  - Late attendance highlighted in red (BR-78)
  - Monthly summary tab: Total hours, overtime hours (BR-75), absence count
  - Export attendance report
  - Leave request approval queue (BR-77)

### 6.4 Staff Check-in/Check-out Page
- **Route**: `/staff/attendance`
- **Access**: Staff
- **Purpose**: Allow staff members to check-in and check-out for their shifts (BR-64).
- **Features**:
  - Current shift display (start/end time)
  - Check-in button (records actual timestamp)
  - Check-out button (records actual timestamp)
  - Personal attendance history
  - Monthly hours summary

---

## 7. Branch Management Pages

### 7.1 Branch List Page
- **Route**: `/admin/branches`
- **Access**: Admin
- **Purpose**: View and manage all branches (BR-88).
- **Features**:
  - Table: Name, Address, Capacity, Status (Active/Inactive)
  - Create Branch modal
  - Edit branch details
  - Activate/Deactivate toggle (BR-88)
  - Link to branch-specific dashboards (staff, shifts, attendance, reviews, revenue)

### 7.2 Branch Revenue Dashboard
- **Route**: `/admin/branches/:id/revenue`
- **Access**: Admin, Branch Manager
- **Purpose**: View revenue statistics for a specific branch (BR-86).
- **Features**:
  - Revenue charts (daily, weekly, monthly)
  - Comparison with previous periods
  - Top services by revenue
  - Booking count metrics
  - Export revenue report

### 7.3 Branch Settings Page
- **Route**: `/admin/branches/:id/settings`
- **Access**: Admin
- **Purpose**: Configure branch-specific settings (BR-81, BR-85, BR-87).
- **Features**:
  - Vehicle capacity configuration
  - Operating hours editor (per day of week)
  - Service availability toggles
  - Branch-specific promotion settings (BR-90)

---

## 8. Voucher & Promotion Pages

### 8.1 Promotions Management Page
- **Route**: `/admin/promotions`
- **Access**: Admin
- **Purpose**: Create and manage promotional campaigns (BR-41).
- **Features**:
  - Active/Expired/Scheduled promotion tabs
  - Create Promotion form (name, discount type, value, date range, applicable branches, applicable tiers)
  - Edit/Delete promotion
  - Usage statistics per promotion

### 8.2 Voucher Management Page
- **Route**: `/admin/vouchers`
- **Access**: Admin
- **Purpose**: Create and manage vouchers.
- **Features**:
  - Create voucher form (code, discount type/value, expiry, min order value, target customer/branch)
  - Voucher list with status (active/used/expired)
  - Bulk voucher generation
  - Usage tracking

### 8.3 My Vouchers Page (Customer)
- **Route**: `/my-vouchers`
- **Access**: Customer
- **Purpose**: View personal voucher wallet.
- **Features**:
  - Active vouchers with expiry countdown
  - Used vouchers history
  - Expired vouchers (greyed out)
  - Quick copy voucher code
