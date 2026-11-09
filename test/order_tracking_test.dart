import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cos_hub/core/services/cos_hub_storage.dart';
import 'package:cos_hub/models/costume_item.dart';
import 'package:cos_hub/models/order_record.dart';
import 'package:cos_hub/state/cos_hub_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('OrderRecord Domain Model Serialization', () {
    test('serializes and deserializes OrderRecord with courier & milestones', () {
      final sampleMilestones = [
        const TrackingMilestone(
          title: 'Order Placed',
          subtitle: 'Order confirmed and payment verified via GCash',
          timestamp: 'Nov 10, 09:30 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        const TrackingMilestone(
          title: 'Out for Delivery',
          subtitle: 'Lalamove rider Kuya Arnel is en route',
          timestamp: 'Nov 10, 01:15 PM',
          isCompleted: true,
          isCurrent: true,
        ),
        const TrackingMilestone(
          title: 'Rental Active',
          subtitle: 'Costume handed over & rental starts',
          timestamp: 'Estimated 2:30 PM',
          isCompleted: false,
          isCurrent: false,
        ),
      ];

      final sampleOrder = OrderRecord(
        id: 'ORD-2026-8841',
        itemTitle: 'Cartethyia Cosplay Set',
        itemCategory: 'Anime',
        sellerName: 'Cristian Ordoñez',
        sellerHandle: '@cristian_cos',
        sellerLocation: 'Calamba, Laguna',
        heroImageUrl: 'assets/images/studio/cartethyia.jpg',
        inclusions: const ['Gown', 'Wig', 'Crown'],
        orderMode: OrderMode.rent,
        status: OrderStatus.inTransit,
        deliveryMethod: DeliveryMethod.lalamove,
        courierDetails: const CourierDetails(
          riderName: 'Kuya Arnel Bautista',
          riderPhone: '0917 555 0192',
          vehiclePlate: 'ND 4821',
          trackingNumber: 'LLM-PH-992014',
          estimatedDelivery: 'Today, 2:30 PM - 3:15 PM',
        ),
        totalAmount: 2220,
        securityDeposit: 1200,
        isDepositRefunded: false,
        rentalDays: 3,
        rentalStartDate: '2026-11-12',
        rentalEndDate: '2026-11-15',
        createdAt: '2026-11-10 09:30 AM',
        milestones: sampleMilestones,
      );

      final jsonMap = sampleOrder.toJson();
      final deserialized = OrderRecord.fromJson(jsonMap);

      expect(deserialized.id, equals('ORD-2026-8841'));
      expect(deserialized.itemTitle, equals('Cartethyia Cosplay Set'));
      expect(deserialized.itemCategory, equals('Anime'));
      expect(deserialized.sellerName, equals('Cristian Ordoñez'));
      expect(deserialized.sellerHandle, equals('@cristian_cos'));
      expect(deserialized.sellerLocation, equals('Calamba, Laguna'));
      expect(deserialized.heroImageUrl, equals('assets/images/studio/cartethyia.jpg'));
      expect(deserialized.inclusions, equals(['Gown', 'Wig', 'Crown']));
      expect(deserialized.orderMode, equals(OrderMode.rent));
      expect(deserialized.status, equals(OrderStatus.inTransit));
      expect(deserialized.deliveryMethod, equals(DeliveryMethod.lalamove));
      expect(deserialized.courierDetails.riderName, equals('Kuya Arnel Bautista'));
      expect(deserialized.courierDetails.riderPhone, equals('0917 555 0192'));
      expect(deserialized.courierDetails.vehiclePlate, equals('ND 4821'));
      expect(deserialized.courierDetails.trackingNumber, equals('LLM-PH-992014'));
      expect(deserialized.courierDetails.estimatedDelivery, equals('Today, 2:30 PM - 3:15 PM'));
      expect(deserialized.totalAmount, equals(2220));
      expect(deserialized.securityDeposit, equals(1200));
      expect(deserialized.isDepositRefunded, isFalse);
      expect(deserialized.rentalDays, equals(3));
      expect(deserialized.rentalStartDate, equals('2026-11-12'));
      expect(deserialized.rentalEndDate, equals('2026-11-15'));
      expect(deserialized.createdAt, equals('2026-11-10 09:30 AM'));
      expect(deserialized.milestones.length, equals(3));
      expect(deserialized.milestones[0].title, equals('Order Placed'));
      expect(deserialized.milestones[0].isCompleted, isTrue);
      expect(deserialized.milestones[1].isCurrent, isTrue);
    });

    test('serializes con-floor meetup order with meetupLocation & time window', () {
      const sampleOrder = OrderRecord(
        id: 'ORD-2026-8842',
        itemTitle: 'Raiden Shogun Narukami Electro Kimono',
        itemCategory: 'Games',
        sellerName: 'Lady Fontaine Studio',
        sellerHandle: '@furina_ph',
        sellerLocation: 'Pasay City, Metro Manila',
        heroImageUrl: 'assets/images/studio/raiden_shogun.jpg',
        inclusions: ['Kimono', 'Pauldron', 'Wig', 'Naginata'],
        orderMode: OrderMode.rent,
        status: OrderStatus.readyForMeetup,
        deliveryMethod: DeliveryMethod.conventionMeetup,
        courierDetails: CourierDetails(
          meetupLocation: 'SMX Convention Center Manila - Hall 2 Booth B-14',
          meetupTimeWindow: 'Nov 12, 2026 • 10:00 AM - 12:00 PM',
          trackingNumber: 'CON-SMX-2611-04',
        ),
        totalAmount: 3300,
        securityDeposit: 2200,
        isDepositRefunded: false,
        rentalDays: 3,
        createdAt: '2026-11-09 02:00 PM',
        milestones: [
          TrackingMilestone(
            title: 'Meetup Confirmed',
            subtitle: 'Booth B-14 reserved with Lady Fontaine Studio',
            timestamp: 'Nov 09, 02:00 PM',
            isCompleted: true,
            isCurrent: false,
          ),
          TrackingMilestone(
            title: 'Ready for Meetup',
            subtitle: 'Costume prepped and stationed at Hall 2 Booth B-14',
            timestamp: 'Nov 12, 09:45 AM',
            isCompleted: true,
            isCurrent: true,
          ),
        ],
      );

      final jsonMap = sampleOrder.toJson();
      final deserialized = OrderRecord.fromJson(jsonMap);

      expect(deserialized.deliveryMethod, equals(DeliveryMethod.conventionMeetup));
      expect(deserialized.courierDetails.meetupLocation,
          equals('SMX Convention Center Manila - Hall 2 Booth B-14'));
      expect(deserialized.courierDetails.meetupTimeWindow,
          equals('Nov 12, 2026 • 10:00 AM - 12:00 PM'));
      expect(deserialized.status, equals(OrderStatus.readyForMeetup));
    });
  });

  group('CosHubStorage Orders Persistence', () {
    test('saveOrders and loadOrders preserve order collection', () async {
      const sampleOrder = OrderRecord(
        id: 'ORD-TEST-1',
        itemTitle: 'Test Outfit',
        itemCategory: 'Anime',
        sellerName: 'Test Seller',
        sellerHandle: '@test_seller',
        sellerLocation: 'Manila',
        inclusions: ['Top', 'Pants'],
        orderMode: OrderMode.buy,
        status: OrderStatus.completed,
        deliveryMethod: DeliveryMethod.jnt,
        courierDetails: CourierDetails(
          trackingNumber: 'JNT-991204',
        ),
        totalAmount: 3400,
        securityDeposit: 0,
        isDepositRefunded: true,
        rentalDays: 0,
        createdAt: '2026-11-01',
        milestones: [],
      );

      await CosHubStorage.saveOrders([sampleOrder]);
      final loaded = await CosHubStorage.loadOrders();

      expect(loaded, isNotNull);
      expect(loaded!.length, equals(1));
      expect(loaded.first.id, equals('ORD-TEST-1'));
      expect(loaded.first.status, equals(OrderStatus.completed));
    });
  });

  group('CosHubStore Order State Management', () {
    test('store initializes with seeded realistic orders and activeOrders filter', () {
      final store = CosHubStore();

      expect(store.orders.length, greaterThanOrEqualTo(3));
      expect(store.activeOrders.length, equals(2));

      // Active orders must not include completed orders
      for (final active in store.activeOrders) {
        expect(active.status, isNot(equals(OrderStatus.completed)));
      }

      // Check seeded active orders presence
      final hasInTransitRental = store.activeOrders.any(
        (o) =>
            o.deliveryMethod == DeliveryMethod.lalamove &&
            o.status == OrderStatus.inTransit &&
            o.orderMode == OrderMode.rent &&
            o.securityDeposit > 0,
      );
      expect(hasInTransitRental, isTrue);

      final hasConMeetup = store.activeOrders.any(
        (o) =>
            o.deliveryMethod == DeliveryMethod.conventionMeetup &&
            o.courierDetails.meetupLocation != null,
      );
      expect(hasConMeetup, isTrue);

      // Check seeded completed order presence
      final hasCompleted = store.orders.any((o) => o.status == OrderStatus.completed);
      expect(hasCompleted, isTrue);
    });

    test('addOrder prepends new order to state and updates activeOrders', () {
      final store = CosHubStore();
      final initialCount = store.orders.length;
      final initialActiveCount = store.activeOrders.length;

      const newOrder = OrderRecord(
        id: 'ORD-NEW-999',
        itemTitle: 'Brand New Costume',
        itemCategory: 'Anime',
        sellerName: 'Maker Studio',
        sellerHandle: '@maker',
        sellerLocation: 'Quezon City',
        inclusions: ['Full Suit'],
        orderMode: OrderMode.rent,
        status: OrderStatus.placed,
        deliveryMethod: DeliveryMethod.grabExpress,
        courierDetails: CourierDetails(),
        totalAmount: 1800,
        securityDeposit: 800,
        isDepositRefunded: false,
        rentalDays: 3,
        createdAt: '2026-11-10 10:00 AM',
        milestones: [],
      );

      store.addOrder(newOrder);

      expect(store.orders.length, equals(initialCount + 1));
      expect(store.orders.first.id, equals('ORD-NEW-999'));
      expect(store.activeOrders.length, equals(initialActiveCount + 1));
      expect(store.activeOrders.first.id, equals('ORD-NEW-999'));
    });

    test('updateOrderStatus modifies order status and updates activeOrders', () {
      final store = CosHubStore();

      final activeOrder = store.activeOrders.first;
      final activeOrderId = activeOrder.id;

      store.updateOrderStatus(activeOrderId, OrderStatus.completed);

      final updated = store.orders.firstWhere((o) => o.id == activeOrderId);
      expect(updated.status, equals(OrderStatus.completed));

      final stillActive = store.activeOrders.any((o) => o.id == activeOrderId);
      expect(stillActive, isFalse);
    });
  });
}
