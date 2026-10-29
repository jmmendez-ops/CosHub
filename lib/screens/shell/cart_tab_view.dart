import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/costume_item.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/round_icon_btn.dart';
import '../commerce/checkout_screen.dart';
import '../commerce/ekyc_verification_screen.dart';

class CartTabView extends StatelessWidget {
  final CosHubStore store;
  const CartTabView({super.key, required this.store});

  void _handleProceedToCheckout(BuildContext context) {
    if (store.cartHasRentalItems && !store.isEkycVerified) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EkycVerificationScreen(
            store: store,
            onVerifiedSuccess: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(store: store),
                ),
              );
            },
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CheckoutScreen(store: store),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (store.cart.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: CosColors.textSecondary,
              ),
              const SizedBox(height: 14),
              const Text(
                'Your Costume Cart is Empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Browse Anime, Games, Movies, and Comics costumes to buy or rent for your next event.',
                textAlign: TextAlign.center,
                style: TextStyle(color: CosColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CosColors.accentAmber,
                  foregroundColor: CosColors.bgPrimary,
                ),
                onPressed: () => store.setTab(0),
                child: const Text(
                  'Browse Costumes',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Cart (Buy & Rent)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: CosColors.bgInput,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${store.cart.length} item(s)',
                  style: const TextStyle(
                    color: CosColors.accentAmber,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (store.cartHasRentalItems)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: store.isEkycVerified
                    ? CosColors.verifiedGreen.withValues(alpha: 0.12)
                    : CosColors.accentAmber.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: store.isEkycVerified
                      ? CosColors.verifiedGreen
                      : CosColors.accentAmber,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    store.isEkycVerified
                        ? Icons.verified_user
                        : Icons.badge_outlined,
                    color: store.isEkycVerified
                        ? CosColors.verifiedGreen
                        : CosColors.accentAmber,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      store.isEkycVerified
                          ? 'eKYC Verified (${store.verifiedIdType}): Rental items unlocked for instant checkout.'
                          : 'Cart contains Rental costume(s). Tapping Checkout will guide you through quick eKYC verification.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: CosColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: store.cart.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final line = store.cart[index];
              final isRent = line.mode == OrderMode.rent;
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CosColors.bgElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: CosColors.borderSubtle),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: line.costume.gradientColors,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: line.costume.heroImageUrl != null &&
                                  line.costume.heroImageUrl!.isNotEmpty
                              ? (line.costume.heroImageUrl!.startsWith('assets/')
                                  ? Image.asset(
                                      line.costume.heroImageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Icon(
                                        line.costume.motifIcon,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                  : Image.network(
                                      line.costume.heroImageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Icon(
                                        line.costume.motifIcon,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ))
                              : Icon(
                                  line.costume.motifIcon,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isRent
                                          ? CosColors.accentAmber
                                          : const Color(0xFF38BDF8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      isRent ? 'RENTAL' : 'BUY',
                                      style: const TextStyle(
                                        color: CosColors.bgPrimary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Size ${line.size}',
                                    style: const TextStyle(
                                      color: CosColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                line.costume.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Lister: ${line.costume.sellerHandle} • ${line.costume.sellerLocation}',
                                style: const TextStyle(
                                  color: CosColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isRent
                                    ? '${formatPeso(line.costume.rentPricePerDay)}/day × ${line.rentalDays} days (+${formatPeso(line.totalDeposit)} deposit)'
                                    : '${formatPeso(line.costume.buyPrice)} outright purchase',
                                style: const TextStyle(
                                  color: CosColors.accentAmber,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            RoundIconBtn(
                              icon: Icons.remove,
                              onTap: () =>
                                  store.updateCartQuantity(line.id, -1),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '${line.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            RoundIconBtn(
                              icon: Icons.add,
                              onTap: () =>
                                  store.updateCartQuantity(line.id, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isRent) ...[
                      const Divider(color: CosColors.borderSubtle, height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Adjust Rental Days:',
                            style: TextStyle(
                              color: CosColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [1, 3, 5, 7].map((d) {
                              final selected = line.rentalDays == d;
                              return Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: GestureDetector(
                                  onTap: () =>
                                      store.updateRentalDays(line.id, d),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? CosColors.accentAmber
                                          : CosColors.bgInput,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${d}d',
                                      style: TextStyle(
                                        color: selected
                                            ? CosColors.bgPrimary
                                            : CosColors.textSecondary,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: CosColors.bgElevated,
            border: Border(top: BorderSide(color: CosColors.borderSubtle)),
          ),
          child: Column(
            children: [
              _SummaryRow(
                label: 'Costume Subtotal',
                value: formatPeso(store.cartSubtotal),
              ),
              if (store.cartSecurityDeposit > 0)
                _SummaryRow(
                  label: 'Refundable Rental Security Deposit',
                  value: formatPeso(store.cartSecurityDeposit),
                  highlight: true,
                ),
              _SummaryRow(
                label: 'Insured Two-Way Courier (Laguna/Metro Manila)',
                value: formatPeso(store.shippingFee),
              ),
              const Divider(color: CosColors.borderSubtle, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Payable',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    formatPeso(store.cartGrandTotal),
                    style: const TextStyle(
                      color: CosColors.accentAmber,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosColors.accentAmber,
                    foregroundColor: CosColors.bgPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () => _handleProceedToCheckout(context),
                  child: Text(
                    store.cartHasRentalItems && !store.isEkycVerified
                        ? 'Verify eKYC & Proceed to Checkout →'
                        : 'Proceed to Checkout →',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color:
                  highlight ? CosColors.accentAmber : CosColors.textSecondary,
              fontSize: 12.5,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: highlight ? CosColors.accentAmber : CosColors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
