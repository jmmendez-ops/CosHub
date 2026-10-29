import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';
import '../core/utils/currency_formatter.dart';
import '../models/costume_item.dart';

class HeroBannerCard extends StatelessWidget {
  final CostumeItem costume;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onViewCostume;

  const HeroBannerCard({
    super.key,
    required this.costume,
    required this.onPrev,
    required this.onNext,
    required this.onViewCostume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: costume.gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (costume.heroImageUrl != null &&
              costume.heroImageUrl!.isNotEmpty)
            Positioned(
              right: -10,
              top: 0,
              bottom: 0,
              width: 230,
              child: costume.heroImageUrl!.startsWith('assets/')
                  ? Image.asset(
                      costume.heroImageUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) => Icon(
                        costume.motifIcon,
                        size: 90,
                        color: Colors.white24,
                      ),
                    )
                  : Image.network(
                      costume.heroImageUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) => Icon(
                        costume.motifIcon,
                        size: 90,
                        color: Colors.white24,
                      ),
                    ),
            )

          else
            Positioned(
              right: 20,
              top: 30,
              child: Icon(
                costume.motifIcon,
                size: 110,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF14161D),
                  const Color(0xFF14161D).withValues(alpha: 0.88),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 18, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: CosColors.accentAmber,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        costume.category,
                        style: const TextStyle(
                          color: CosColors.bgPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: CosColors.accentAmber.withValues(alpha: 0.6),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person_pin_circle_outlined,
                            size: 11,
                            color: CosColors.accentAmber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            costume.sellerHandle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 215),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        costume.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CosColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        costume.subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFD0D5DD),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CosColors.accentAmber,
                        foregroundColor: CosColors.bgPrimary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        minimumSize: const Size(0, 38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      onPressed: onViewCostume,
                      child: const Text(
                        'View costume',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Rent ${formatPeso(costume.rentPricePerDay)}/day',
                      style: const TextStyle(
                        color: CosColors.textPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: onPrev,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14161D).withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CosColors.accentAmber,
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: CosColors.textPrimary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: onNext,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14161D).withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: CosColors.textPrimary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
