import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/setup_payment_modal.dart';

class CheckoutScreen extends StatefulWidget {
  final CosHubStore store;
  const CheckoutScreen({super.key, required this.store});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late String _selectedPayment;
  bool _agreedToRentalTerms = true;
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    _selectedPayment = widget.store.selectedPaymentMethod;
  }

  List<Map<String, dynamic>> _getPaymentMethods() => [
    {
      'name': 'GCash',
      'subtitle': 'Instant e-Wallet • ${widget.store.userGcashNumber}',
      'icon': Icons.account_balance_wallet_outlined,
      'color': const Color(0xFF007DFE),
    },
    {
      'name': 'Maya',
      'subtitle': 'Maya Wallet / QR Ph • ${widget.store.userMayaNumber}',
      'icon': Icons.qr_code_scanner,
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Visa / Mastercard',
      'subtitle': 'Credit or Debit Card •••• ${widget.store.userCardLast4}',
      'icon': Icons.credit_card,
      'color': const Color(0xFFF59E0B),
    },
    {
      'name': 'Cash on Delivery',
      'subtitle': 'Pay courier upon delivery or meetup',
      'icon': Icons.local_shipping_outlined,
      'color': const Color(0xFFA855F7),
    },
  ];

  void _processMockPayment() async {
    final totalAmount = widget.store.cartGrandTotal;
    setState(() => _isProcessingPayment = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    widget.store.completeOrder(_selectedPayment, totalAmount);
    setState(() => _isProcessingPayment = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: CosColors.bgElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: CosColors.verifiedGreen, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Payment Successful!',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paid ${formatPeso(totalAmount)} via $_selectedPayment (Mock Gateway).',
              style: const TextStyle(color: CosColors.textPrimary),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CosColors.bgInput,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ref #: COS-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
                    style: const TextStyle(
                      color: CosColors.accentAmber,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Delivery to: ${widget.store.userLocation}',
                    style: const TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CosColors.accentAmber,
                foregroundColor: CosColors.bgPrimary,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
                widget.store.setTab(2);
              },
              child: const Text(
                'View Order in Alerts',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: CosColors.bgPrimary,
        title: const Text(
          'Checkout & Payment',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CosColors.bgElevated,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: CosColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: CosColors.accentAmber,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.store.userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Brgy. Bañadero, ${widget.store.userLocation}',
                                style: const TextStyle(
                                  color: CosColors.textSecondary,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.store.isEkycVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: CosColors.verifiedGreen.withValues(
                                alpha: 0.16,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'eKYC OK',
                              style: TextStyle(
                                color: CosColors.verifiedGreen,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SELECT PAYMENT METHOD',
                        style: TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showSetupPaymentModal(context, widget.store);
                          setState(() {});
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.tune, size: 14, color: CosColors.accentAmber),
                            SizedBox(width: 4),
                            Text(
                              'Setup Options',
                              style: TextStyle(
                                color: CosColors.accentAmber,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ..._getPaymentMethods().map((method) {
                    final selected = _selectedPayment == method['name'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => setState(
                          () => _selectedPayment = method['name'] as String,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: selected
                                ? CosColors.accentAmber.withValues(alpha: 0.12)
                                : CosColors.bgElevated,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? CosColors.accentAmber
                                  : CosColors.borderSubtle,
                              width: selected ? 1.6 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (method['color'] as Color).withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  method['icon'] as IconData,
                                  color: method['color'] as Color,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method['name'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      method['subtitle'] as String,
                                      style: const TextStyle(
                                        color: CosColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                selected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: selected
                                    ? CosColors.accentAmber
                                    : CosColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: CosColors.accentAmber,
                    checkColor: CosColors.bgPrimary,
                    value: _agreedToRentalTerms,
                    onChanged: (v) =>
                        setState(() => _agreedToRentalTerms = v ?? true),
                    title: const Text(
                      'I agree to the COS HUB Rental Return & Security Deposit Refund Guarantee (deposit auto-refunds within 24h of costume return pickup).',
                      style: TextStyle(
                        fontSize: 12,
                        color: CosColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: CosColors.bgElevated,
              border: Border(top: BorderSide(color: CosColors.borderSubtle)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CosColors.accentAmber,
                  foregroundColor: CosColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                onPressed: (_isProcessingPayment || !_agreedToRentalTerms)
                    ? null
                    : _processMockPayment,
                child: _isProcessingPayment
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: CosColors.bgPrimary,
                        ),
                      )
                    : Text(
                        'Pay ${formatPeso(widget.store.cartGrandTotal)} with $_selectedPayment',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
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
