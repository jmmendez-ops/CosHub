import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cos_hub/screens/commerce/costume_detail_screen.dart';
import 'package:cos_hub/screens/shell/home_tab_view.dart';
import 'package:cos_hub/state/cos_hub_store.dart';

void main() {
  group('Anti-Slop Design & Copy Verification (taste-skill & impeccable)', () {
    late CosHubStore store;

    setUp(() {
      store = CosHubStore();
    });

    testWidgets('RED: CostumeDetailScreen must eliminate AI prompt leaks ("Option A Active")',
        (WidgetTester tester) async {
      final rentalCostume = store.catalog.firstWhere((c) => c.canRent);

      await tester.pumpWidget(
        MaterialApp(
          home: CostumeDetailScreen(
            store: store,
            costume: rentalCostume,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Anti-slop invariant: Never expose internal prompt variations to users
      expect(find.textContaining('Option A Active'), findsNothing,
          reason: 'Internal prompt artifacts like "Option A Active" must not leak into production UI');

      // Professional, user-first trust message
      expect(
        find.textContaining('eKYC ID check will be requested at Checkout'),
        findsOneWidget,
      );
    });

    testWidgets('RED: CostumeDetailScreen displays contextual maker tiers instead of monolithic "COMMUNITY LISTING"',
        (WidgetTester tester) async {
      // IronForge PH is a registered artisan armor studio
      final studioCostume = store.catalog.firstWhere(
        (c) => c.sellerName.toLowerCase().contains('ironforge') || c.sellerName.toLowerCase().contains('studio'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CostumeDetailScreen(
            store: store,
            costume: studioCostume,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Monolithic AI slop badge must not appear on artisan studio work
      expect(find.text('COMMUNITY LISTING'), findsNothing,
          reason: 'Artisan studio armor must not be generically labeled as "COMMUNITY LISTING"');

      // Meaningful maker tier badge
      expect(find.text('ARTISAN ATELIER'), findsOneWidget,
          reason: 'Craft studios and armorers must display "ARTISAN ATELIER" badge');
    });

    testWidgets('RED: HomeTabView mode filter chips use cohesive design system pill geometry (rounded.full)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeTabView(store: store),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the "For Rent" mode filter chip
      final rentText = find.text('For Rent');
      expect(rentText, findsOneWidget);

      final containerFinder = find.ancestor(
        of: rentText,
        matching: find.byType(Container),
      ).first;

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        BorderRadius.circular(99),
        reason: 'Mode filter chips must use unified pill geometry matching category chips and DESIGN.md tokens',
      );
    });
  });
}
