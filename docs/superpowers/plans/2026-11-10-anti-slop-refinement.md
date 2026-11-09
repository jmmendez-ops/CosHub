# Anti-Slop Frontend Refinement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Eliminate remaining AI-slop visual tropes, declutter card overlays, add tactile feedback, dynamic sizing chips, and responsive hero typography in COS HUB following `taste-skill` and `impeccable` standards.

**Architecture:** Refactor UI presentation components in `lib/widgets/` and `lib/screens/` to adhere to single-system geometry, tactile touch response (`InkResponse` / `InkWell`), metadata-driven sizing, and uncluttered photography viewports while keeping state and business logic unchanged.

**Tech Stack:** Flutter 3.x / Dart 3, Material 3, `flutter_test`.

**Spec:** [`DESIGN.md`](file:///c:/Users/Cristian/Documents/antigravity/cool-faraday/DESIGN.md), [`PRODUCT.md`](file:///c:/Users/Cristian/Documents/antigravity/cool-faraday/PRODUCT.md), [`taste-skill`](file:///C:/Users/Cristian/.gemini/config/skills/taste-skill/SKILL.md), [`impeccable`](file:///C:/Users/Cristian/.gemini/config/skills/impeccable/SKILL.md).

## Global Constraints

- Preserve all 31 existing tests and zero analyzer warnings.
- Keep primary gold `#F5C230` (`CosColors.accentAmber`) and obsidian backgrounds `#121316` (`CosColors.bgPrimary`).
- Strictly eliminate floating badge clatter across 4 corners of costume image containers.
- Every interactive card and chip must provide tactile press feedback.
- Sizing selectors must reflect costume attributes rather than hardcoded `['S', 'M', 'L', 'XL']`.

## Review Focus

- Grid cards with multiple images, rent-only status, and wishlist toggled simultaneously must not obscure more than 20% of the costume photograph.
- Small viewports (360px wide) must not clip or overflow hero banner text or pricing.
- Tapping cards and buttons on touchscreens must produce active state / ink splash feedback.
- Costumes marked with free-size or custom-fit must render matching chips rather than standard S/M/L/XL.
- Empty states or error fallbacks must preserve the dark atelier aesthetic without blank white ground.

---

### Task 1: Declutter Grid Card Badge Overlays & Add Tactile Feedback

**Files:**
- Modify: `lib/widgets/costume_grid_card.dart`
- Test: `test/anti_slop_ui_test.dart`

**Interfaces:**
- Consumes: `CostumeItem` (model), `CosColors` (tokens)
- Produces: `CostumeGridCard` with consolidated top metadata bar and tactile `InkWell` tap response

- [ ] **Step 1: Write the failing test**

```dart
testWidgets('RED: CostumeGridCard uses InkWell for tactile feedback and avoids 4-corner floating badge clatter', (WidgetTester tester) async {
  final item = store.catalog.firstWhere((c) => c.carouselImages.length > 1 && c.listingMode == ListingMode.rentOnly);
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
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/anti_slop_ui_test.dart -n "CostumeGridCard uses InkWell"`
Expected: FAIL (no InkWell found, 4+ Positioned widgets)

- [ ] **Step 3: Implement minimal code in `lib/widgets/costume_grid_card.dart`**

Replace outer `GestureDetector` with `Material` + `InkWell` for splash ripple; consolidate seller handle and mode into a unified top bar, leaving the bottom of the photo clean with only a discreet photo indicator pill.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/anti_slop_ui_test.dart -n "CostumeGridCard uses InkWell"`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/widgets/costume_grid_card.dart test/anti_slop_ui_test.dart
git commit -m "refactor(ui): declutter grid card overlays and add tactile InkWell feedback"
```

---

### Task 2: Dynamic & Item-Aware Sizing Chips in Detail View

**Files:**
- Modify: `lib/models/costume_item.dart`
- Modify: `lib/screens/commerce/costume_detail_screen.dart`
- Test: `test/anti_slop_ui_test.dart`

**Interfaces:**
- Consumes: `CostumeItem.availableSizes` (List<String>)
- Produces: `CostumeDetailScreen` rendering dynamic size chips matching the specific costume

- [ ] **Step 1: Write the failing test**

```dart
testWidgets('RED: CostumeDetailScreen renders item-specific available sizes instead of hardcoded S/M/L/XL', (WidgetTester tester) async {
  // Find a costume with custom or free size, or verify store provides availableSizes
  final item = store.catalog.first;
  await tester.pumpWidget(
    MaterialApp(
      home: CostumeDetailScreen(store: store, costume: item),
    ),
  );
  await tester.pumpAndSettle();

  // Sizing chips should come from item.availableSizes
  for (final size in item.availableSizes) {
    expect(find.widgetWithText(Container, size), findsWidgets);
  }
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/anti_slop_ui_test.dart -n "item-specific available sizes"`
Expected: FAIL (`availableSizes` getter not defined on `CostumeItem`)

- [ ] **Step 3: Implement `availableSizes` in `CostumeItem` and bind in `CostumeDetailScreen`**

Add `final List<String> availableSizes;` to `CostumeItem` with sensible default `['S', 'M', 'L', 'XL']`, allowing items (props, free-size robes, kimonos) to declare `['Free Size']` or `['Custom Fit']`. Update `CostumeDetailScreen` lines 789-824 to map over `widget.costume.availableSizes`.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/anti_slop_ui_test.dart -n "item-specific available sizes"`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/models/costume_item.dart lib/screens/commerce/costume_detail_screen.dart test/anti_slop_ui_test.dart
git commit -m "feat(commerce): support item-specific sizing chips in detail screen"
```

---

### Task 3: Responsive Hero Banner Padding & Text Constraints

**Files:**
- Modify: `lib/widgets/hero_banner_card.dart`
- Test: `test/anti_slop_ui_test.dart`

**Interfaces:**
- Consumes: `HeroBannerCard`
- Produces: Balanced text layout that breathes naturally without arbitrary 54px left padding squeeze

- [ ] **Step 1: Write the failing test**

```dart
testWidgets('RED: HeroBannerCard layout provides proportional text bounds without rigid maxWidth clipping', (WidgetTester tester) async {
  final item = store.featuredCostumes.first;
  await tester.binding.setSurfaceSize(const Size(360, 800));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: HeroBannerCard(
          costume: item,
          onPrev: () {},
          onNext: () {},
          onViewCostume: () {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();

  // Verify text elements render without overflow in 360px viewport
  expect(tester.takeException(), isNull);
  expect(find.text(item.title), findsOneWidget);
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/anti_slop_ui_test.dart -n "HeroBannerCard layout provides proportional text bounds"`
Expected: Verify behavior under 360px constrained width

- [ ] **Step 3: Implement balanced layout in `lib/widgets/hero_banner_card.dart`**

Replace rigid `Padding(fromLTRB: 54, 18, 16, 18)` and `ConstrainedBox(maxWidth: 215)` with `LayoutBuilder` or flexible column structure, integrating navigation controls as subtle edge overlays that do not displace content margins.

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/anti_slop_ui_test.dart -n "HeroBannerCard layout provides proportional text bounds"`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/widgets/hero_banner_card.dart test/anti_slop_ui_test.dart
git commit -m "refactor(ui): make hero banner layout responsive and remove rigid padding offset"
```

---

### Task 4: Whole-App Visual Regression & Static Analysis Verification

**Files:**
- Test: `test/` (all test files)

**Interfaces:**
- Consumes: Full test suite + Dart analyzer
- Produces: 0 warnings, 100% test pass rate

- [ ] **Step 1: Run full test suite**

Run: `flutter test`
Expected: All tests PASS with zero failures

- [ ] **Step 2: Run static analysis**

Run: `flutter analyze`
Expected: `No issues found!`

- [ ] **Step 3: Commit final plan milestone**

```bash
git commit --allow-empty -m "chore: complete anti-slop frontend refinements"
```
