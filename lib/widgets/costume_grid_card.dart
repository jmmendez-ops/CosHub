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
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        decoration: BoxDecoration(
          color: CosColors.bgCardFooter,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2B2E36)),
        ),
        clipBehavior: Clip.antiAlias,
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
                      Image.network(
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
                      child: Container(
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
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: onToggleWishlist,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            shape: BoxShape.circle,
                          ),
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
                        const SizedBox(height: 2),
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
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
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
    );
  }
}
