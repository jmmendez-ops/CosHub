import 'package:flutter/material.dart';

enum OrderMode { buy, rent }

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
    required this.inclusions,
    this.rating = 4.9,
    this.reviewsCount = 84,
    this.isFeatured = false,
    this.characterName,
    this.series,
    this.sellerName = 'Cristian Ordoñez',
    this.sellerHandle = '@cristian_cos',
    this.sellerLocation = 'Calamba, Laguna',
    this.isUserListed = true,
    this.canRent = true,
    this.canBuy = true,
  });
}
