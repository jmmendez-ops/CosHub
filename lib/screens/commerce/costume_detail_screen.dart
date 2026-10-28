import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/costume_item.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/round_icon_btn.dart';

class CostumeDetailScreen extends StatefulWidget {
  final CosHubStore store;
  final CostumeItem costume;

  const CostumeDetailScreen({
    super.key,
    required this.store,
    required this.costume,
  });

  @override
  State<CostumeDetailScreen> createState() => _CostumeDetailScreenState();
}

class _CostumeDetailScreenState extends State<CostumeDetailScreen> {
  OrderMode _selectedMode = OrderMode.rent;
  String _selectedSize = 'M';
  int _rentalDays = 3;

  @override
  Widget build(BuildContext context) {
    final c = widget.costume;
    final isWishlisted = widget.store.wishlistIds.contains(c.id);
    final calculatedPrice = _selectedMode == OrderMode.buy
        ? c.buyPrice
        : (c.rentPricePerDay * _rentalDays);

    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: CosColors.bgPrimary,
        elevation: 0,
        title: Text(
          c.category,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.store.toggleWishlist(c.id);
              setState(() {});
            },
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? CosColors.accentAmber : Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: c.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (c.heroImageUrl != null)
                          Image.network(
                            c.heroImageUrl!,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (_, __, ___) => Center(
                              child: Icon(
                                c.motifIcon,
                                size: 80,
                                color: Colors.white70,
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Icon(
                              c.motifIcon,
                              size: 84,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        Positioned(
                          left: 14,
                          bottom: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: CosColors.accentAmber,
                                  size: 15,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${c.rating} (${c.reviewsCount} cosplayer reviews)',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (c.series != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        c.series!.toUpperCase(),
                        style: const TextStyle(
                          color: CosColors.accentAmber,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  Text(
                    c.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: CosColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.subtitle,
                    style: const TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CosColors.bgElevated,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: CosColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: CosColors.accentAmber.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: CosColors.accentAmber,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.person_pin,
                            color: CosColors.accentAmber,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      c.sellerName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: CosColors.textPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    color: CosColors.verifiedGreen,
                                    size: 14,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    c.sellerHandle,
                                    style: const TextStyle(
                                      color: CosColors.accentAmber,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 12,
                                    color: CosColors.textSecondary,
                                  ),
                                  Text(
                                    c.sellerLocation,
                                    style: const TextStyle(
                                      color: CosColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: CosColors.accentAmber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'COMMUNITY LISTING',
                            style: TextStyle(
                              color: CosColors.accentAmber,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SELECT ORDER MODE',
                    style: TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _ModeOptionCard(
                          title: 'RENT SET',
                          priceText: '${formatPeso(c.rentPricePerDay)}/day',
                          subtitle:
                              '+ ${formatPeso(c.securityDeposit)} refundable deposit',
                          isSelected: _selectedMode == OrderMode.rent,
                          onTap: () =>
                              setState(() => _selectedMode = OrderMode.rent),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ModeOptionCard(
                          title: 'BUY BRAND NEW',
                          priceText: formatPeso(c.buyPrice),
                          subtitle: 'Keep forever • No deposit',
                          isSelected: _selectedMode == OrderMode.buy,
                          onTap: () =>
                              setState(() => _selectedMode = OrderMode.buy),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_selectedMode == OrderMode.rent) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: CosColors.bgElevated,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: CosColors.borderSubtle),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rental Duration',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Includes free laundry & steaming',
                                    style: TextStyle(
                                      color: CosColors.textSecondary,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RoundIconBtn(
                                    icon: Icons.remove,
                                    onTap: () {
                                      if (_rentalDays > 1) {
                                        setState(() => _rentalDays--);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Text(
                                      '$_rentalDays Days',
                                      style: const TextStyle(
                                        color: CosColors.accentAmber,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  RoundIconBtn(
                                    icon: Icons.add,
                                    onTap: () {
                                      if (_rentalDays < 14) {
                                        setState(() => _rentalDays++);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: CosColors.borderSubtle,
                            height: 22,
                          ),
                          Row(
                            children: [
                              Icon(
                                widget.store.isEkycVerified
                                    ? Icons.verified
                                    : Icons.info_outline,
                                size: 16,
                                color: widget.store.isEkycVerified
                                    ? CosColors.verifiedGreen
                                    : CosColors.accentAmber,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.store.isEkycVerified
                                      ? 'Your eKYC Cosplayer Pass is verified! Ready for instant rental checkout.'
                                      : 'Option A Active: You can add rentals to cart now; eKYC ID check will be requested at Checkout.',
                                  style: const TextStyle(
                                    color: CosColors.textSecondary,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  const Text(
                    'SELECT COSTUME SIZE (ASIAN FIT)',
                    style: TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['S', 'M', 'L', 'XL'].map((size) {
                      final active = _selectedSize == size;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedSize = size),
                          child: Container(
                            width: 48,
                            height: 42,
                            decoration: BoxDecoration(
                              color: active
                                  ? CosColors.accentAmber
                                  : CosColors.bgInput,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: active
                                    ? CosColors.accentAmber
                                    : CosColors.borderSubtle,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: active
                                    ? CosColors.bgPrimary
                                    : CosColors.textPrimary,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'SET INCLUSIONS & PROPS',
                    style: TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...c.inclusions.map(
                    (inc) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: CosColors.accentAmber,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              inc,
                              style: const TextStyle(
                                color: CosColors.textPrimary,
                                fontSize: 13.5,
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
          Container(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
            decoration: const BoxDecoration(
              color: CosColors.bgElevated,
              border: Border(top: BorderSide(color: CosColors.borderSubtle)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedMode == OrderMode.rent
                            ? 'Rent ($_rentalDays days) + Deposit'
                            : 'Buy Brand New Price',
                        style: const TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _selectedMode == OrderMode.rent
                            ? formatPeso(calculatedPrice + c.securityDeposit)
                            : formatPeso(calculatedPrice),
                        style: const TextStyle(
                          color: CosColors.accentAmber,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosColors.accentAmber,
                    foregroundColor: CosColors.bgPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    widget.store.addToCart(
                      costume: c,
                      mode: _selectedMode,
                      size: _selectedSize,
                      rentalDays: _rentalDays,
                    );
                    Navigator.of(context).pop();
                    widget.store.setTab(1);
                  },
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: Text(
                    _selectedMode == OrderMode.rent
                        ? 'Add Rental to Cart'
                        : 'Add Purchase to Cart',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeOptionCard extends StatelessWidget {
  final String title;
  final String priceText;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeOptionCard({
    required this.title,
    required this.priceText,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? CosColors.accentAmber.withValues(alpha: 0.14)
              : CosColors.bgElevated,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? CosColors.accentAmber : CosColors.borderSubtle,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? CosColors.accentAmber
                        : CosColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: CosColors.accentAmber,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              priceText,
              style: const TextStyle(
                color: CosColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: CosColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
