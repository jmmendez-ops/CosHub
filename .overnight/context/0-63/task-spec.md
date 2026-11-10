# Ticket 0-63 Specification: Implement Order Tracking Domain Models and Store State

### Objective
Implement domain models, state management, and persistence for order tracking in COS HUB.

### Target Files to Create / Modify inside `.worktrees/0-63`:
- Create: `lib/models/order_record.dart`
- Modify: `lib/core/services/cos_hub_storage.dart`
- Modify: `lib/state/cos_hub_store.dart`
- Test: `test/order_tracking_test.dart`

### Model Requirements (`lib/models/order_record.dart`):
1. **`OrderStatus` enum**:
   - `placed` ("Order Placed")
   - `confirmed` ("Order Confirmed")
   - `preparing` ("Costume & Props Prepped")
   - `inTransit` ("Out for Delivery / Courier In Transit")
   - `readyForMeetup` ("Ready for Convention Meetup")
   - `delivered` ("Delivered / Active Rental")
   - `returning` ("Return In Transit")
   - `returned` ("Returned & Inspected")
   - `completed` ("Completed / Deposit Refunded")

2. **`DeliveryMethod` enum**:
   - `lalamove` ("Lalamove Express (Same Day)")
   - `grabExpress` ("Grab Express (Same Day)")
   - `jnt` ("J&T Express Provincial")
   - `conventionMeetup` ("Convention Floor Meetup")

3. **`CourierDetails` class**:
   - `riderName`: String?
   - `riderPhone`: String?
   - `vehiclePlate`: String?
   - `trackingNumber`: String?
   - `estimatedDelivery`: String?
   - `meetupLocation`: String? (e.g. "SMX Convention Center Manila - Hall 2 Booth B-14")
   - `meetupTimeWindow`: String? (e.g. "Nov 12, 2026 • 10:00 AM - 12:00 PM")

4. **`TrackingMilestone` class**:
   - `title`: String
   - `subtitle`: String
   - `timestamp`: String
   - `isCompleted`: bool
   - `isCurrent`: bool

5. **`OrderRecord` class**:
   - `id`: String (e.g. "ORD-2026-8841")
   - `itemTitle`: String
   - `itemCategory`: String
   - `sellerName`: String
   - `sellerHandle`: String
   - `sellerLocation`: String
   - `heroImageUrl`: String?
   - `inclusions`: List<String>
   - `orderMode`: OrderMode (buy or rent)
   - `status`: OrderStatus
   - `deliveryMethod`: DeliveryMethod
   - `courierDetails`: CourierDetails
   - `totalAmount`: int
   - `securityDeposit`: int (0 for buy)
   - `isDepositRefunded`: bool
   - `rentalDays`: int
   - `rentalStartDate`: String?
   - `rentalEndDate`: String?
   - `createdAt`: String
   - `milestones`: List<TrackingMilestone>
   - Complete `toJson()` and `fromJson()` support for clean persistence.

### Store Requirements (`lib/state/cos_hub_store.dart`):
- `List<OrderRecord> orders`: list of user orders.
- `List<OrderRecord> get activeOrders => orders.where((o) => o.status != OrderStatus.completed).toList();`
- `void addOrder(OrderRecord order)`
- `void updateOrderStatus(String orderId, OrderStatus newStatus)`
- Seed 2 realistic active orders (one rental in transit via Lalamove with security deposit, one convention meetup order) and 1 completed purchase order so users see real updates immediately upon testing.
- Persistence via `CosHubStorage` (`saveOrders` / `loadOrders`).

### TDD Requirements (`test/order_tracking_test.dart`):
1. RED: Write tests asserting:
   - `OrderRecord` serializes to and deserializes from JSON without loss.
   - `CosHubStore` initializes with seeded orders and allows adding / updating orders.
   - Active orders filter correctly.
2. GREEN: Implement models and store logic.
3. Verify all 34 existing tests + new tests pass.
4. Verify `flutter analyze` reports 0 issues.
