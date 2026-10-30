import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cos_hub/models/costume_item.dart';
import 'package:cos_hub/state/cos_hub_store.dart';
import 'package:cos_hub/widgets/hero_banner_card.dart';
import 'package:cos_hub/widgets/costume_grid_card.dart';
import 'package:cos_hub/screens/commerce/costume_detail_screen.dart';
import 'package:cos_hub/screens/onboarding/landing_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('COS HUB Catalog & Assets Validation', () {
    late CosHubStore store;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      store = CosHubStore();
    });

    test('Catalog contains exactly 16 verified costume items', () {
      expect(store.catalog.length, equals(16));
      final ids = store.catalog.map((c) => c.id).toList();
      expect(ids, equals([
        'hero-1',
        'prod-1',
        'prod-2',
        'prod-3',
        'prod-4',
        'prod-5',
        'prod-6',
        'prod-7',
        'prod-8',
        'prod-9',
        'prod-10',
        'prod-11',
        'prod-12',
        'prod-13',
        'prod-14',
        'prod-15',
      ]));
    });

    test('hero-1 is verified as Cartethyia (Fleurdelys) from Wuthering Waves', () {
      final hero = store.catalog.firstWhere((c) => c.id == 'hero-1');
      expect(hero.title, equals('Cartethyia Cosplay Set'));
      expect(hero.characterName, equals('Cartethyia (Fleurdelys)'));
      expect(hero.series, equals('Wuthering Waves'));
      expect(hero.category, equals('Anime'));
      expect(hero.heroImageUrl, equals('assets/images/cartethyia.jpg'));
      expect(hero.listingMode, equals(ListingMode.both));
      expect(hero.canBuy, isTrue);
      expect(hero.canRent, isTrue);
      expect(hero.isFeatured, isTrue);
    });

    test('prod-7 preserves Furina (Archon of Fontaine) from Genshin Impact', () {
      final furina = store.catalog.firstWhere((c) => c.id == 'prod-7');
      expect(furina.title, equals('Furina Archon Fontaine Gown & Wig'));
      expect(furina.characterName, equals('Furina (Archon of Fontaine)'));
      expect(furina.series, equals('Genshin Impact'));
      expect(furina.heroImageUrl, equals('assets/images/furina.jpg'));
      expect(furina.listingMode, equals(ListingMode.both));
    });

    test('prod-8 verifies Kyojuro Rengoku from Demon Slayer', () {
      final rengoku = store.catalog.firstWhere((c) => c.id == 'prod-8');
      expect(rengoku.characterName, equals('Kyojuro Rengoku (Flame Hashira)'));
      expect(rengoku.series, equals('Demon Slayer: Kimetsu no Yaiba'));
      expect(rengoku.heroImageUrl, equals('assets/images/rengoku.jpg'));
      expect(rengoku.listingMode, equals(ListingMode.both));
    });

    test('prod-9 verifies Princess Serenity as Rent Only', () {
      final serenity = store.catalog.firstWhere((c) => c.id == 'prod-9');
      expect(serenity.characterName, equals('Princess Serenity'));
      expect(serenity.series, equals('Pretty Guardian Sailor Moon'));
      expect(serenity.heroImageUrl, equals('assets/images/princess_serenity.jpg'));
      expect(serenity.listingMode, equals(ListingMode.rentOnly));
      expect(serenity.canRent, isTrue);
      expect(serenity.canBuy, isFalse);
    });

    test('prod-10 verifies Emilia from Re:Zero', () {
      final emilia = store.catalog.firstWhere((c) => c.id == 'prod-10');
      expect(emilia.characterName, equals('Emilia'));
      expect(emilia.series, equals('Re:Zero - Starting Life in Another World'));
      expect(emilia.heroImageUrl, equals('assets/images/emilia.jpg'));
      expect(emilia.listingMode, equals(ListingMode.both));
    });

    test('prod-11 verifies Zenitsu Agatsuma as Buy Only', () {
      final zenitsu = store.catalog.firstWhere((c) => c.id == 'prod-11');
      expect(zenitsu.characterName, equals('Zenitsu Agatsuma'));
      expect(zenitsu.series, equals('Demon Slayer: Kimetsu no Yaiba'));
      expect(zenitsu.heroImageUrl, equals('assets/images/zenitsu.jpg'));
      expect(zenitsu.listingMode, equals(ListingMode.buyOnly));
      expect(zenitsu.canBuy, isTrue);
      expect(zenitsu.canRent, isFalse);
    });

    test('prod-12 verifies Nico Yazawa from Love Live', () {
      final nico = store.catalog.firstWhere((c) => c.id == 'prod-12');
      expect(nico.characterName, equals('Nico Yazawa'));
      expect(nico.series, equals('Love Live! School Idol Project'));
      expect(nico.heroImageUrl, equals('assets/images/nico_yazawa.jpg'));
    });

    test('prod-13 verifies V from Cyberpunk 2077', () {
      final v = store.catalog.firstWhere((c) => c.id == 'prod-13');
      expect(v.characterName, equals('V (Cyberpunk Mercenary)'));
      expect(v.series, equals('Cyberpunk 2077'));
      expect(v.heroImageUrl, equals('assets/images/v_cyberpunk.jpg'));
    });

    test('prod-14 verifies Kamado Siblings Duo Cosplay Set', () {
      final duo = store.catalog.firstWhere((c) => c.id == 'prod-14');
      expect(duo.title, equals('Kamado Siblings Duo Cosplay Set'));
      expect(duo.characterName, equals('Tanjiro & Nezuko Kamado (Duo)'));
      expect(duo.series, equals('Demon Slayer: Kimetsu no Yaiba'));
      expect(duo.heroImageUrl, equals('assets/images/tanjiro_nezuko.jpg'));
      expect(duo.galleryImageUrls.length, equals(2));
      expect(duo.carouselImages.length, equals(2));
      expect(duo.listingMode, equals(ListingMode.both));
    });

    test('prod-15 verifies Pretty Guardian Sailor Duo Cosplay Set', () {
      final sailorDuo = store.catalog.firstWhere((c) => c.id == 'prod-15');
      expect(sailorDuo.title, equals('Pretty Guardian Sailor Duo Cosplay Set'));
      expect(sailorDuo.characterName, equals('Sailor Moon & Sailor Chibi Moon (Duo)'));
      expect(sailorDuo.series, equals('Pretty Guardian Sailor Moon'));
      expect(sailorDuo.heroImageUrl, equals('assets/images/sailor_duo.jpg'));
      expect(sailorDuo.galleryImageUrls.length, equals(3));
      expect(sailorDuo.carouselImages.length, equals(3));
      expect(sailorDuo.listingMode, equals(ListingMode.both));
    });

    test('Listing mode filtering functions accurately', () {
      store.setModeFilter('Rent Only');
      expect(store.selectedModeFilter, equals('Rent Only'));
      final rentOnlyItems = store.gridCostumes;
      expect(rentOnlyItems.every((c) => c.listingMode == ListingMode.rentOnly), isTrue);
      expect(rentOnlyItems.any((c) => c.id == 'prod-3'), isTrue); // Daedric
      expect(rentOnlyItems.any((c) => c.id == 'prod-9'), isTrue); // Princess Serenity

      store.setModeFilter('Buy Only');
      expect(store.selectedModeFilter, equals('Buy Only'));
      final buyOnlyItems = store.gridCostumes;
      expect(buyOnlyItems.every((c) => c.listingMode == ListingMode.buyOnly), isTrue);
      expect(buyOnlyItems.any((c) => c.id == 'prod-11'), isTrue); // Zenitsu
    });

    test('Initial cart line item is aligned with Cartethyia hero-1', () {
      expect(store.cart.isNotEmpty, isTrue);
      final initialItem = store.cart.first.costume;
      expect(initialItem.id, equals('hero-1'));
      expect(initialItem.characterName, equals('Cartethyia (Fleurdelys)'));
      expect(initialItem.series, equals('Wuthering Waves'));
      expect(initialItem.heroImageUrl, equals('assets/images/cartethyia.jpg'));
    });

    test('All 16 catalog hero and gallery asset files exist on local disk with valid size', () {
      for (final item in store.catalog) {
        expect(item.heroImageUrl, isNotNull);
        expect(item.heroImageUrl!.startsWith('assets/images/'), isTrue);
        final heroFile = File(item.heroImageUrl!);
        expect(heroFile.existsSync(), isTrue, reason: 'Hero file should exist: ${item.heroImageUrl}');
        final size = heroFile.lengthSync();
        expect(size, greaterThan(10000), reason: 'Hero image file ${item.heroImageUrl} should be non-trivial');

        for (final galleryUrl in item.galleryImageUrls) {
          expect(galleryUrl.startsWith('assets/images/'), isTrue);
          final gFile = File(galleryUrl);
          expect(gFile.existsSync(), isTrue, reason: 'Gallery file should exist: $galleryUrl');
          expect(gFile.lengthSync(), greaterThan(10000), reason: 'Gallery image file $galleryUrl should be non-trivial');
        }
      }
    });

    testWidgets('HeroBannerCard renders Image.asset for local assets', (WidgetTester tester) async {
      final hero = store.catalog.firstWhere((c) => c.id == 'hero-1');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeroBannerCard(
              costume: hero,
              onPrev: () {},
              onNext: () {},
              onViewCostume: () {},
            ),
          ),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final Image imageWidget = tester.widget(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/cartethyia.jpg'));
    });

    testWidgets('CostumeGridCard renders RENT ONLY badge for rentOnly items', (WidgetTester tester) async {
      final daedric = store.catalog.firstWhere((c) => c.id == 'prod-3');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              width: 250,
              child: CostumeGridCard(
                costume: daedric,
                isWishlisted: false,
                onToggleWishlist: () {},
                onTapCard: () {},
                onQuickAddToCart: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('RENT ONLY'), findsOneWidget);
      expect(find.text('Rent now'), findsOneWidget);
    });

    testWidgets('CostumeGridCard renders BUY ONLY badge for buyOnly items', (WidgetTester tester) async {
      final zenitsu = store.catalog.firstWhere((c) => c.id == 'prod-11');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              width: 250,
              child: CostumeGridCard(
                costume: zenitsu,
                isWishlisted: false,
                onToggleWishlist: () {},
                onTapCard: () {},
                onQuickAddToCart: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('BUY ONLY'), findsOneWidget);
      expect(find.text('Buy now'), findsOneWidget);
    });

    testWidgets('LandingScreen uses assets/images/cartethyia.jpg', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LandingScreen(
            store: store,
          ),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsWidgets);
      final Image imageWidget = tester.widget(imageFinder.first);
      expect(imageWidget.image, isA<AssetImage>());
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/cartethyia.jpg'));
    });

    test('Payment options setup updates and persists preferences', () async {
      expect(store.selectedPaymentMethod, equals('GCash'));
      store.updatePaymentSetup(
        method: 'Maya',
        gcash: '0917 111 2222',
        maya: '0928 333 4444',
        card: '9999',
      );
      expect(store.selectedPaymentMethod, equals('Maya'));
      expect(store.userMayaNumber, equals('0928 333 4444'));
      expect(store.userCardLast4, equals('9999'));

      // Hydrate a fresh store instance from mocked storage
      final reloadedStore = CosHubStore();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(reloadedStore.selectedPaymentMethod, equals('Maya'));
      expect(reloadedStore.userMayaNumber, equals('0928 333 4444'));
    });

    test('Empty cart persists across reloads without resurrecting defaults', () async {
      store.cart.clear();
      store.completeOrder('GCash', 0); // saves empty cart
      expect(store.cart.isEmpty, isTrue);

      final freshStore = CosHubStore();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(freshStore.cart.isEmpty, isTrue);
    });

    testWidgets('CostumeDetailScreen renders PageView carousel with photo count indicator for multi-image items', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final sailorMoon = store.catalog.firstWhere((c) => c.id == 'prod-1');
      await tester.pumpWidget(
        MaterialApp(
          home: CostumeDetailScreen(
            store: store,
            costume: sailorMoon,
          ),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);
      expect(find.text('1 / 3'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('CostumeGridCard renders photo count badge when multiple images exist', (WidgetTester tester) async {
      final sailorMoon = store.catalog.firstWhere((c) => c.id == 'prod-1');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              width: 250,
              child: CostumeGridCard(
                costume: sailorMoon,
                isWishlisted: false,
                onToggleWishlist: () {},
                onTapCard: () {},
                onQuickAddToCart: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
      expect(find.byIcon(Icons.photo_library_outlined), findsOneWidget);
    });
  });
}
