import 'package:flutter/material.dart';
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

  String selectedCategory = 'All';
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

  final List<CostumeItem> catalog = const [
    CostumeItem(
      id: 'hero-1',
      title: 'Cartethyia Cosplay Set',
      category: 'Anime',
      characterName: 'Cartethyia (Fleurdelys)',
      series: 'Wuthering Waves',
      subtitle:
          'Ethereal white and sea-blue layered gown, styled long silver wig with braids, and crystal thorn halo headpiece.',
      buyPrice: 5400,
      rentPricePerDay: 740,
      securityDeposit: 1200,
      sellerName: 'Cristian Ordoñez',
      sellerHandle: '@cristian_cos',
      sellerLocation: 'Calamba, Laguna',
      isUserListed: true,
      gradientColors: [Color(0xFF18202C), Color(0xFF324B6B)],
      motifIcon: Icons.auto_awesome_outlined,
      heroImageUrl: 'assets/images/cartethyia.jpg',
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
      gradientColors: [Color(0xFF5A3386), Color(0xFFBE6498)],
      motifIcon: Icons.dark_mode_outlined,
      heroImageUrl: 'assets/images/sailor_moon.jpg',
      inclusions: [
        'Sailor Bodice with Gold Heart Brooch',
        'Pleated Navy & White Skirt with Crimson Back Bow',
        'Gold Metal Crescent Moon Tiara & Red Choker',
        'Elbow-Length White Satin Gloves with Padded Cuffs',
        'Red Knee-High Boot Covers',
      ],
      rating: 4.8,
      reviewsCount: 96,
      isFeatured: true,
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
      gradientColors: [Color(0xFF7B1818), Color(0xFFB32B2B)],
      motifIcon: Icons.colorize_outlined,
      heroImageUrl: 'assets/images/tanjiro.jpg',
      inclusions: [
        'Iconic Green & Black Checkered Haori Coat',
        'Demon Slayer Corps Black Gakuran Jacket & Hakama Pants',
        'White Leg Wraps (Kyahan) & White Belt',
        'Con-Safe Bamboo/Wood Core Nichirin Katana & Sheath',
        'Acrylic Hanafuda Earrings (Clip-on)',
      ],
      rating: 4.9,
      reviewsCount: 210,
      isFeatured: true,
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
      isFeatured: true,
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
      gradientColors: [Color(0xFF0E6868), Color(0xFF19A98B)],
      motifIcon: Icons.directions_bike_outlined,
      heroImageUrl: 'assets/images/david_martinez.jpg',
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
      category: 'Games',
      characterName: 'Furina (Archon of Fontaine)',
      series: 'Genshin Impact',
      subtitle:
          'Full stage-accurate Fontaine Archon Victorian frock coat, ruffled jabot, high-top hat, and styled dual-tone silver wig.',
      buyPrice: 5400,
      rentPricePerDay: 740,
      securityDeposit: 1200,
      sellerName: 'Cristian Ordoñez',
      sellerHandle: '@cristian_cos',
      sellerLocation: 'Calamba, Laguna',
      isUserListed: true,
      gradientColors: [Color(0xFF18202C), Color(0xFF324B6B)],
      motifIcon: Icons.auto_awesome_outlined,
      heroImageUrl: 'assets/images/furina.jpg',
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
  ];

  final Set<String> wishlistIds = {'prod-1'};

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
            'Ethereal white and sea-blue layered gown, styled long silver wig with braids, and crystal thorn halo headpiece.',
        buyPrice: 5400,
        rentPricePerDay: 740,
        securityDeposit: 1200,
        sellerName: 'Cristian Ordoñez',
        sellerHandle: '@cristian_cos',
        sellerLocation: 'Calamba, Laguna',
        isUserListed: true,
        gradientColors: [Color(0xFF18202C), Color(0xFF324B6B)],
        motifIcon: Icons.auto_awesome_outlined,
        heroImageUrl: 'assets/images/cartethyia.jpg',
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

  List<CostumeItem> get featuredCostumes =>
      catalog.where((item) => item.isFeatured).toList();

  List<CostumeItem> get gridCostumes {
    return catalog.where((item) {
      if (searchQuery.isEmpty &&
          selectedCategory == 'All' &&
          item.id == 'hero-1') {
        return false;
      }
      final matchesCategory =
          selectedCategory == 'All' || item.category == selectedCategory;
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
      return matchesCategory && matchesSearch;
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
    notifyListeners();
  }

  void addToCart({
    required CostumeItem costume,
    required OrderMode mode,
    String size = 'M',
    int rentalDays = 3,
  }) {
    final existingIndex = cart.indexWhere(
      (item) =>
          item.costume.id == costume.id &&
          item.mode == mode &&
          item.size == size,
    );

    if (existingIndex >= 0) {
      cart[existingIndex].quantity += 1;
    } else {
      cart.add(
        CartLineItem(
          id: 'line-${DateTime.now().millisecondsSinceEpoch}',
          costume: costume,
          mode: mode,
          size: size,
          rentalDays: rentalDays,
          rentalStartDate: DateTime.now().add(const Duration(days: 2)),
        ),
      );
    }
    notifyListeners();
  }

  void updateCartQuantity(String lineId, int delta) {
    final idx = cart.indexWhere((e) => e.id == lineId);
    if (idx == -1) return;
    cart[idx].quantity += delta;
    if (cart[idx].quantity <= 0) {
      cart.removeAt(idx);
    }
    notifyListeners();
  }

  void updateRentalDays(String lineId, int days) {
    final idx = cart.indexWhere((e) => e.id == lineId);
    if (idx == -1) return;
    cart[idx].rentalDays = days.clamp(1, 14);
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
