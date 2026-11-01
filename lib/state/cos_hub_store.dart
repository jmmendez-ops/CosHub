import 'package:flutter/material.dart';
import '../core/services/cos_hub_storage.dart';
import '../core/theme/cos_colors.dart';
import '../core/utils/currency_formatter.dart';
import '../models/app_alert.dart';
import '../models/cart_line_item.dart';
import '../models/costume_item.dart';

class CosHubStore extends ChangeNotifier {
  bool isAuthenticated = false;
  String userName = 'Cristian Ordoñez';
  String userEmail = 'cristian@coshub.ph';
  String userLocation = 'Calamba City, Laguna';

  bool isEkycVerified = false;
  String? verifiedIdType;

  String selectedPaymentMethod = 'GCash';
  String userGcashNumber = '0956 123 3881';
  String userMayaNumber = '0918 888 4567';
  String userCardLast4 = '4821';

  String selectedCategory = 'All';
  String selectedModeFilter = 'All';
  String searchQuery = '';
  int activeBottomTab = 0; // 0: Home, 1: Cart, 2: Alerts, 3: Wishlist
  int heroCarouselIndex = 0;

  final List<String> categories = const [
    'All',
    'Anime',
    'Games',
    'Movies',
    'Comics',
  ];

  final List<String> modeFilters = const [
    'All',
    'For Rent',
    'For Sale',
  ];

  final List<CostumeItem> catalog = const [
    CostumeItem(
      id: 'hero-1',
      title: 'Cartethyia Cosplay Set',
      category: 'Anime',
      characterName: 'Cartethyia (Fleurdelys)',
      series: 'Wuthering Waves',
      subtitle:
          'Ethereal white and sea-blue layered gown, styled long silver wig with side braids, and crystal thorn halo headpiece.',
      buyPrice: 5400,
      rentPricePerDay: 740,
      securityDeposit: 1200,
      sellerName: 'Cristian Ordoñez',
      sellerHandle: '@cristian_cos',
      sellerLocation: 'Calamba, Laguna',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF18202C), Color(0xFF324B6B)],
      motifIcon: Icons.auto_awesome_outlined,
      heroImageUrl: 'assets/images/cartethyia.jpg',
      galleryImageUrls: [
        'assets/images/cartethyia.jpg',
        'assets/images/cartethyia_stage.jpg',
      ],
      inclusions: [
        'Ethereal White & Sea-Blue Layered Draped Gown',
        'Heat-Resistant Long Silver Wig with Braids',
        'Crystal Thorn Halo Crown Headpiece',
        'Silver Armored Gauntlets (Pair)',
      ],
      rating: 4.9,
      reviewsCount: 142,
      isFeatured: true,
    ),
    CostumeItem(
      id: 'prod-1',
      title: 'Super Sailor Moon Sailor Fuku Set',
      category: 'Anime',
      characterName: 'Usagi Tsukino (Super Sailor Moon)',
      series: 'Pretty Guardian Sailor Moon',
      subtitle:
          'Iconic anime sailor fuku with crimson chest bow, crescent moon tiara, pleated navy skirt, and elbow-length gloves.',
      buyPrice: 2850,
      rentPricePerDay: 380,
      securityDeposit: 800,
      sellerName: 'Sailor Amai',
      sellerHandle: '@amai_guardian',
      sellerLocation: 'Quezon City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF5A3386), Color(0xFFBE6498)],
      motifIcon: Icons.dark_mode_outlined,
      heroImageUrl: 'assets/images/sailor_moon.jpg',
      galleryImageUrls: [
        'assets/images/sailor_moon.jpg',
        'assets/images/sailor_moon_scope.jpg',
        'assets/images/sailor_duo.jpg',
      ],
      inclusions: [
        'Sailor Bodice with Gold Heart Brooch',
        'Pleated Navy & White Skirt with Crimson Back Bow',
        'Gold Metal Crescent Moon Tiara & Red Choker',
        'Elbow-Length White Satin Gloves with Padded Cuffs',
        'Red Knee-High Boot Covers',
      ],
      rating: 4.8,
      reviewsCount: 96,
    ),
    CostumeItem(
      id: 'prod-2',
      title: 'Tanjiro Kamado Uniform & Haori Set',
      category: 'Anime',
      characterName: 'Tanjiro Kamado',
      series: 'Demon Slayer: Kimetsu no Yaiba',
      subtitle:
          'Breath-woven green & black checkered haori coat, Demon Slayer corps gakuran uniform, hanafuda earrings, and nichirin sword replica.',
      buyPrice: 3400,
      rentPricePerDay: 490,
      securityDeposit: 900,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF7B1818), Color(0xFFB32B2B)],
      motifIcon: Icons.colorize_outlined,
      heroImageUrl: 'assets/images/tanjiro.jpg',
      galleryImageUrls: [
        'assets/images/tanjiro.jpg',
        'assets/images/tanjiro_nezuko.jpg',
      ],
      inclusions: [
        'Iconic Green & Black Checkered Haori Coat',
        'Demon Slayer Corps Black Gakuran Jacket & Hakama Pants',
        'White Leg Wraps (Kyahan) & White Belt',
        'Con-Safe Bamboo/Wood Core Nichirin Katana & Sheath',
        'Acrylic Hanafuda Earrings (Clip-on)',
      ],
      rating: 4.9,
      reviewsCount: 210,
    ),
    CostumeItem(
      id: 'prod-3',
      title: 'Daedric Heavy Armor Plate Set',
      category: 'Games',
      characterName: 'Daedric Dragon Knight',
      series: 'The Elder Scrolls V: Skyrim',
      subtitle:
          'High-density EVA foam Daedric dragon paladin heavy armor with weathered obsidian finish, glowing crimson runes, and horned helmet.',
      buyPrice: 7200,
      rentPricePerDay: 1050,
      securityDeposit: 1900,
      sellerName: 'IronForge PH',
      sellerHandle: '@ironforge_cos',
      sellerLocation: 'Davao City',
      isUserListed: true,
      listingMode: ListingMode.rentOnly,
      gradientColors: [Color(0xFF475767), Color(0xFF6B7B8E)],
      motifIcon: Icons.shield_outlined,
      heroImageUrl: 'assets/images/daedric.jpg',
      inclusions: [
        'Horned Daedric Full Helm with Crimson Glow Slits',
        'Articulated Spiked EVA Foam Pauldrons & Cuirass',
        'Daedric Greaves, Vambraces & Gauntlets',
        'Con-Safe Weathered Dragon Greatsword Prop',
      ],
      rating: 5.0,
      reviewsCount: 64,
    ),
    CostumeItem(
      id: 'prod-4',
      title: 'David Martinez Cyberpunk EMT Jacket & Rig',
      category: 'Games',
      characterName: 'David Martinez',
      series: 'Cyberpunk: Edgerunners',
      subtitle:
          'High-visibility neon yellow EMT high-collar jacket, illuminated cyberware spine collar insert, cargo pants, and tactical rig harness.',
      buyPrice: 3200,
      rentPricePerDay: 460,
      securityDeposit: 850,
      sellerName: 'Kusarine & Hyou',
      sellerHandle: '@nightcity_edgerunners',
      sellerLocation: 'Makati City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF0E6868), Color(0xFF19A98B)],
      motifIcon: Icons.directions_bike_outlined,
      heroImageUrl: 'assets/images/david_martinez.jpg',
      galleryImageUrls: [
        'assets/images/david_martinez.jpg',
        'assets/images/david_lucy_duo.jpg',
      ],
      inclusions: [
        'Screen-Accurate Neon Yellow EMT Bomber Jacket',
        'Illuminated LED Cyan High-Collar Spine Insert',
        'Black Ribbed Tank Top & Baggy Cargo Pants',
        'Tactical Quick-Release Crossbody Rig Harness',
        'Fingerless Biker Gloves & Cyberware Wrist Decals',
      ],
      rating: 4.7,
      reviewsCount: 78,
    ),
    CostumeItem(
      id: 'prod-5',
      title: 'Kotori Minami Idol Stage Ribbon Dress',
      category: 'Comics',
      characterName: 'Kotori Minami',
      series: 'Love Live! School Idol Project',
      subtitle:
          'Tiered pastel ruffle stage idol performance dress with matching oversized star hairbow, petticoat, and wrist ribbons.',
      buyPrice: 3600,
      rentPricePerDay: 520,
      securityDeposit: 1000,
      sellerName: 'Miyu Idol Wardrobe',
      sellerHandle: '@miyu_idols',
      sellerLocation: 'Mandaluyong, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF8338EC), Color(0xFFFF006E)],
      motifIcon: Icons.auto_awesome,
      heroImageUrl: 'assets/images/kotori.jpg',
      inclusions: [
        'Tiered Ruffle Mint & Lavender Idol Stage Dress',
        'Detachable Crinoline Petticoat & Satin Ribbon Belt',
        'Signature Oversized Star Bow Headband',
        'Frilled Wrist Cuffs & Choker Set',
        'Microphone Headset Prop',
      ],
      rating: 4.8,
      reviewsCount: 53,
    ),
    CostumeItem(
      id: 'prod-6',
      title: 'Din Djarin Mandalorian Beskar Armor & Suit',
      category: 'Movies',
      characterName: 'Din Djarin (The Mandalorian)',
      series: 'Star Wars: The Mandalorian',
      subtitle:
          'Screen-accurate chrome Beskar resin helmet, brown textured flight suit, flak vest, ammunition bandolier, and con-safe blaster.',
      buyPrice: 7900,
      rentPricePerDay: 1150,
      securityDeposit: 2100,
      sellerName: 'Mando Armory PH',
      sellerHandle: '@thisistheway_ph',
      sellerLocation: 'Cebu City',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF2B2D42), Color(0xFF8D99AE)],
      motifIcon: Icons.rocket_launch_outlined,
      heroImageUrl: 'assets/images/mandalorian.jpg',
      inclusions: [
        'Chrome Beskar Full Helmet with Dark T-Visor',
        'Textured Durasteel / Beskar Chest & Shoulder Plates',
        'Weathered Brown Flight Suit & Flak Under-Vest',
        'Leatherette Bandolier Belt with Cartridge Tubes',
        'Heavy Charcoal Mandalorian Cape & Con-safe Blaster',
      ],
      rating: 4.9,
      reviewsCount: 115,
    ),
    CostumeItem(
      id: 'prod-7',
      title: 'Furina Archon Fontaine Gown & Wig',
      category: 'Anime',
      characterName: 'Furina (Archon of Fontaine)',
      series: 'Genshin Impact',
      subtitle:
          'Full stage-accurate Fontaine Archon Victorian frock coat, ruffled jabot, high-top hat, and styled dual-tone silver wig.',
      buyPrice: 5400,
      rentPricePerDay: 740,
      securityDeposit: 1200,
      sellerName: 'Lady Fontaine Studio',
      sellerHandle: '@furina_ph',
      sellerLocation: 'Pasay City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF1E3A8A), Color(0xFF38BDF8)],
      motifIcon: Icons.water_drop_outlined,
      heroImageUrl: 'assets/images/furina.jpg',
      galleryImageUrls: [
        'assets/images/furina.jpg',
        'assets/images/furina_full.jpg',
      ],
      inclusions: [
        'Tailored Victorian Blue Frock Coat & Vest',
        'Dual-Tone Silver Hydro Wig with Tails (Styled)',
        'Ornate Fontaine Ribbon Top Hat Headpiece',
        'Ruffled Lace Jabot Collar & Brooch',
        'Tailored Corset Shorts & White Gloves (Pair)',
      ],
      rating: 4.9,
      reviewsCount: 142,
    ),
    CostumeItem(
      id: 'prod-8',
      title: 'Kyojuro Rengoku Flame Hashira Set',
      category: 'Anime',
      characterName: 'Kyojuro Rengoku (Flame Hashira)',
      series: 'Demon Slayer: Kimetsu no Yaiba',
      subtitle:
          'Dynamic flame-gradient haori coat with white Demon Slayer corps gakuran, fiery styled wig, and flame nichirin katana.',
      buyPrice: 3800,
      rentPricePerDay: 530,
      securityDeposit: 1000,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFDC2626), Color(0xFFF59E0B)],
      motifIcon: Icons.local_fire_department_outlined,
      heroImageUrl: 'assets/images/rengoku.jpg',
      inclusions: [
        'Flame-Patterned Gradient Tailored Haori Coat',
        'Corps Gakuran Uniform Jacket & Hakama Pants',
        'Flame Pattern Kyahan Leg Wraps & White Belt',
        'Con-Safe Wood-Core Flame Nichirin Katana & Sheath',
        'Heat-Resistant Fiery Styled Wig',
      ],
      rating: 5.0,
      reviewsCount: 188,
    ),
    CostumeItem(
      id: 'prod-9',
      title: 'Princess Serenity Moon Palace Gown',
      category: 'Anime',
      characterName: 'Princess Serenity',
      series: 'Pretty Guardian Sailor Moon',
      subtitle:
          'Haute couture floor-length layered white chiffon royal gown with gold embroidery, imperial rings, and angel wings.',
      buyPrice: 8500,
      rentPricePerDay: 1200,
      securityDeposit: 2500,
      sellerName: 'Sailor Amai',
      sellerHandle: '@amai_guardian',
      sellerLocation: 'Quezon City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.rentOnly,
      gradientColors: [Color(0xFFE2E8F0), Color(0xFFFDE68A)],
      motifIcon: Icons.brightness_3_outlined,
      heroImageUrl: 'assets/images/princess_serenity.jpg',
      inclusions: [
        'Hand-Beaded Silk Empire-Waist Chiffon Royal Gown',
        'Golden Imperial Ring Embroidered Corset Bustier',
        'Floor-Length Dual Silk Organza Back Trains',
        'Crescent Moon Gold Tiara Headpiece',
        'Detachable Feather Angel Wings Prop',
      ],
      rating: 4.9,
      reviewsCount: 42,
    ),
    CostumeItem(
      id: 'prod-10',
      title: 'Emilia Spirit Sorceress Royal Robe',
      category: 'Anime',
      characterName: 'Emilia',
      series: 'Re:Zero - Starting Life in Another World',
      subtitle:
          'Elegant white and violet sorceress royal robe with flared sleeves, crystalline flower hairpiece, and Puck familiar companion.',
      buyPrice: 3450,
      rentPricePerDay: 480,
      securityDeposit: 950,
      sellerName: 'Miyu Idol Wardrobe',
      sellerHandle: '@miyu_idols',
      sellerLocation: 'Mandaluyong, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF6B21A8), Color(0xFFA855F7)],
      motifIcon: Icons.auto_awesome,
      heroImageUrl: 'assets/images/emilia.jpg',
      inclusions: [
        'White & Violet Flared Sorceress Robe',
        'Pleated Underskirt & Fitted Bodice',
        'Handmade Crystal Ice Flower Hairpiece',
        'Prosthetic Pointed Elf Ear Covers',
        'Miniature Puck Spirit Cat Plush Clip',
      ],
      rating: 4.8,
      reviewsCount: 89,
    ),
    CostumeItem(
      id: 'prod-11',
      title: 'Zenitsu Agatsuma Thunder Breath Set',
      category: 'Anime',
      characterName: 'Zenitsu Agatsuma',
      series: 'Demon Slayer: Kimetsu no Yaiba',
      subtitle:
          'Con-safe yellow triangle haori set with corps uniform, lightning patterned kyahan, and lightning nichirin blade prop.',
      buyPrice: 2950,
      rentPricePerDay: 0,
      securityDeposit: 0,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.buyOnly,
      gradientColors: [Color(0xFFD97706), Color(0xFFFBBF24)],
      motifIcon: Icons.flash_on_outlined,
      heroImageUrl: 'assets/images/zenitsu.jpg',
      inclusions: [
        'Yellow & Orange Triangle-Gradient Haori Coat',
        'Black Demon Slayer Corps Uniform & White Belt',
        'Triangle-Patterned Kyahan Leg Wraps',
        'Con-Safe Yellow Lightning Nichirin Katana & Sheath',
      ],
      rating: 4.7,
      reviewsCount: 130,
    ),
    CostumeItem(
      id: 'prod-12',
      title: 'Nico Yazawa Idol Festival Stage Dress',
      category: 'Comics',
      characterName: 'Nico Yazawa',
      series: 'Love Live! School Idol Project',
      subtitle:
          'Vibrant pink ruffled idol corset stage dress with oversized satin bows, crinoline underskirt, and stage accessories.',
      buyPrice: 3500,
      rentPricePerDay: 490,
      securityDeposit: 950,
      sellerName: 'Miyu Idol Wardrobe',
      sellerHandle: '@miyu_idols',
      sellerLocation: 'Mandaluyong, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFBE185D), Color(0xFFFB7185)],
      motifIcon: Icons.favorite_outline,
      heroImageUrl: 'assets/images/nico_yazawa.jpg',
      inclusions: [
        'Pink Frilled Idol Stage Corset Dress',
        'Multi-Layer Tulle Crinoline Underskirt',
        'Hot Pink Ribbon Hair Accessories & Choker',
        'Lace Wrist Cuffs & Stage Knee-High Socks',
      ],
      rating: 4.8,
      reviewsCount: 67,
    ),
    CostumeItem(
      id: 'prod-13',
      title: 'V Cyberpunk Mercenary Samurai Jacket',
      category: 'Games',
      characterName: 'V (Cyberpunk Mercenary)',
      series: 'Cyberpunk 2077',
      subtitle:
          'High-collar illuminated Samurai bomber jacket, tactical cargo pants, knee pads, combat holster, and cyberware decals.',
      buyPrice: 4200,
      rentPricePerDay: 620,
      securityDeposit: 1100,
      sellerName: 'Kusarine & Hyou',
      sellerHandle: '@nightcity_edgerunners',
      sellerLocation: 'Makati City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF047857), Color(0xFF10B981)],
      motifIcon: Icons.sports_kabaddi_outlined,
      heroImageUrl: 'assets/images/v_cyberpunk.jpg',
      inclusions: [
        'Light-Up Cyan LED High-Collar Samurai Bomber Jacket',
        'Tactical Mercenary Combat Pants & Knee Pads',
        'Heavy-Duty Holster Rig & Belt',
        'Con-Safe Thermal Katana Replica',
        'Metallic Cyberware Decal Sheet',
      ],
      rating: 4.9,
      reviewsCount: 92,
    ),
    CostumeItem(
      id: 'prod-14',
      title: 'Kamado Siblings Duo Cosplay Set',
      category: 'Anime',
      characterName: 'Tanjiro & Nezuko Kamado (Duo)',
      series: 'Demon Slayer: Kimetsu no Yaiba',
      subtitle:
          'Complete dual cosplay package: Tanjiro Demon Slayer uniform with checkered haori and wooden katana plus Nezuko pink kimono with bamboo muzzle.',
      buyPrice: 5800,
      rentPricePerDay: 790,
      securityDeposit: 1500,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF0F3B2E), Color(0xFFC2410C)],
      motifIcon: Icons.people_outline,
      heroImageUrl: 'assets/images/tanjiro_nezuko.jpg',
      galleryImageUrls: [
        'assets/images/tanjiro_nezuko.jpg',
        'assets/images/tanjiro.jpg',
      ],
      inclusions: [
        'Tanjiro Checkered Haori & Corps Gakuran Uniform',
        'Tanjiro Hanafuda Earrings & Con-Safe Katana Prop',
        'Nezuko Patterned Pink Asanoha Kimono & Black Haori',
        'Nezuko Bamboo Mouthpiece & Pink Ribbon Hairpiece',
        'Two Sets of Kyahan Leg Wraps & Zori Straps',
      ],
      rating: 5.0,
      reviewsCount: 164,
    ),
    CostumeItem(
      id: 'prod-15',
      title: 'Pretty Guardian Sailor Duo Cosplay Set',
      category: 'Anime',
      characterName: 'Sailor Moon & Sailor Chibi Moon (Duo)',
      series: 'Pretty Guardian Sailor Moon',
      subtitle:
          'Dual guardian set featuring Super Sailor Moon and Sailor Chibi Moon sailor fuku uniforms with matching tiaras and wand props.',
      buyPrice: 5200,
      rentPricePerDay: 720,
      securityDeposit: 1400,
      sellerName: 'Sailor Amai',
      sellerHandle: '@amai_guardian',
      sellerLocation: 'Quezon City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF701A75), Color(0xFFF43F5E)],
      motifIcon: Icons.stars_outlined,
      heroImageUrl: 'assets/images/sailor_duo.jpg',
      galleryImageUrls: [
        'assets/images/sailor_duo.jpg',
        'assets/images/sailor_moon.jpg',
        'assets/images/sailor_moon_scope.jpg',
      ],
      inclusions: [
        'Adult Super Sailor Moon Sailor Bodice, Skirt & Brooch',
        'Sailor Chibi Moon Pink Sailor Bodice & Pleated Skirt',
        'Two Matching Golden Metal Crescent Moon Tiaras',
        'Two Pairs of White Satin Elbow Gloves with Colored Cuffs',
        'Moon Kaleido Scope & Pink Sugar Heart Wand Con Props',
      ],
      rating: 4.9,
      reviewsCount: 112,
    ),
    CostumeItem(
      id: 'prod-16',
      title: 'Raiden Shogun Narukami Electro Kimono',
      category: 'Games',
      characterName: 'Raiden Shogun (Ei)',
      series: 'Genshin Impact',
      subtitle:
          'Regal Inazuma electro archon layered silk kimono, gold pauldrons, obi sash with electro crest, and con-safe Musou Isshin naginata replica.',
      buyPrice: 7800,
      rentPricePerDay: 1100,
      securityDeposit: 2200,
      sellerName: 'Lady Fontaine Studio',
      sellerHandle: '@furina_ph',
      sellerLocation: 'Pasay City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
      motifIcon: Icons.bolt,
      heroImageUrl: 'assets/images/raiden_shogun.jpg',
      galleryImageUrls: [
        'assets/images/raiden_shogun.jpg',
        'assets/images/raiden_shogun_pose.jpg',
      ],
      inclusions: [
        'Embroidered Violet & Gold Silk Layered Kimono',
        'Inazuma Electro Mitsudomoe Gold Pauldron & Obi Sash',
        'Pre-styled Long Dark Purple Braided Wig with Hairpin',
        'Con-Safe Musou Isshin Naginata Polearm Prop',
        'Purple Thigh-High Stockings & Geta Sandals',
      ],
      rating: 5.0,
      reviewsCount: 312,
      isFeatured: true,
    ),
    CostumeItem(
      id: 'prod-17',
      title: 'YoRHa No. 2 Type B Battle Dress Set',
      category: 'Games',
      characterName: '2B (YoRHa No. 2 Type B)',
      series: 'NieR: Automata',
      subtitle:
          'Haute gothic black velvet battle dress with silver filigree chest cutout, feathered sleeves, blindfold visor, and Virtuous Contract katana.',
      buyPrice: 6900,
      rentPricePerDay: 980,
      securityDeposit: 1900,
      sellerName: 'IronForge PH',
      sellerHandle: '@ironforge_cos',
      sellerLocation: 'Davao City',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF212121), Color(0xFF616161)],
      motifIcon: Icons.visibility_off_outlined,
      heroImageUrl: 'assets/images/nier_2b.jpg',
      galleryImageUrls: [
        'assets/images/nier_2b.jpg',
        'assets/images/nier_2b_katana.jpg',
      ],
      inclusions: [
        'Embroidered Black Velvet High-Slit Battle Dress',
        'Feathered Sleeve Cuffs & White Ruffled Underskirt',
        'YoRHa Black Suede Combat Blindfold Visor',
        'Thigh-High Faux Leather Combat Boots & Gloves',
        'Con-Safe Virtuous Contract Katana Prop with Tassel',
      ],
      rating: 4.9,
      reviewsCount: 275,
      isFeatured: true,
    ),
    CostumeItem(
      id: 'prod-18',
      title: 'Malenia Blade of Miquella Valkyrie Armor',
      category: 'Games',
      characterName: 'Malenia (Blade of Miquella)',
      series: 'Elden Ring',
      subtitle:
          'Masterclass weathered gold-finished EVA foam unalloyed armor, iconic winged helm, articulated prosthetic arm, and Waterfowl katana replica.',
      buyPrice: 10500,
      rentPricePerDay: 1450,
      securityDeposit: 2800,
      sellerName: 'IronForge PH',
      sellerHandle: '@ironforge_cos',
      sellerLocation: 'Davao City',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFB45309), Color(0xFFD97706)],
      motifIcon: Icons.shield,
      heroImageUrl: 'assets/images/malenia.jpg',
      galleryImageUrls: [
        'assets/images/malenia.jpg',
        'assets/images/malenia_helm.jpg',
      ],
      inclusions: [
        'Hand-Weathered Golden Winged Valkyrie Full Helm',
        'Articulated Gold Unalloyed Prosthetic Arm & Gauntlet',
        'Flowing Burnt Orange Chiffon Cape & Slit Tunic',
        'High-Density EVA Greaves & Thigh Plates',
        'Con-Safe 5-Foot Waterfowl Dance Katana Replica',
      ],
      rating: 5.0,
      reviewsCount: 198,
      isFeatured: true,
    ),
    CostumeItem(
      id: 'prod-19',
      title: 'Cloud Strife SOLDIER 1st Class Uniform',
      category: 'Games',
      characterName: 'Cloud Strife',
      series: 'Final Fantasy VII Rebirth',
      subtitle:
          'Ribbed indigo SOLDIER turtleneck vest, shoulder pauldron with bolts, harness belt, baggy combat trousers, and iconic Buster Sword prop.',
      buyPrice: 6200,
      rentPricePerDay: 880,
      securityDeposit: 1700,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF1E293B), Color(0xFF334155)],
      motifIcon: Icons.sports_kabaddi,
      heroImageUrl: 'assets/images/cloud_strife.jpg',
      galleryImageUrls: [
        'assets/images/cloud_strife.jpg',
        'assets/images/cloud_buster_sword.jpg',
      ],
      inclusions: [
        'Ribbed Navy SOLDIER Sleeveless Knit Turtleneck',
        'Riveted Steel-Look Shoulder Pauldron & Chest Harness',
        'Baggy SOLDIER Khaki Combat Trousers & Suspenders',
        'Spiked Blonde Heat-Resistant Styled Wig',
        'Con-Safe Lightweight Foam-Core Buster Sword with Materia Slots',
      ],
      rating: 4.9,
      reviewsCount: 220,
    ),
    CostumeItem(
      id: 'prod-20',
      title: 'Jinx Arcane Loose Cannon Punk Set',
      category: 'Games',
      characterName: 'Jinx',
      series: 'League of Legends / Arcane',
      subtitle:
          'Striped punk crop halter, cloud tattoo sleeve decals, bullet belt, fingerless biker gloves, and Fishbones shark rocket launcher.',
      buyPrice: 5600,
      rentPricePerDay: 780,
      securityDeposit: 1500,
      sellerName: 'Kusarine & Hyou',
      sellerHandle: '@nightcity_edgerunners',
      sellerLocation: 'Makati City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFBE185D), Color(0xFF06B6D4)],
      motifIcon: Icons.whatshot,
      heroImageUrl: 'assets/images/jinx_arcane.jpg',
      galleryImageUrls: [
        'assets/images/jinx_arcane.jpg',
        'assets/images/jinx_fishbones.jpg',
      ],
      inclusions: [
        'Burgundy & Black Striped Punk Crop Top & Halter',
        'Dual-Tone Flare Combat Pants with Bullet Bandolier',
        'Floor-Length Neon Blue Braided Pigtail Wig',
        'Con-Safe Fishbones Shark Mouth Rocket Launcher Replica',
        'Waterproof Chemtech Cloud Sleeve Tattoo Decals',
      ],
      rating: 4.8,
      reviewsCount: 167,
    ),
    CostumeItem(
      id: 'prod-21',
      title: 'Frieren Great Mage Sorceress Robe',
      category: 'Anime',
      characterName: 'Frieren',
      series: 'Frieren: Beyond Journey\'s End',
      subtitle:
          'Gold-trimmed white and black sorceress capelet, striped underskirt, ruby droplet earrings, elf ears, and crescent staff prop.',
      buyPrice: 4800,
      rentPricePerDay: 680,
      securityDeposit: 1300,
      sellerName: 'Miyu Idol Wardrobe',
      sellerHandle: '@miyu_idols',
      sellerLocation: 'Mandaluyong, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF047857), Color(0xFF10B981)],
      motifIcon: Icons.auto_awesome,
      heroImageUrl: 'assets/images/frieren.jpg',
      galleryImageUrls: [
        'assets/images/frieren.jpg',
        'assets/images/frieren_wand.jpg',
      ],
      inclusions: [
        'Gold-Accented White Flared Sorceress Capelet',
        'Pleated Underskirt & Fitted Black Long-Sleeve Blouse',
        'Ruby Drop Clip-On Earrings & Prosthetic Elf Ears',
        'Dual White Twin-Tail Styled Heat-Resistant Wig',
        'Con-Safe Crescent Moon Sorceress Staff Prop',
      ],
      rating: 4.9,
      reviewsCount: 245,
    ),
    CostumeItem(
      id: 'prod-22',
      title: 'Gojo Satoru Limitless Jujutsu High Uniform',
      category: 'Anime',
      characterName: 'Gojo Satoru',
      series: 'Jujutsu Kaisen',
      subtitle:
          'Dark navy tailored Jujutsu High high-collar gakuran uniform, pitch-black blindfold visor, and styled snow-white spiked wig.',
      buyPrice: 5200,
      rentPricePerDay: 750,
      securityDeposit: 1400,
      sellerName: 'Kenji Kamado Crafts',
      sellerHandle: '@kenji_props',
      sellerLocation: 'Pasig City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF1E3A8A), Color(0xFF60A5FA)],
      motifIcon: Icons.remove_red_eye_outlined,
      heroImageUrl: 'assets/images/gojo_satoru.jpg',
      galleryImageUrls: [
        'assets/images/gojo_satoru.jpg',
        'assets/images/gojo_void.jpg',
      ],
      inclusions: [
        'Tailored High-Collar Dark Navy Jujutsu High Jacket',
        'Matching Straight-Leg Navy Slacks & Leather Belt',
        'Light-Blocking Matte Black Elastic Blindfold',
        'Alternative Retro Round Dark Tint Sunglasses',
        'Snow-White Spiked Heat-Resistant Gojo Wig',
      ],
      rating: 5.0,
      reviewsCount: 389,
      isFeatured: true,
    ),
    CostumeItem(
      id: 'prod-23',
      title: 'Acheron Galaxy Ranger Emanator Rogue Set',
      category: 'Anime',
      characterName: 'Acheron',
      series: 'Honkai: Star Rail',
      subtitle:
          'Tactical asymmetrical rogue battle coat, Nihility crimson shoulder pauldron, thigh holster, and con-safe 5-foot Weeping Blade odachi.',
      buyPrice: 7400,
      rentPricePerDay: 1050,
      securityDeposit: 2100,
      sellerName: 'Lady Fontaine Studio',
      sellerHandle: '@furina_ph',
      sellerLocation: 'Pasay City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF581C87), Color(0xFFBE123C)],
      motifIcon: Icons.dark_mode_outlined,
      heroImageUrl: 'assets/images/acheron.jpg',
      galleryImageUrls: [
        'assets/images/acheron.jpg',
        'assets/images/acheron_blade.jpg',
      ],
      inclusions: [
        'Asymmetrical Dark Purple Rogue Longcoat & Halter',
        'Red Nihility Samurai Shoulder Guard & Gauntlet',
        'Tactical Thigh Holsters & Leather Combat Belt',
        'Two-Tone Purple/Crimson Ombre Long Wig',
        'Con-Safe 5-Foot Weeping Blade Odachi & Sheath Prop',
      ],
      rating: 4.9,
      reviewsCount: 154,
    ),
    CostumeItem(
      id: 'prod-24',
      title: 'Makima Public Safety Devil Hunter Trench Suit',
      category: 'Anime',
      characterName: 'Makima',
      series: 'Chainsaw Man',
      subtitle:
          'Crisp white collared dress shirt, slim black tie, tailored formal trousers, long black devil hunter trench coat, and braided rose wig.',
      buyPrice: 4100,
      rentPricePerDay: 580,
      securityDeposit: 1100,
      sellerName: 'Sailor Amai',
      sellerHandle: '@amai_guardian',
      sellerLocation: 'Quezon City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF991B1B), Color(0xFF1F2937)],
      motifIcon: Icons.pets,
      heroImageUrl: 'assets/images/makima.jpg',
      galleryImageUrls: [
        'assets/images/makima.jpg',
        'assets/images/makima_suit.jpg',
      ],
      inclusions: [
        'Heavy Black Public Safety Wool-Blend Long Trench Coat',
        'Crisp White Tailored Long-Sleeve Button-Up Shirt',
        'Black Silk Necktie & High-Waist Formal Slacks',
        'Signature Braided Dusty Rose Heat-Resistant Wig',
        'Special FX Ring-Pattern Yellow Contact Decals (Non-prescription)',
      ],
      rating: 4.8,
      reviewsCount: 182,
    ),
    CostumeItem(
      id: 'prod-25',
      title: 'Marin Kitagawa Shizuku Kuroe Gothic Lolita Dress',
      category: 'Anime',
      characterName: 'Marin Kitagawa (Shizuku Kuroe)',
      series: 'My Dress-Up Darling',
      subtitle:
          'Tiered black & purple lace Victorian gothic maid dress, frilled apron, lace choker, wing headpiece, and styled purple hime-cut wig.',
      buyPrice: 4900,
      rentPricePerDay: 700,
      securityDeposit: 1350,
      sellerName: 'Miyu Idol Wardrobe',
      sellerHandle: '@miyu_idols',
      sellerLocation: 'Mandaluyong, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF3B0764), Color(0xFF7E22CE)],
      motifIcon: Icons.auto_awesome_mosaic,
      heroImageUrl: 'assets/images/marin_kuroe.jpg',
      galleryImageUrls: [
        'assets/images/marin_kuroe.jpg',
        'assets/images/marin_kuroe_dress.jpg',
      ],
      inclusions: [
        'Tiered Ruffle Black Velvet & Purple Lace Victorian Gown',
        'Detachable Scalloped White Maid Apron & Choker',
        'Lace-Trimmed Batwing Headband & Hair Bows',
        'Styled Dark Violet Hime-Cut Long Wig',
        'Frilled Black Wrist Cuffs & Over-Knee Stockings',
      ],
      rating: 4.9,
      reviewsCount: 204,
    ),
    CostumeItem(
      id: 'prod-26',
      title: 'Miles Morales Spider-Verse Stealth Hoodie Suit',
      category: 'Movies',
      characterName: 'Miles Morales (Spider-Man)',
      series: 'Spider-Man: Into the Spider-Verse',
      subtitle:
          'Sublimated black & red spray-painted Spider-Man spandex suit, signature green hoodie, khaki utility shorts, and sneaker boot covers.',
      buyPrice: 4500,
      rentPricePerDay: 640,
      securityDeposit: 1200,
      sellerName: 'Kusarine & Hyou',
      sellerHandle: '@nightcity_edgerunners',
      sellerLocation: 'Makati City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFDC2626), Color(0xFF0F172A)],
      motifIcon: Icons.flash_on,
      heroImageUrl: 'assets/images/miles_morales.jpg',
      galleryImageUrls: [
        'assets/images/miles_morales.jpg',
        'assets/images/miles_spider_pose.jpg',
      ],
      inclusions: [
        'Sublimated 4-Way Stretch Black & Crimson Spider Suit',
        'Screen-Accurate Forest Green Oversized Zip Hoodie',
        'Khaki Utility Shorts with Adjustable Drawstrings',
        'Breathable Mesh Mask with 3D Hard Shell Eye Lenses',
        'Retro High-Top Red & White Sneaker Covers',
      ],
      rating: 4.9,
      reviewsCount: 178,
    ),
    CostumeItem(
      id: 'prod-27',
      title: 'Geralt of Rivia Grandmaster Wolven Armor',
      category: 'Movies',
      characterName: 'Geralt of Rivia',
      series: 'The Witcher',
      subtitle:
          'Weathered leatherette studded Wolven armor cuirass, chainmail underlay, silver Witcher wolf medallion, and dual steel/silver swords.',
      buyPrice: 8200,
      rentPricePerDay: 1180,
      securityDeposit: 2300,
      sellerName: 'IronForge PH',
      sellerHandle: '@ironforge_cos',
      sellerLocation: 'Davao City',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF422006), Color(0xFF713F12)],
      motifIcon: Icons.security,
      heroImageUrl: 'assets/images/geralt_witcher.jpg',
      galleryImageUrls: [
        'assets/images/geralt_witcher.jpg',
        'assets/images/geralt_swords.jpg',
      ],
      inclusions: [
        'Studded Leatherette Cuirass with Red Gusset Accents',
        'Faux Chainmail Undershirt & Reinforced Bracers',
        'Cast Metal Witcher Wolf School Medallion & Chain',
        'Shoulder Scabbard Dual Rig for Twin Swords',
        'Con-Safe Silver & Steel Monster Hunter Swords (Pair)',
      ],
      rating: 4.9,
      reviewsCount: 146,
    ),
    CostumeItem(
      id: 'prod-28',
      title: 'Harley Quinn Birds of Prey Caution Tape Suit',
      category: 'Comics',
      characterName: 'Harley Quinn',
      series: 'DC Comics / Birds of Prey',
      subtitle:
          'Translucent jacket with fringed caution tape sleeves, hot pink crop top, distressed denim shorts, and Good Night baseball bat.',
      buyPrice: 4600,
      rentPricePerDay: 650,
      securityDeposit: 1250,
      sellerName: 'Sailor Amai',
      sellerHandle: '@amai_guardian',
      sellerLocation: 'Quezon City, Metro Manila',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFFDB2777), Color(0xFFFACC15)],
      motifIcon: Icons.celebration,
      heroImageUrl: 'assets/images/harley_quinn.jpg',
      galleryImageUrls: [
        'assets/images/harley_quinn.jpg',
        'assets/images/harley_bat.jpg',
      ],
      inclusions: [
        'Clear Vinyl Jacket with Multi-Color Tinsel Fringe Sleeves',
        'Hot Pink Velvet Bra Top & High-Rise Cutoff Shorts',
        'Yellow Clip-On Suspenders & Layered Tattoo Decal Sheet',
        'Dual-Tone Pink & Blue Dipped Pigtail Wig',
        'Con-Safe Inscribed Wood-Finish Foam Baseball Bat Prop',
      ],
      rating: 4.8,
      reviewsCount: 133,
    ),
    CostumeItem(
      id: 'prod-29',
      title: 'Deadpool Merc with a Mouth Tactical Suit',
      category: 'Comics',
      characterName: 'Deadpool',
      series: 'Marvel Comics',
      subtitle:
          'Full-body textured red & black mercenary tactical suit, gun holsters, magazine pouches, back katana scabbards, and twin swords.',
      buyPrice: 5900,
      rentPricePerDay: 840,
      securityDeposit: 1600,
      sellerName: 'Mando Armory PH',
      sellerHandle: '@thisistheway_ph',
      sellerLocation: 'Cebu City',
      isUserListed: true,
      listingMode: ListingMode.both,
      gradientColors: [Color(0xFF991B1B), Color(0xFF18181B)],
      motifIcon: Icons.sentiment_very_satisfied,
      heroImageUrl: 'assets/images/deadpool.jpg',
      galleryImageUrls: [
        'assets/images/deadpool.jpg',
        'assets/images/deadpool_katanas.jpg',
      ],
      inclusions: [
        'Weathered Textured Spandex & Faux-Leather Full Body Suit',
        'Hard-Shell Mask with Expressive Mesh White Eyes',
        'Multi-Pouch Tactical Webbing Belt with Deadpool Buckle',
        'Leg Holsters & Shin Armor Guards',
        'Con-Safe Twin Katana Prop Swords & Back Sheath Rig',
      ],
      rating: 5.0,
      reviewsCount: 260,
    ),
  ];

  Set<String> wishlistIds = {'prod-1'};

  final List<CartLineItem> cart = [
    CartLineItem(
      id: 'line-init-1',
      costume: const CostumeItem(
        id: 'hero-1',
        title: 'Cartethyia Cosplay Set',
        category: 'Anime',
        characterName: 'Cartethyia (Fleurdelys)',
        series: 'Wuthering Waves',
        subtitle:
            'Ethereal white and sea-blue layered gown, styled long silver wig with side braids, and crystal thorn halo headpiece.',
        buyPrice: 5400,
        rentPricePerDay: 740,
        securityDeposit: 1200,
        sellerName: 'Cristian Ordoñez',
        sellerHandle: '@cristian_cos',
        sellerLocation: 'Calamba, Laguna',
        isUserListed: true,
        listingMode: ListingMode.both,
        gradientColors: [Color(0xFF18202C), Color(0xFF324B6B)],
        motifIcon: Icons.auto_awesome_outlined,
        heroImageUrl: 'assets/images/cartethyia.jpg',
        galleryImageUrls: [
          'assets/images/cartethyia.jpg',
          'assets/images/cartethyia_stage.jpg',
        ],
        inclusions: [
          'Ethereal White & Sea-Blue Layered Draped Gown',
          'Heat-Resistant Long Silver Wig with Braids',
          'Crystal Thorn Halo Crown Headpiece',
        ],
      ),
      mode: OrderMode.rent,
      size: 'M',
      rentalDays: 3,
      rentalStartDate: DateTime(2026, 11, 2),
    ),
  ];

  final List<AppAlert> alerts = [
    AppAlert(
      id: 'al-1',
      title: 'eKYC Verification Pending for Rentals',
      body:
          'Complete your 60-second ID + Selfie verification to unlock instant costume rentals with lower deposits.',
      timestamp: 'Just now',
      icon: Icons.verified_user_outlined,
      accentColor: CosColors.accentAmber,
    ),
    AppAlert(
      id: 'al-2',
      title: 'Cosplay Mania Weekend Promo!',
      body:
          'Get 15% off 3-day rentals on all Anime and Games sets using code COSHUB26 at checkout.',
      timestamp: '2 hours ago',
      icon: Icons.local_offer_outlined,
      accentColor: const Color(0xFFEC4899),
    ),
    AppAlert(
      id: 'al-3',
      title: 'Price Drop on Super Sailor Moon Sailor Fuku Set',
      body: 'An item in your wishlist is now available to rent for ₱380/day.',
      timestamp: 'Yesterday',
      icon: Icons.favorite_border,
      accentColor: const Color(0xFFA855F7),
      isUnread: false,
    ),
  ];

  CosHubStore() {
    _initPersistence();
  }

  Future<void> _initPersistence() async {
    final loadedWishlist = await CosHubStorage.loadWishlist();
    if (loadedWishlist != null) {
      wishlistIds = loadedWishlist;
    }
    final loadedCart = await CosHubStorage.loadCart();
    if (loadedCart != null) {
      cart
        ..clear()
        ..addAll(loadedCart);
    }
    final loadedCat = await CosHubStorage.loadCategory();
    if (loadedCat != null && categories.contains(loadedCat)) {
      selectedCategory = loadedCat;
    }
    final loadedMode = await CosHubStorage.loadModeFilter();
    if (loadedMode != null && modeFilters.contains(loadedMode)) {
      selectedModeFilter = loadedMode;
    }
    final paymentSettings = await CosHubStorage.loadPaymentSettings();
    selectedPaymentMethod = paymentSettings['method'] ?? 'GCash';
    userGcashNumber = paymentSettings['gcash'] ?? '0956 123 3881';
    userMayaNumber = paymentSettings['maya'] ?? '0918 888 4567';
    userCardLast4 = paymentSettings['card'] ?? '4821';
    notifyListeners();
  }

  void updatePaymentSetup({
    required String method,
    required String gcash,
    required String maya,
    required String card,
  }) {
    selectedPaymentMethod = method;
    userGcashNumber = gcash;
    userMayaNumber = maya;
    userCardLast4 = card;
    CosHubStorage.savePaymentSettings(
      method: method,
      gcash: gcash,
      maya: maya,
      card: card,
    );
    notifyListeners();
  }

  List<CostumeItem> get featuredCostumes =>
      catalog.where((item) => item.isFeatured).toList();

  List<CostumeItem> get gridCostumes {
    return catalog.where((item) {
      if (searchQuery.isEmpty &&
          selectedCategory == 'All' &&
          selectedModeFilter == 'All' &&
          item.id == 'hero-1') {
        return false;
      }

      final matchesCategory =
          selectedCategory == 'All' || item.category == selectedCategory;

      bool matchesMode = true;
      if (selectedModeFilter == 'For Rent') {
        matchesMode = item.canRent;
      } else if (selectedModeFilter == 'For Sale') {
        matchesMode = item.canBuy;
      }

      final query = searchQuery.toLowerCase();
      final matchesSearch = searchQuery.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query) ||
          (item.characterName != null &&
              item.characterName!.toLowerCase().contains(query)) ||
          (item.series != null &&
              item.series!.toLowerCase().contains(query)) ||
          item.sellerName.toLowerCase().contains(query);

      return matchesCategory && matchesMode && matchesSearch;
    }).toList();
  }

  List<CostumeItem> get wishlistedCostumes =>
      catalog.where((c) => wishlistIds.contains(c.id)).toList();

  bool get cartHasRentalItems =>
      cart.any((item) => item.mode == OrderMode.rent);

  int get cartSubtotal => cart.fold(0, (sum, item) => sum + item.itemSubtotal);

  int get cartSecurityDeposit =>
      cart.fold(0, (sum, item) => sum + item.totalDeposit);

  int get shippingFee => cart.isEmpty ? 0 : 120;

  int get cartGrandTotal => cartSubtotal + cartSecurityDeposit + shippingFee;

  int get unreadAlertsCount => alerts.where((a) => a.isUnread).length;

  void setTab(int index) {
    activeBottomTab = index;
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    CosHubStorage.saveCategory(category);
    notifyListeners();
  }

  void setModeFilter(String filter) {
    selectedModeFilter = filter;
    CosHubStorage.saveModeFilter(filter);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void nextHeroSlide() {
    heroCarouselIndex = (heroCarouselIndex + 1) % featuredCostumes.length;
    notifyListeners();
  }

  void prevHeroSlide() {
    heroCarouselIndex =
        (heroCarouselIndex - 1 + featuredCostumes.length) %
            featuredCostumes.length;
    notifyListeners();
  }

  void toggleWishlist(String costumeId) {
    if (wishlistIds.contains(costumeId)) {
      wishlistIds.remove(costumeId);
    } else {
      wishlistIds.add(costumeId);
    }
    CosHubStorage.saveWishlist(wishlistIds);
    notifyListeners();
  }

  void addToCart({
    required CostumeItem costume,
    required OrderMode mode,
    String size = 'M',
    int rentalDays = 3,
  }) {
    OrderMode effectiveMode = mode;
    if (costume.listingMode == ListingMode.rentOnly) {
      effectiveMode = OrderMode.rent;
    } else if (costume.listingMode == ListingMode.buyOnly) {
      effectiveMode = OrderMode.buy;
    }

    final existingIndex = cart.indexWhere(
      (item) =>
          item.costume.id == costume.id &&
          item.mode == effectiveMode &&
          item.size == size,
    );

    if (existingIndex >= 0) {
      cart[existingIndex].quantity += 1;
    } else {
      cart.add(
        CartLineItem(
          id: 'line-${DateTime.now().millisecondsSinceEpoch}',
          costume: costume,
          mode: effectiveMode,
          size: size,
          rentalDays: rentalDays,
          rentalStartDate: DateTime.now().add(const Duration(days: 2)),
        ),
      );
    }
    CosHubStorage.saveCart(cart);
    notifyListeners();
  }

  void updateCartQuantity(String lineId, int delta) {
    final idx = cart.indexWhere((e) => e.id == lineId);
    if (idx == -1) return;
    cart[idx].quantity += delta;
    if (cart[idx].quantity <= 0) {
      cart.removeAt(idx);
    }
    CosHubStorage.saveCart(cart);
    notifyListeners();
  }

  void updateRentalDays(String lineId, int days) {
    final idx = cart.indexWhere((e) => e.id == lineId);
    if (idx == -1) return;
    cart[idx].rentalDays = days.clamp(1, 14);
    CosHubStorage.saveCart(cart);
    notifyListeners();
  }

  void completeEkyc(String idType) {
    isEkycVerified = true;
    verifiedIdType = idType;
    alerts.insert(
      0,
      AppAlert(
        id: 'al-ekyc-${DateTime.now().millisecondsSinceEpoch}',
        title: 'eKYC Verification Approved!',
        body:
            'Your $idType and liveness selfie have been verified. You now have full access to COS HUB Costume Rentals.',
        timestamp: 'Just now',
        icon: Icons.verified,
        accentColor: CosColors.verifiedGreen,
      ),
    );
    notifyListeners();
  }

  void completeOrder(String paymentMethod, int amountPaid) {
    final itemCount = cart.length;
    cart.clear();
    CosHubStorage.saveCart(cart);
    alerts.insert(
      0,
      AppAlert(
        id: 'al-ord-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Order Confirmed via $paymentMethod',
        body:
            'Paid ${formatPeso(amountPaid)} for $itemCount costume item(s). Courier dispatch details sent to $userEmail.',
        timestamp: 'Just now',
        icon: Icons.local_shipping_outlined,
        accentColor: CosColors.verifiedGreen,
      ),
    );
    notifyListeners();
  }

  void markAllAlertsRead() {
    for (final alert in alerts) {
      alert.isUnread = false;
    }
    notifyListeners();
  }

  void login(String email, String name) {
    isAuthenticated = true;
    userEmail = email;
    userName = name;
    notifyListeners();
  }
}
