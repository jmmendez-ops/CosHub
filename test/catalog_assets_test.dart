import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cos_hub/state/cos_hub_store.dart';
import 'package:cos_hub/widgets/hero_banner_card.dart';
import 'package:cos_hub/widgets/costume_grid_card.dart';
import 'package:cos_hub/screens/onboarding/landing_screen.dart';

void main() {
  group('COS HUB Catalog & Assets Validation', () {
    late CosHubStore store;

    setUp(() {
      store = CosHubStore();
    });

    test('Catalog contains exactly 8 verified costume items', () {
      expect(store.catalog.length, equals(8));
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
      ]));
    });

    test('hero-1 is verified as Cartethyia (Fleurdelys) from Wuthering Waves', () {
      final hero = store.catalog.firstWhere((c) => c.id == 'hero-1');
      expect(hero.title, equals('Cartethyia Cosplay Set'));
      expect(hero.characterName, equals('Cartethyia (Fleurdelys)'));
      expect(hero.series, equals('Wuthering Waves'));
      expect(hero.category, equals('Anime'));
      expect(hero.heroImageUrl, equals('assets/images/cartethyia.jpg'));
      expect(hero.isFeatured, isTrue);
    });

    test('prod-7 preserves Furina (Archon of Fontaine) from Genshin Impact', () {
      final furina = store.catalog.firstWhere((c) => c.id == 'prod-7');
      expect(furina.title, equals('Furina Archon Fontaine Gown & Wig'));
      expect(furina.characterName, equals('Furina (Archon of Fontaine)'));
      expect(furina.series, equals('Genshin Impact'));
      expect(furina.category, equals('Games'));
      expect(furina.heroImageUrl, equals('assets/images/furina.jpg'));
    });

    test('Initial cart line item is aligned with Cartethyia hero-1', () {
      expect(store.cart.isNotEmpty, isTrue);
      final initialItem = store.cart.first.costume;
      expect(initialItem.id, equals('hero-1'));
      expect(initialItem.characterName, equals('Cartethyia (Fleurdelys)'));
      expect(initialItem.series, equals('Wuthering Waves'));
      expect(initialItem.heroImageUrl, equals('assets/images/cartethyia.jpg'));
    });

    test('All catalog heroImageUrl asset files exist on local disk with valid size', () {
      for (final item in store.catalog) {
        expect(item.heroImageUrl, isNotNull);
        expect(item.heroImageUrl!.startsWith('assets/images/'), isTrue);
        final file = File(item.heroImageUrl!);
        expect(file.existsSync(), isTrue, reason: 'File should exist: ${item.heroImageUrl}');
        final size = file.lengthSync();
        expect(size, greaterThan(10000), reason: 'Image file ${item.heroImageUrl} should be non-trivial');
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

    testWidgets('CostumeGridCard renders Image.asset for local assets', (WidgetTester tester) async {
      final prod1 = store.catalog.firstWhere((c) => c.id == 'prod-1');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              width: 250,
              child: CostumeGridCard(
                costume: prod1,
                isWishlisted: false,
                onToggleWishlist: () {},
                onTapCard: () {},
                onQuickAddToCart: () {},
              ),
            ),
          ),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final Image imageWidget = tester.widget(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/sailor_moon.jpg'));
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
  });
}
