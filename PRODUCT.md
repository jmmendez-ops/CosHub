# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive

## Users

- **Cosplayers & Convention Attendees (Primary Renters & Buyers):** Philippine anime, gaming, and comic cosplayers attending conventions (Cosplay Manila, Conquest, Anime Fair, Otakufest, Best of Anime) needing authentic, event-ready costumes and con-safe props without spending tens of thousands of pesos on single-use outfits.
- **Costume Makers, Wardrobe Owners & Studios (Lenders & Sellers):** Local prop artisans, craft studios, and cosplayers seeking to monetize high-investment wardrobes, manage security deposits safely, and coordinate verified peer-to-peer handoffs.

## Product Purpose

COS HUB is a dedicated peer-to-peer marketplace engineered specifically for the Philippine cosplay ecosystem. It removes the steep financial and storage barriers of cosplay by enabling safe, structured short-term costume rentals (with automated refundable deposit escrow) and outright preloved/brand-new sales with transparent piece inclusions and local logistics.

## Positioning

Unlike unspecialized classified platforms (Facebook Marketplace, Carousell), COS HUB provides:
- Granular costume piece manifests (wig, bodice/armor, props, footwear, accessories) to eliminate missing item disputes.
- Built-in refundable security deposit escrow calculation for rental durations.
- Sizing specifications and seller measurements tailored to Asian body types.
- Trusted Philippine courier and convention-ground handoff workflows (Lalamove, Grab Express, J&T, Con Meetup).
- Optional eKYC trust verification badges to safeguard high-value artisan armor and props.

## Operating Context

- **Currency & Denominations:** Philippine Peso (PHP, ₱).
- **Payment Rails:** GCash, Maya, BDO/BPI online bank transfer, and Cash on Meetup.
- **Logistics & Handoffs:** Same-day motorcycle couriers (Lalamove, Grab Express within Metro Manila/Cebu/Davao), provincial couriers (J&T Express), and in-person convention booth/floor handshakes.
- **Event Seasonality:** Strong activity surges tied to Philippine convention schedules.

## Capabilities and Constraints

- **Multi-Angle Studio Showcase:** Multi-perspective photography carousels (front, 3/4 portrait, back view, action/ground shatter poses) for flagship listings.
- **Dual Transaction Mode:** Seamless toggle between Outright Buy (Brand New / Preloved) and Short-Term Rental with configurable rental day counts.
- **Automated Deposit Calculation:** Transparent security deposit addition with automated refund status tracking.
- **Sizing & Specification Chips:** Standard XS through XL sizing plus Custom/Free Size indicators.
- **Cart & Order Management:** Multi-item cart with delivery option selectors and date pickers.
- **Technical Architecture:** Flutter client-side application with `shared_preferences` persistent storage, responsive mobile frame wrapper (clamped 412px on desktop web, edge-to-edge on mobile).

## Brand Commitments

- **Name:** COS HUB (Philippine Cosplay Buy & Rent Marketplace).
- **Voice & Tone:** Authentic, geek-fluent, community-first, supportive, and reliable.
- **Hero Imagery:** Verified character studio photography collections in `assets/images/studio/` and `assets/images/events/`.

## Evidence on Hand

- 30 researched and documented costume listings across top anime/game franchises (Wuthering Waves, Genshin Impact, Demon Slayer, Final Fantasy, Cyberpunk 2077, NieR: Automata, Elden Ring, Sailor Moon, Jujutsu Kaisen) located in [`lib/state/cos_hub_store.dart`](file:///c:/Users/Cristian/Documents/antigravity/cool-faraday/lib/state/cos_hub_store.dart).
- High-resolution multi-perspective studio photography sets in [`assets/images/studio/`](file:///c:/Users/Cristian/Documents/antigravity/cool-faraday/assets/images/studio/) and [`assets/images/events/`](file:///c:/Users/Cristian/Documents/antigravity/cool-faraday/assets/images/events/).

## Product Principles

1. **Craft Transparency:** Every listing must clearly display exact piece inclusions, fabric quality, and real photography so renters and buyers know what will arrive.
2. **Deposit & Asset Security:** Rental security deposits and lender peace-of-mind are first-class citizens in checkout and UI messaging.
3. **Mobile-First Convention Agility:** Cosplayers navigate the app on the floor or in transit; UI must be thumb-friendly, fast, with readable contrast and high scanability.
4. **Authentic Philippine Localization:** Native integration of Philippine payment methods, courier preferences, and con meetup culture.

## Accessibility & Inclusion

- High contrast text against dark theme backgrounds (WCAG AA compliance on all key data and price points).
- Clear touch target sizing (minimum 44x44 dp) for all buttons, selectors, and chips.
- Clear non-color indicators for transaction statuses (badges with both icons and distinct labels).
