import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cos_hub/models/costume_item.dart';
import 'package:cos_hub/screens/commerce/costume_detail_screen.dart';
import 'package:cos_hub/screens/shell/home_tab_view.dart';
import 'package:cos_hub/state/cos_hub_store.dart';
import 'package:cos_hub/widgets/costume_grid_card.dart';

void main() {
  group('Anti-Slop Design & Copy Verification (taste-skill & impeccable)', () {
    late CosHubStore store;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
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

    testWidgets('RED: CostumeGridCard uses InkWell for tactile feedback and avoids 4-corner floating badge clatter', (WidgetTester tester) async {
      final base = store.catalog.firstWhere((c) => c.carouselImages.length > 1);
      final item = CostumeItem(
        id: base.id,
        title: base.title,
        category: base.category,
        subtitle: base.subtitle,
        buyPrice: base.buyPrice,
        rentPricePerDay: base.rentPricePerDay,
        securityDeposit: base.securityDeposit,
        gradientColors: base.gradientColors,
        motifIcon: base.motifIcon,
        heroImageUrl: base.heroImageUrl,
        galleryImageUrls: base.galleryImageUrls,
        inclusions: base.inclusions,
        rating: base.rating,
        reviewsCount: base.reviewsCount,
        isFeatured: base.isFeatured,
        characterName: base.characterName,
        series: base.series,
        sellerName: base.sellerName,
        sellerHandle: base.sellerHandle,
        sellerLocation: base.sellerLocation,
        isUserListed: base.isUserListed,
        listingMode: ListingMode.rentOnly,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CostumeGridCard(
              costume: item,
              isWishlisted: false,
              onTapCard: () {},
              onToggleWishlist: () {},
              onQuickAddToCart: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Must use InkWell or Material ink response for tactile touch
      expect(find.descendant(of: find.byType(CostumeGridCard), matching: find.byType(InkWell)), findsWidgets);

      // Must consolidate badges instead of scattering 4 separate floating overlays
      final positionedBadges = tester.widgetList<Positioned>(
        find.descendant(of: find.byType(CostumeGridCard), matching: find.byType(Positioned)),
      );
      expect(positionedBadges.length, lessThanOrEqualTo(3),
          reason: 'Costume image must not have badges crammed into all 4 corners simultaneously');
    });
  });
}
