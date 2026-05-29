# Acceptance Criteria — AutoWash Pro (SU26SWP01)

This document specifies the Cucumber-style (`Given-When-Then`) Acceptance Criteria for the core features of the AutoWash Pro system: **Advanced Booking** and the **Loyalty Engine**. It covers both standard operational paths (Happy Paths) and technical boundaries (Edge Cases) to serve as a reliable reference for implementation and QA verification.

---

## Feature: Advanced Booking

### Happy Path: Tier-Based Booking Windows
Ensure that customers can reserve wash slots according to their tier-specific advance windows.

```gherkin
Scenario Outline: Customers can book within their tier-allowed advance booking window
  Given a customer has an authenticated session with a loyalty tier of "<tier>"
  And the system booking lead time policy for "<tier>" is "<allowed_days>" days in advance
  When the customer attempts to reserve a wash slot for "<target_days>" days from today
  Then the system shall approve the slot reservation
  And the system shall proceed to the booking confirmation step

  Examples:
    | tier     | allowed_days | target_days |
    | Member   | 7            | 5           |
    | Silver   | 10           | 9           |
    | Gold     | 12           | 11          |
    | Platinum | 14           | 13          |
```

### Edge Case: Exceeding Advance Booking Window
Ensure that slot booking is restricted if a customer attempts to book further in advance than their tier allows.

```gherkin
Scenario Outline: Customers cannot book beyond their tier-allowed advance booking window
  Given a customer has an authenticated session with a loyalty tier of "<tier>"
  And the system booking lead time policy for "<tier>" is "<allowed_days>" days in advance
  When the customer attempts to reserve a wash slot for "<target_days>" days from today
  Then the system shall deny the reservation request
  And the system shall display the error message "Selected date exceeds your tier advance booking window of <allowed_days> days"

  Examples:
    | tier     | allowed_days | target_days |
    | Member   | 7            | 8           |
    | Silver   | 10           | 11          |
    | Gold     | 12           | 13          |
    | Platinum | 14           | 15          |
```

### Happy Path: Auto-Apply Perks at Checkout
Verify that appropriate perks and discounts are computed and applied automatically during the booking flow.

```gherkin
Scenario: Automatically apply Gold tier perks and discount at checkout
  Given a customer has an authenticated session with a loyalty tier of "Gold"
  And the active system policy defines Gold tier perks as "15% discount on premium services" and "Free vehicle interior vacuuming"
  When the customer selects a "Premium Exterior Wash" service (original price: $40.00)
  And the customer proceeds to the booking checkout interface
  Then the system shall apply a 15% discount, reducing the premium wash cost by $6.00
  And the system shall automatically append "Interior Vacuuming" to the service itemization with a cost of $0.00
  And the system shall display the final computed total as $34.00
```

### Edge Case: Booking Attempt with Downgraded Tier
Verify that slot scheduling windows adapt immediately following a tier downgrade.

```gherkin
Scenario: Customer booking window is restricted after a monthly tier downgrade
  Given a customer's loyalty tier has been downgraded from "Platinum" to "Member" during the monthly scheduled review
  And the advance booking window is 7 days for "Member" tier and 14 days for "Platinum" tier
  When the customer attempts to schedule a wash session for 10 days from today
  Then the system shall deny the booking request
  And the system shall prompt the customer with the message "Selected date exceeds your tier advance booking window of 7 days"
```

---

## Feature: Loyalty Engine

### Happy Path: Point Accrual on Paid Services
Verify that loyalty points are computed and credited only upon successful completion and payment of wash services.

```gherkin
Scenario: Loyalty points are credited upon paid service completion
  Given a customer has a starting point balance of 100 points
  And the system points accrual rate is configured at "1 point per $1 spent"
  When a booking with a total paid value of $80.00 is marked as "Completed" and "Paid" in the database
  Then the system shall credit 80 loyalty points to the customer's account
  And the system shall update the customer's total point balance to 180 points
  And the system shall log a points accrual audit record with the booking identifier
```

### Edge Case: No Point Accrual for Cancelled Bookings
Verify that points are not awarded for services that were booked but not completed.

```gherkin
Scenario: Cancelled and no-show bookings do not accrue points
  Given a customer has a starting point balance of 100 points
  And the system points accrual rate is configured at "1 point per $1 spent"
  When a booking with a total value of $80.00 is updated to "Cancelled" or "No-Show" status
  Then the system shall award 0 points to the customer's account
  And the system shall maintain the customer's point balance at exactly 100 points
```

### Happy Path: Automated Tier Promotion
Verify that customers are automatically upgraded to higher tiers when meeting the spending thresholds.

```gherkin
Scenario Outline: Automated tier promotion on monthly scheduler run
  Given a customer currently holds the loyalty tier "<current_tier>"
  And the monthly scheduler initiates the tier review job
  When the system aggregates the customer's total spending over the last 30 days as "<spending>"
  Then the system shall upgrade the customer's tier status to "<new_tier>"
  And the system shall record a tier upgrade event in the audit logs
  And the system shall dispatch a tier promotion notification to the customer

  Examples:
    | current_tier | spending | new_tier |
    | Member       | $200.00  | Silver   |
    | Silver       | $500.00  | Gold     |
    | Gold         | $1000.00 | Platinum |
```

### Edge Case: Tier Demotion for Inactivity
Verify that customer tiers are downgraded if their spending drops below the active tier requirement.

```gherkin
Scenario: Automated tier demotion due to low spending
  Given a customer currently holds the loyalty tier "Gold"
  And the monthly scheduler initiates the tier review job
  When the system aggregates the customer's total spending over the last 30 days as $40.00
  Then the system shall downgrade the customer's tier status to "Member"
  And the system shall record a tier downgrade event in the audit logs
```

### Happy Path: Points Redemption at Checkout
Verify that points can be successfully converted to discounts, reducing the checkout balance.

```gherkin
Scenario: Successful points redemption at checkout
  Given a customer has an authenticated session with a current balance of 500 points
  And the active system redemption policy is "100 points = $5.00 discount"
  When the customer elects to redeem 200 points for a $10.00 discount on a $45.00 booking
  Then the system shall apply a $10.00 deduction to the invoice total
  And the system shall deduct 200 points from the customer's account atomically
  And the customer's updated balance shall be persisted as 300 points
  And the system shall display the net payable total as $35.00
```

### Edge Case: Insufficient Balance for Redemption
Verify that points redemption is blocked if the customer requests to redeem more points than they possess.

```gherkin
Scenario: Block redemption requests exceeding available points balance
  Given a customer has a current balance of 60 points
  And the active system redemption policy is "100 points = $5.00 discount"
  When the customer attempts to redeem 100 points during checkout
  Then the system shall block the transaction
  And the system shall raise a validation error saying "Insufficient point balance for this redemption"
  And the customer's point balance shall remain unchanged at 60 points
```

### Edge Case: Points Expiration
Verify that points automatically expire after their 12-month validity window closes.

```gherkin
Scenario: Points automatically expire 12 months post-accrual
  Given a customer has a loyalty account with 150 total points
  And 50 of those points were accrued on May 29, 2025
  And the remaining 100 points were accrued on August 15, 2025
  When the system clock advances to May 29, 2026
  And the daily point expiration batch job runs
  Then the system shall expire the 50 points accrued on May 29, 2025
  And the system shall deduct 50 points from the customer's account
  And the system shall persist the customer's updated balance as 100 points
  And the system shall log a points expiration audit record for 50 points
```
