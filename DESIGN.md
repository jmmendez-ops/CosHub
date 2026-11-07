---
name: COS HUB
description: Philippine Cosplay Buy & Rent Marketplace
colors:
  primary: "#F5C230"
  neutral-bg: "#121316"
  neutral-surface: "#1D1F24"
  neutral-card: "#22242A"
  neutral-input: "#25272E"
  border-subtle: "#313540"
  border-card: "#2B2E36"
  text-primary: "#F9FAFB"
  text-secondary: "#A1A7B3"
  status-verified: "#10B981"
  status-danger: "#EF4444"
  badge-rent: "#8B5CF6"
  badge-buy: "#0EA5E9"
typography:
  display:
    fontFamily: "Roboto, sans-serif"
    fontSize: "24px"
    fontWeight: 900
    lineHeight: 1.2
    letterSpacing: "-0.02em"
  headline:
    fontFamily: "Roboto, sans-serif"
    fontSize: "18px"
    fontWeight: 800
    lineHeight: 1.3
  title:
    fontFamily: "Roboto, sans-serif"
    fontSize: "14px"
    fontWeight: 700
    lineHeight: 1.35
  body:
    fontFamily: "Roboto, sans-serif"
    fontSize: "13.5px"
    fontWeight: 400
    lineHeight: 1.45
  label:
    fontFamily: "Roboto, sans-serif"
    fontSize: "10px"
    fontWeight: 800
    letterSpacing: "0.08em"
rounded:
  sm: "6px"
  md: "10px"
  lg: "16px"
  xl: "20px"
  full: "99px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  xl: "20px"
  xxl: "24px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.neutral-bg}"
    rounded: "{rounded.full}"
    padding: "14px 22px"
  button-primary-hover:
    backgroundColor: "#E5B220"
  chip-size:
    backgroundColor: "{colors.neutral-input}"
    textColor: "{colors.text-primary}"
    rounded: "{rounded.md}"
    padding: "10px 14px"
  chip-size-selected:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.neutral-bg}"
    rounded: "{rounded.md}"
    padding: "10px 14px"
---

# Design System: COS HUB

## Overview

**Creative North Star: "The Convention Armory & Atelier"**

COS HUB blends the precision craft of an artisan cosplay atelier with the functional readiness of an event-ready gear armory. Built for Philippine convention culture, the visual world establishes an immersive, cinematic dark ambiance where authentic costume photography, fabric textures, and props take center stage against deep charcoal and obsidian steel foundations.

The design philosophy favors high-contrast clarity, deliberate restraint, and tactile feedback. Rather than mimicking noisy e-commerce flea markets or generic corporate SaaS, COS HUB treats every costume piece as a valued asset. High-craft studio imagery leads the viewport, supported by structured metadata chips, clear piece manifests, and transparent security deposit indicators.

**Visual Anti-Reference:** Cluttered flea-market classifieds and garish RGB gamer neon. Strictly avoid chaotic rainbow badges, unstyled tables, tacky drop-shadow halos, and walls of undifferentiated body text.

**Key Characteristics:**
- Deep obsidian backdrop (`#121316`) that makes character photography bloom.
- Gilded Aegis Amber Gold (`#F5C230`) reserved strictly for high-intent actions, active states, and verified trust.
- Flat-at-rest tonal elevation hierarchy with razor-sharp 1px structural borders.
- Tactile, rounded-pill touch targets optimized for rapid thumb navigation on mobile or convention floors.
- Granular piece manifests with clear iconography and Asian-fit sizing indicators.

## Colors

The palette balances deep, low-luminance neutral backgrounds with sharp, purposeful accent punches to convey reliability, craftsmanship, and security.

### Primary
- **Aegis Amber Gold** (`#F5C230`): Primary call-to-action buttons, active navigation indicators, rating stars, price highlights, and focus borders. Conveys warmth, prestige, and verified trust.

### Status & Badges
- **Emerald Trust** (`#10B981`): eKYC verified seller badges, confirmed order tags, and secure deposit clearances.
- **Electric Violet** (`#8B5CF6`): Exclusive rental tags (`RENT ONLY`) and deposit duration badges.
- **Sky Cyan** (`#0EA5E9`): Outright purchase tags (`BUY ONLY`) and delivery courier chips.
- **Coral Crimson** (`#EF4444`): Destructive actions, deposit violation warnings, and critical error alerts.

### Neutral
- **Obsidian Carbon** (`#121316`): The primary app canvas and scaffold background. Minimizes eye fatigue in dark convention halls and creates maximum contrast with character costumes.
- **Surface Graphite** (`#1D1F24`): Elevated panels, bottom sheets, app bars, and sticky checkout summaries.
- **Slate Charcoal** (`#22242A`): Card body surfaces, item containers, and list row tiles.
- **Input Bedrock** (`#25272E`): Form field backgrounds, unselected size chips, and search input bars.
- **Subtle Slate Border** (`#313540`): Primary structural 1px dividers, card contours, and input outlines.
- **Card Contour** (`#2B2E36`): Subtle outer card frame border.
- **Crisp Off-White** (`#F9FAFB`): Primary titles, price integers, and high-emphasis headers.
- **Muted Silver** (`#A1A7B3`): Secondary captions, inclusion lists, seller locations, and metadata labels.

### Named Rules
**The Amber Scarcity Rule.** Amber gold is used on ≤10% of any screen surface. It is strictly reserved for primary conversions, active selection states, and verified trust markers. It is never used as wide decorative background fill or secondary body copy.

## Typography

**Display & Body Font:** Roboto, sans-serif (Material 3 standard)  
**Character:** Crisp, geometric, and functional. High-weight numeric displays and bold section headers paired with clean, scannable tabular pricing and micro-labels.

### Hierarchy
- **Display** (FontWeight 900, 24px, Line Height 1.2, Letter Spacing -0.02em): Hero costume titles, splash banners, and major screen headers.
- **Headline** (FontWeight 800, 18px, Line Height 1.3): Section headers, modal titles, and card group titles.
- **Title** (FontWeight 700, 14-15px, Line Height 1.35): Costume card titles, seller names, and rental duration summaries.
- **Body** (FontWeight 400, 13.5px, Line Height 1.45): Costume lore, piece descriptions, policy notes, and reviews.
- **Label** (FontWeight 800, 10-11px, Letter Spacing 0.08em, Uppercase): Order mode labels, category chips, inclusion checkmarks, and table headers.

### Named Rules
**The Tactical Legibility Rule.** All numerical figures (prices, rental days, deposit amounts, piece counts) must use high-weight typography (`w800` or `w900`) and never fall below 12px for immediate legibility in motion.

## Layout

- **Container Model:** Clamped 412px mobile frame wrapper (`MobileFrameWrapper`) centered on desktop web with 34px rounded corners and ambient outer shadow; edge-to-edge on native Android & iOS viewports.
- **Content Padding:** 16px to 18px horizontal page gutters; 8px to 12px card-internal padding.
- **Spacing Scale:**
  - `xs`: 4px (badge icon spacing, micro chips)
  - `sm`: 8px (element spacing, inline badges)
  - `md`: 12px (card element separations, seller info rows)
  - `lg`: 16px (standard section gutters, field margins)
  - `xl`: 20px (major section vertical rhythm)
  - `xxl`: 24px (hero separations, bottom drawer paddings)

## Elevation & Depth

COS HUB utilizes **tonal layering** rather than ambient drop shadows at rest. Depth is established through distinct background luminescence tiers paired with subtle 1px slate borders.

### Shadow Vocabulary
- **Desktop Device Frame Shadow** (`box-shadow: 0 20px 40px rgba(0,0,0,0.75)`): Ambient back-drop isolating the 412px mobile canvas on wide browser viewports.
- **Carousel Dark Gradient Overlay** (`linear-gradient(to top, rgba(20,22,29,0.92) 0%, transparent 60%)`): Protects text contrast over high-detail costume photography.

### Named Rules
**The Flat-at-Rest Rule.** All cards, modal sheets, and chips sit flat at rest with zero fuzzy drop shadows. Separation is achieved through tone shifts (`#121316` -> `#1D1F24` -> `#22242A`) and crisp 1px borders (`#313540`).

## Shapes

- **Micro Badges & Tags:** 4px – 6px corner radius (`rounded.sm`).
- **Form Inputs & Size Chips:** 10px corner radius (`rounded.md`).
- **Costume Cards & Hero Carousels:** 16px – 20px corner radius (`rounded.lg` / `rounded.xl`).
- **CTA Buttons, Avatar Badges & Icon Buttons:** 99px pill radius (`rounded.full`).

## Components

### Buttons
- **Shape:** Pill shape, 99px border radius (`rounded.full`).
- **Primary Action:** Background `#F5C230` (Aegis Amber Gold), foreground `#121316` (Obsidian), padding 14px 22px, font-weight 800.
- **Hover / Active:** Darkens to `#E5B220` with slight scale feedback.
- **Secondary / Ghost:** Outlined border 1px `#313540`, background transparent or `#1D1F24`, text `#F9FAFB`.

### Mode Option Cards (Rent vs Buy)
- **Shape:** 14px rounded rectangle with 1px border.
- **Selected State:** Border color `#F5C230` (Aegis Amber Gold), subtle amber surface tint (`rgba(245, 194, 48, 0.08)`).
- **Unselected State:** Border color `#313540`, background `#1D1F24`, secondary text `#A1A7B3`.

### Costume Grid Card
- **Shape:** 16px rounded rectangle, 1px `#2B2E36` contour border.
- **Visuals:** Top half 48% flex image container with subtle character gradient backing and floating seller badge tag; bottom half slate charcoal `#22242A` holding title, pricing, and action icons.

### Size Selector Chips
- **Shape:** 48x42dp rounded rectangular chips (10px radius).
- **Selected:** Solid `#F5C230` gold fill with `#121316` black typography.
- **Unselected:** `#25272E` input bedrock fill with 1px `#313540` border and off-white typography.

### Bottom Navigation Bar
- **Dimensions:** 68px height, pinned to viewport bottom.
- **Surface:** `#18191D` with 1px top border `#282B33`.
- **Items:** 4 tabs (Home, Cart, Alerts, Wishlist) with amber active states and badge pill counters.

## Do's and Don'ts

### Do:
- **Do** showcase full-bleed photography with high-contrast text overlays backed by directional dark scrim gradients.
- **Do** explicitly display the refundable security deposit amount whenever a rental price is shown.
- **Do** maintain a strict 1px border hierarchy across all card and modal containers to preserve structural sharpness.
- **Do** use uppercase 10px tracking for micro-chips, order modes, and category headers.

### Don't:
- **Don't** use amber gold as a full background for content cards or dialog bodies.
- **Don't** add diffuse, glowing drop shadows under costume cards or body elements.
- **Don't** display rental rates without specifying the daily duration (`/day`) and required deposit.
- **Don't** mix non-standard font families outside the Roboto scale.
