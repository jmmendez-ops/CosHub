import 'package:flutter/material.dart';

enum OrderMode { buy, rent }

enum ListingMode { both, rentOnly, buyOnly }

class CostumeItem {
  final String id;
  final String title;
  final String category;
  final String subtitle;
  final int buyPrice;
  final int rentPricePerDay;
  final int securityDeposit;
  final List<Color> gradientColors;
  final IconData motifIcon;
  final String? heroImageUrl;
  final List<String> galleryImageUrls;
  final List<String> inclusions;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;

  // Real cosplayer & character metadata
  final String? characterName;
  final String? series;
  final String sellerName;
  final String sellerHandle;
  final String sellerLocation;
  final bool isUserListed;
  final ListingMode listingMode;
  final bool canRent;
  final bool canBuy;

  const CostumeItem({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.buyPrice,
    required this.rentPricePerDay,
    required this.securityDeposit,
    required this.gradientColors,
    required this.motifIcon,
    this.heroImageUrl,
    this.galleryImageUrls = const [],
    required this.inclusions,
    this.rating = 4.9,
    this.reviewsCount = 84,
    this.isFeatured = false,
    this.characterName,
    this.series,
    this.sellerName = 'COS HUB Official Store',
    this.sellerHandle = '@coshub_official',
    this.sellerLocation = 'Metro Manila, PH',
    this.isUserListed = false,
    this.listingMode = ListingMode.both,
    bool? canRent,
    bool? canBuy,
  })  : canRent = canRent ?? (listingMode != ListingMode.buyOnly),
        canBuy = canBuy ?? (listingMode != ListingMode.rentOnly);

  List<String> get carouselImages {
    if (galleryImageUrls.isNotEmpty) return galleryImageUrls;
    if (heroImageUrl != null && heroImageUrl!.isNotEmpty) return [heroImageUrl!];
    return const [];
  }

  String get makerBadgeLabel {
    final lower = sellerName.toLowerCase();
    if (lower.contains('forge') ||
        lower.contains('armory') ||
        lower.contains('craft') ||
        lower.contains('studio')) {
      return 'ARTISAN ATELIER';
    }
    if (isUserListed) {
      return 'COMMUNITY LENDER';
    }
    return 'COMMUNITY WARDROBE';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'subtitle': subtitle,
      'buyPrice': buyPrice,
      'rentPricePerDay': rentPricePerDay,
      'securityDeposit': securityDeposit,
      'heroImageUrl': heroImageUrl,
      'galleryImageUrls': galleryImageUrls,
      'inclusions': inclusions,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isFeatured': isFeatured,
      'characterName': characterName,
      'series': series,
      'sellerName': sellerName,
      'sellerHandle': sellerHandle,
      'sellerLocation': sellerLocation,
      'isUserListed': isUserListed,
      'listingMode': listingMode.name,
    };
  }

  factory CostumeItem.fromJson(Map<String, dynamic> json) {
    ListingMode mode = ListingMode.both;
    if (json['listingMode'] == 'rentOnly') {
      mode = ListingMode.rentOnly;
    } else if (json['listingMode'] == 'buyOnly') {
      mode = ListingMode.buyOnly;
    }

    return CostumeItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      subtitle: json['subtitle'] as String,
      buyPrice: json['buyPrice'] as int,
      rentPricePerDay: json['rentPricePerDay'] as int,
      securityDeposit: json['securityDeposit'] as int,
      gradientColors: const [Color(0xFF18202C), Color(0xFF324B6B)],
      motifIcon: Icons.auto_awesome_outlined,
      heroImageUrl: json['heroImageUrl'] as String?,
      galleryImageUrls: (json['galleryImageUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      inclusions: (json['inclusions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      reviewsCount: json['reviewsCount'] as int? ?? 84,
      isFeatured: json['isFeatured'] as bool? ?? false,
      characterName: json['characterName'] as String?,
      series: json['series'] as String?,
      sellerName: json['sellerName'] as String? ?? 'COS HUB Official Store',
      sellerHandle: json['sellerHandle'] as String? ?? '@coshub_official',
      sellerLocation: json['sellerLocation'] as String? ?? 'Metro Manila, PH',
      isUserListed: json['isUserListed'] as bool? ?? false,
      listingMode: mode,
    );
  }
}
