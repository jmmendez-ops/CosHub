import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cos_hub/core/utils/currency_formatter.dart';
import 'package:cos_hub/models/costume_item.dart';
import 'package:cos_hub/models/order_record.dart';
import 'package:cos_hub/screens/commerce/checkout_screen.dart';
import 'package:cos_hub/screens/commerce/order_tracking_screen.dart';
import 'package:cos_hub/screens/shell/alerts_tab_view.dart';
import 'package:cos_hub/state/cos_hub_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CosHubStore store;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    store = CosHubStore();
  });

  group('OrderTrackingScreen Widget Tests', () {
    testWidgets('RED: renders order ID, costume title, status pill, and courier details for Lalamove delivery',
        (WidgetTester tester) async {
      final order = store.orders.firstWhere(
        (o) => o.deliveryMethod == DeliveryMethod.lalamove,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header info
      expect(find.textContaining(order.id), findsOneWidget);
      expect(find.text(order.itemTitle), findsOneWidget);
      expect(find.text(order.sellerHandle), findsOneWidget);
      expect(find.text(order.status.label), findsOneWidget);

      // Courier details
      expect(find.text(order.courierDetails.riderName!), findsOneWidget);
      expect(find.textContaining(order.courierDetails.vehiclePlate!), findsOneWidget);
      expect(find.textContaining(order.courierDetails.trackingNumber!), findsOneWidget);
      expect(find.textContaining(order.courierDetails.estimatedDelivery!), findsOneWidget);
    });

    testWidgets('RED: tapping Call Rider opens simulated in-app VoIP call bottom sheet with rider details and end call action',
        (WidgetTester tester) async {
      final order = store.orders.firstWhere(
        (o) => o.deliveryMethod == DeliveryMethod.lalamove,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final callButton = find.text('Call Rider');
      await tester.ensureVisible(callButton);
      await tester.tap(callButton);
      await tester.pumpAndSettle();

      // Simulated Call Sheet must be displayed
      expect(find.text('In-App Secure Courier Call'), findsOneWidget);
      expect(find.text('End Call'), findsOneWidget);

      // Tap End Call to dismiss
      await tester.tap(find.text('End Call'));
      await tester.pumpAndSettle();
      expect(find.text('In-App Secure Courier Call'), findsNothing);
    });

    testWidgets('RED: tapping Message opens simulated in-app courier chat modal with messages and quick reply chips',
        (WidgetTester tester) async {
      final order = store.orders.firstWhere(
        (o) => o.deliveryMethod == DeliveryMethod.lalamove,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final messageButton = find.text('Message');
      await tester.ensureVisible(messageButton);
      await tester.tap(messageButton);
      await tester.pumpAndSettle();

      // Simulated Chat Sheet must be displayed
      expect(find.textContaining('Courier Direct Chat'), findsOneWidget);
      expect(
        find.textContaining(order.courierDetails.riderName ?? 'Kuya Danilo Santos'),
        findsWidgets,
      );
      expect(find.textContaining('Salamat po Kuya'), findsWidgets);

      // Close modal
      final closeButton = find.byIcon(Icons.close);
      await tester.tap(closeButton);
      await tester.pumpAndSettle();
      expect(find.textContaining('Courier Direct Chat'), findsNothing);
    });

    testWidgets('RED: renders convention floor meetup booth and time window',
        (WidgetTester tester) async {
      final conOrder = store.orders.firstWhere(
        (o) => o.deliveryMethod == DeliveryMethod.conventionMeetup,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: conOrder,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining(conOrder.id), findsOneWidget);
      expect(find.text(conOrder.itemTitle), findsOneWidget);
      expect(find.textContaining(conOrder.courierDetails.meetupLocation!), findsOneWidget);
      expect(find.textContaining(conOrder.courierDetails.meetupTimeWindow!), findsOneWidget);
      expect(find.textContaining('CONVENTION FLOOR MEETUP'), findsOneWidget);
    });

    testWidgets('RED: vertical milestone stepper renders all milestone steps with timestamps',
        (WidgetTester tester) async {
      final order = store.orders.firstWhere((o) => o.milestones.isNotEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (final milestone in order.milestones) {
        expect(find.text(milestone.title), findsOneWidget);
        expect(find.text(milestone.timestamp), findsOneWidget);
      }
    });

    testWidgets('RED: piece manifest checklist renders all inclusions and supports checking pieces',
        (WidgetTester tester) async {
      final order = store.orders.firstWhere((o) => o.inclusions.isNotEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: order,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (final piece in order.inclusions) {
        expect(find.text(piece), findsOneWidget);
      }

      // Check first piece item checkbox / tap after ensuring visible
      final firstPieceFinder = find.text(order.inclusions.first);
      await tester.ensureVisible(firstPieceFinder);
      await tester.tap(firstPieceFinder);
      await tester.pumpAndSettle();
    });

    testWidgets('RED: rental orders display security deposit escrow banner and return button',
        (WidgetTester tester) async {
      final rentalOrder = store.orders.firstWhere(
        (o) => o.isRental && o.securityDeposit > 0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: OrderTrackingScreen(
            order: rentalOrder,
            store: store,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Held in Escrow: ₱1,200'), findsOneWidget);
      expect(find.textContaining('${rentalOrder.rentalDays}-Day Rental Window'), findsOneWidget);
      expect(find.text('Request Return Courier'), findsOneWidget);
    });
  });

  group('AlertsTabView Active Orders Integration Tests', () {
    testWidgets('RED: AlertsTabView renders active orders section and navigates on Track Order tap',
        (WidgetTester tester) async {
      expect(store.activeOrders.isNotEmpty, isTrue);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AlertsTabView(store: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Must display active orders section
      expect(find.text('ACTIVE ORDERS & LIVE TRACKING'), findsOneWidget);

      // Must find at least one "Track Order" button
      final trackButtonFinder = find.text('Track Order');
      expect(trackButtonFinder, findsWidgets);

      // Tapping Track Order pushes OrderTrackingScreen
      await tester.tap(trackButtonFinder.first);
      await tester.pumpAndSettle();

      expect(find.byType(OrderTrackingScreen), findsOneWidget);
    });
  });

  group('CheckoutScreen Order Creation Integration Tests', () {
    testWidgets('RED: successful payment creates OrderRecord, adds to store, and navigates to OrderTrackingScreen',
        (WidgetTester tester) async {
      final costume = store.catalog.first;
      store.addToCart(costume: costume, mode: OrderMode.rent, size: 'M');
      expect(store.cart.length, equals(1));

      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(store: store),
        ),
      );
      await tester.pumpAndSettle();

      // Find pay button dynamically formatted
      final payButton = find.widgetWithText(
        ElevatedButton,
        'Pay ${formatPeso(store.cartGrandTotal)} with GCash',
      );
      expect(payButton, findsOneWidget);

      await tester.tap(payButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // Confirmation dialog
      expect(find.text('Payment Successful!'), findsOneWidget);
      expect(find.text('Track Your Order'), findsOneWidget);

      // Verify order was added to store
      expect(store.orders.first.itemTitle, equals(costume.title));

      // Tap Track Your Order
      await tester.tap(find.text('Track Your Order'));
      await tester.pumpAndSettle();

      expect(find.byType(OrderTrackingScreen), findsOneWidget);
    });
  });
}
