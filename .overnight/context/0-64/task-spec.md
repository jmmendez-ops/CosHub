# Ticket 0-64 Specification: Implement Order Tracking Status Screen with Multi-Stage Stepper and Courier Cards

### Objective
Build a dedicated `OrderTrackingScreen` with a multi-stage visual milestone stepper, live courier tracking card, piece manifest drawer, and rental deposit release tracker, wired into `AlertsTabView` and `CheckoutScreen`.

### Target Files inside `.worktrees/0-64`:
- Create: `lib/screens/commerce/order_tracking_screen.dart`
- Modify: `lib/screens/shell/alerts_tab_view.dart`
- Modify: `lib/screens/commerce/checkout_screen.dart`
- Test: `test/order_tracking_screen_test.dart`

### Component Requirements (`lib/screens/commerce/order_tracking_screen.dart`):
1. **Header & Status Banner:**
   - Order ID (e.g., `#ORD-2026-8841`) with dynamic status pill using theme badges.
   - Costume thumbnail, title, seller handle with verified badge, and order mode indicator.
2. **Live Philippine Logistics Card:**
   - **Lalamove / Grab Express:** Rider avatar/icon, rider name (e.g. "Kuya Danilo Santos"), vehicle plate ("NCR-4819X - Honda Click"), ETA countdown, and call/message mock action buttons.
   - **Convention Floor Meetup:** Convention hall badge, booth coordinates ("SMX Convention Center Manila - Hall 2 Booth B-14"), pickup window ("Nov 12, 2026 • 10:00 AM - 12:00 PM").
   - **J&T Express:** Tracking number, destination hub, transit status.
3. **Multi-Stage Visual Milestone Stepper:**
   - Vertical timeline rendering `order.milestones`.
   - Completed milestones show green checkmarks and timestamps.
   - Current active milestone shows glowing amber indicator and highlighted status note.
   - Pending milestones show subtle muted dots.
4. **Piece Manifest Verification Checklist:**
   - Interactive expansion or list of costume pieces (`order.inclusions`) with verified checkmarks so renters/buyers can verify piece completeness upon arrival.
5. **Rental Timeline & Security Deposit Escrow Tracker (for rentals):**
   - Rental days counter (e.g. "3-Day Rental Window").
   - Refundable security deposit banner with clear escrow status ("Held in Escrow: ₱1,200 — Automatically refunded upon return piece inspection").
   - Action button to simulate / request return courier when rental window ends.

### Integration Requirements:
1. **`lib/screens/shell/alerts_tab_view.dart`:**
   - Add an "ACTIVE ORDERS & TRACKING" section at the top of the Alerts view when `store.activeOrders` is not empty.
   - Render order tracking summary cards with "Track Order" button navigating to `OrderTrackingScreen`.
2. **`lib/screens/commerce/checkout_screen.dart`:**
   - On successful order checkout, construct an `OrderRecord` from cart items, add it to `store.addOrder(...)`, clear cart, and provide a "Track Order" navigation option on the confirmation view.

### TDD Requirements (`test/order_tracking_screen_test.dart`):
1. RED: Write widget tests:
   - `OrderTrackingScreen` renders order ID, costume title, and live courier rider info.
   - Stepper renders all milestones correctly.
   - Alerts view renders active order card with "Track Order" button.
2. GREEN: Implement screen and wire entry points.
3. Verify all 40 existing tests + new screen tests pass.
4. Verify `flutter analyze` reports 0 issues.
