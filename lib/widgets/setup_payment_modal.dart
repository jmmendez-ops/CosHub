import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';
import '../state/cos_hub_store.dart';

void showSetupPaymentModal(BuildContext context, CosHubStore store) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: CosColors.bgElevated,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return _SetupPaymentSheet(store: store);
    },
  );
}

class _SetupPaymentSheet extends StatefulWidget {
  final CosHubStore store;
  const _SetupPaymentSheet({required this.store});

  @override
  State<_SetupPaymentSheet> createState() => _SetupPaymentSheetState();
}

class _SetupPaymentSheetState extends State<_SetupPaymentSheet> {
  late String _activeMethod;
  late TextEditingController _gcashCtrl;
  late TextEditingController _mayaCtrl;
  late TextEditingController _cardCtrl;

  @override
  void initState() {
    super.initState();
    _activeMethod = widget.store.selectedPaymentMethod;
    _gcashCtrl = TextEditingController(text: widget.store.userGcashNumber);
    _mayaCtrl = TextEditingController(text: widget.store.userMayaNumber);
    _cardCtrl = TextEditingController(text: widget.store.userCardLast4);
  }

  @override
  void dispose() {
    _gcashCtrl.dispose();
    _mayaCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  void _save() {
    widget.store.updatePaymentSetup(
      method: _activeMethod,
      gcash: _gcashCtrl.text.trim(),
      maya: _mayaCtrl.text.trim(),
      card: _cardCtrl.text.trim(),
    );
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment preferences updated to $_activeMethod!'),
        backgroundColor: CosColors.verifiedGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(22, 20, 22, 22 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: CosColors.accentAmber,
                    size: 22,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Setup Payment Options',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, color: CosColors.textSecondary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Configure your default Philippine payment gateways for instant buy & rental checkout.',
            style: TextStyle(
              color: CosColors.textSecondary,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 18),
          _paymentOptionTile(
            title: 'GCash',
            subtitle: 'Instant Mobile Wallet',
            icon: Icons.account_balance_wallet_outlined,
            color: const Color(0xFF007DFE),
            methodKey: 'GCash',
            controller: _gcashCtrl,
            hint: 'e.g. 0956 123 3881',
          ),
          const SizedBox(height: 10),
          _paymentOptionTile(
            title: 'Maya',
            subtitle: 'Maya Wallet & QR Ph',
            icon: Icons.qr_code_scanner,
            color: const Color(0xFF10B981),
            methodKey: 'Maya',
            controller: _mayaCtrl,
            hint: 'e.g. 0918 888 4567',
          ),
          const SizedBox(height: 10),
          _paymentOptionTile(
            title: 'Visa / Mastercard',
            subtitle: 'Credit or Debit Card',
            icon: Icons.credit_card,
            color: const Color(0xFFF59E0B),
            methodKey: 'Visa / Mastercard',
            controller: _cardCtrl,
            hint: 'Last 4 digits (e.g. 4821)',
          ),
          const SizedBox(height: 10),
          _paymentOptionTile(
            title: 'Cash on Delivery (COD)',
            subtitle: 'Pay during courier drop-off or convention meetup',
            icon: Icons.local_shipping_outlined,
            color: const Color(0xFFA855F7),
            methodKey: 'Cash on Delivery',
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CosColors.accentAmber,
                foregroundColor: CosColors.bgPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _save,
              child: const Text(
                'Save Payment Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOptionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String methodKey,
    TextEditingController? controller,
    String? hint,
  }) {
    final isSelected = _activeMethod == methodKey;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? color.withValues(alpha: 0.12)
            : CosColors.bgInput,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? color : CosColors.borderSubtle,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => _activeMethod = methodKey),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                color: CosColors.textSecondary,
                fontSize: 11.5,
              ),
            ),
            trailing: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : CosColors.borderSubtle,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          if (isSelected && controller != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                controller: controller,
                style: const TextStyle(fontSize: 13, color: Colors.white),
                decoration: InputDecoration(
                  labelText: '$title Account Detail',
                  hintText: hint,
                  isDense: true,
                  filled: true,
                  fillColor: CosColors.bgElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color.withValues(alpha: 0.5)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
