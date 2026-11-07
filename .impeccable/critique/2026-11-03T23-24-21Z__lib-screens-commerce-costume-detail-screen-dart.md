---
target: lib/screens/commerce/costume_detail_screen.dart
total_score: 28
max_score: 40
na_heuristics: 
p0_count: 0
p1_count: 2
target_identity: "file:C:\\Users\\Cristian\\Documents\\antigravity\\cool-faraday\\lib\\screens\\commerce\\costume_detail_screen.dart"
target_fingerprint: "sha256:4102896f0e82a4d9cc95de91b006378aab940b249ac23aeb339ae435e5638580"
target_path: "C:\\Users\\Cristian\\Documents\\antigravity\\cool-faraday\\lib\\screens\\commerce\\costume_detail_screen.dart"
timestamp: 2026-11-03T23-24-21Z
slug: lib-screens-commerce-costume-detail-screen-dart
closed: true
---
Method: design review only (detector not applicable, native platform)

### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3 | Dynamic total price and deposit update live; lacks rental return timeline feedback |
| 2 | Match System / Real World | 3 | Cosplay domain terms fit well; rental duration is abstract number rather than convention calendar dates |
| 3 | User Control and Freedom | 3 | Mode toggle is fluid; lacks photo pinch-to-zoom or fullscreen lightbox for craft inspection |
| 4 | Consistency and Standards | 3 | Standard mobile e-commerce layout; mixed corner radii (10px chips vs 14px mode cards vs 99px buttons) |
| 5 | Error Prevention | 3 | Rental days clamped (1–14); lacks inventory availability check for specific event dates |
| 6 | Recognition Rather Than Recall | 3 | Clear inclusions checklist; sticky bottom bar keeps price + deposit constantly visible |
| 7 | Flexibility and Efficiency | 2 | No thumbnail strip for rapid image jumping; no option to exclude owned items (e.g., wig) |
| 8 | Aesthetic and Minimalist Design | 3 | High-contrast dark theme aligns with atelier aesthetic; fixed 240px image container crops tall props and poses |
| 9 | Error Recovery | 3 | Wishlisting and mode switches are instantly reversible |
| 10 | Help and Documentation | 2 | Deposit refund timeline and eKYC security terms lack an accessible explainer tooltip |
| **Total** | | **28/40** | **Good (Solid Foundation with High-Impact Growth Areas)** |

### Design Specificity Verdict

**LLM assessment**: The screen demonstrates strong domain awareness tailored to the Philippine cosplay subculture. Inclusions checklists, Asian-fit sizing indicators, eKYC pass badges, and a dual Buy/Rent price calculator directly reflect genuine peer-to-peer costume commerce. However, the visual presentation of the costume itself remains treated like a generic e-commerce thumbnail: the fixed 240px container restricts high-resolution, multi-angle studio assets (such as Cartethyia's full-height silks and weapon poses), cropping dramatic silhouettes and missing the atelier craft feel.

**Deterministic scan**: not applicable (native platform)  
**Visual overlays**: not applicable (native platform)

### Overall Impression

A highly functional, well-structured cosplay commerce detail screen with clear state reactivity and transparent deposit mechanics. The primary bottleneck is the media showcase: the 240px fixed carousel fails to celebrate the high-craft character photography, while the rental duration counter feels detached from real-world convention dates.

### What's Working

1. **Reactive Financial Transparency**: The sticky bottom checkout bar immediately recalculates `Rental Fee + Refundable Security Deposit` or outright `Purchase Price` without layout shift, maintaining user certainty.
2. **Granular Piece Inclusions**: The checkmarked inclusions list prevents con-day missing item disputes by clearly itemizing wigs, accessories, and armor pieces.
3. **High-Contrast Order Mode Cards**: The side-by-side RENT vs BUY cards provide clear visual hierarchy and distinct pricing comparisons.

### Priority Issues

- **[P1] Constrained Carousel Height & Image Cropping**
  - **Why it matters**: Cosplay rentals are visual-first investments. The current 240px height with horizontal padding crops vertical silhouettes, long gowns, and tall weapon props, forcing users to squint or guess fabric quality.
  - **Fix**: Increase the hero media height to at least 320–360dp, implement an aspect-ratio aware container or full-bleed carousel, and introduce a thumbnail strip for quick perspective navigation.
  - **Suggested command**: `/impeccable layout lib/screens/commerce/costume_detail_screen.dart`

- **[P1] Abstract Rental Days Without Real Convention Date Context**
  - **Why it matters**: Cosplayers rent costumes for specific anime conventions (e.g., Friday pickup, Sunday return). An abstract "3 Days" counter forces mental math and creates anxiety regarding whether the costume will arrive before their event.
  - **Fix**: Add calendar date range context (e.g., "Oct 24 – Oct 26 • Convention Weekend") alongside or below the day counter.
  - **Suggested command**: `/impeccable harden lib/screens/commerce/costume_detail_screen.dart`

- **[P2] Deposit Refund Timeline & Guarantee Clarity**
  - **Why it matters**: First-time renters hesitate when seeing a ₱2,500 security deposit without an immediate explanation of how and when funds are refunded to their GCash or Maya wallet.
  - **Fix**: Add an inline info chip or expandable bottom sheet detailing the deposit inspection and 24-hour refund cycle.
  - **Suggested command**: `/impeccable clarify lib/screens/commerce/costume_detail_screen.dart`

- **[P2] Day Stepper Sub-44dp Touch Targets**
  - **Why it matters**: The `-` and `+` day stepper buttons in `RoundIconBtn` measure 30x30dp, violating mobile touch target standards (minimum 44x44dp) and causing mis-taps on mobile devices.
  - **Fix**: Expand the clickable hit-test area to 44x44dp while keeping the visual circle at 34–36dp.
  - **Suggested command**: `/impeccable polish lib/screens/commerce/costume_detail_screen.dart`

### Persona Red Flags

- **Bea (First-Time Con Goer)**: Sees "+ ₱2,500 refundable deposit" next to a ₱1,200 rental rate and worries she won't get her money back if the dress gets convention dust. Abandonment risk at the mode selection card.
- **Kenji (Veteran Prop Artisan & Renter)**: Wants to rent a high-end armored costume but can't zoom in on the 240px image to verify if the pauldron joints and sword prop are convention-security compliant.
- **Alyssa (Competitive Cosplayer)**: Tries to book a costume for Conquest weekend two weeks in advance, but the abstract day stepper doesn't let her select her future event dates.

### Minor Observations

- The size selector chips have a fixed width of 48dp; adding "Custom / Free Size" options will cause text clipping.
- The "COMMUNITY LISTING" badge inside the seller card blends visually with the seller handle due to identical amber styling.
- Missing seller rating breakdown (only the costume's aggregate rating is displayed, omitting seller dispatch speed and reliability).

### Questions to Consider

- What if the photo gallery featured an edge-to-edge cinematic ratio (3:4 or 4:5) with an interactive horizontal thumbnail carousel right below it?
- Could we provide one-tap convention presets (e.g., "Cosplay Manila Weekend • 3 Days") directly in the rental duration section?
- What if piece inclusions included high-res detail popups or "Con-Safe Approved" material badges?
