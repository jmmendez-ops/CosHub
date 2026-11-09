import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';
import '../core/utils/currency_formatter.dart';
import '../models/costume_item.dart';

class CostumeGridCard extends StatelessWidget {
  final CostumeItem costume;
  final bool isWishlisted;
  final VoidCallback onToggleWishlist;
  final VoidCallback onTapCard;
  final VoidCallback onQuickAddToCart;

  const CostumeGridCard({
    super.key,
    required this.costume,
    required this.isWishlisted,
    required this.onToggleWishlist,
    required this.onTapCard,
    required this.onQuickAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CosColors.bgCardFooter,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2B2E36)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTapCard,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 48,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: costume.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (costume.heroImageUrl != null &&
                          costume.heroImageUrl!.isNotEmpty)
                        costume.heroImageUrl!.startsWith('assets/')
                            ? Image.asset(
                                costume.heroImageUrl!,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Icon(
                                    costume.motifIcon,
                                    size: 46,
                                    color: Colors.white.withValues(alpha: 0.92),
                                  ),
                                ),
                              )
                            : Image.network(
                                costume.heroImageUrl!,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Icon(
                                    costume.motifIcon,
                                    size: 46,
                                    color: Colors.white.withValues(alpha: 0.92),
                                  ),
                                ),
                              )
                      else
                        Center(
                          child: Icon(
                            costume.motifIcon,
                            size: 46,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: CosColors.accentAmber.withValues(alpha: 0.5),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    size: 11,
                                    color: CosColors.accentAmber,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    costume.sellerHandle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (costume.listingMode == ListingMode.rentOnly) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'RENT ONLY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ] else if (costume.listingMode == ListingMode.buyOnly) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0EA5E9).withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'BUY ONLY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (costume.carouselImages.length > 1)
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                                width: 0.7,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.photo_library_outlined,
                                  size: 10,
                                  color: CosColors.accentAmber,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${costume.carouselImages.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.black.withValues(alpha: 0.55),
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: onToggleWishlist,
                            customBorder: const CircleBorder(),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                isWishlisted
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16,
                                color: isWishlisted
                                    ? CosColors.accentAmber
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: 52,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (costume.series != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              costume.series!.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: CosColors.accentAmber,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        Text(
                          costume.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: CosColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (costume.canBuy)
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                color: CosColors.textSecondary,
                              ),
                              children: [
                                const TextSpan(text: 'Buy '),
                                TextSpan(
                                  text: formatPeso(costume.buyPrice),
                                  style: const TextStyle(
                                    color: CosColors.accentAmber,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (costume.canBuy && costume.canRent)
                          const SizedBox(height: 2),
                        if (costume.canRent)
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                color: CosColors.textSecondary,
                              ),
                              children: [
                                const TextSpan(text: 'Rent '),
                                TextSpan(
                                  text: formatPeso(costume.rentPricePerDay),
                                  style: const TextStyle(
                                    color: CosColors.accentAmber,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const TextSpan(text: '/day'),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 34,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CosColors.accentAmber,
                          foregroundColor: CosColors.bgPrimary,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        onPressed: onQuickAddToCart,
                        child: Text(
                          costume.listingMode == ListingMode.rentOnly
                              ? 'Rent now'
                              : costume.listingMode == ListingMode.buyOnly
                                  ? 'Buy now'
                                  : 'Add to cart',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
