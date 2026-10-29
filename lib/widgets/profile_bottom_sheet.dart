import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';
import '../state/cos_hub_store.dart';
import '../screens/commerce/ekyc_verification_screen.dart';
import '../screens/onboarding/auth_screen.dart';
import 'setup_payment_modal.dart';

void showProfileModal(BuildContext context, CosHubStore store) {
  showModalBottomSheet(
    context: context,
    backgroundColor: CosColors.bgElevated,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: CosColors.accentAmber,
                  child: Text(
                    store.userName.substring(0, 1),
                    style: const TextStyle(
                      color: CosColors.bgPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        store.userEmail,
                        style: const TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: store.isEkycVerified
                        ? CosColors.verifiedGreen.withValues(alpha: 0.15)
                        : CosColors.accentAmber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    store.isEkycVerified ? 'eKYC Verified' : 'Unverified',
                    style: TextStyle(
                      color: store.isEkycVerified
                          ? CosColors.verifiedGreen
                          : CosColors.accentAmber,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (!store.isEkycVerified)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosColors.accentAmber,
                    foregroundColor: CosColors.bgPrimary,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EkycVerificationScreen(
                          store: store,
                          onVerifiedSuccess: () => Navigator.of(context).pop(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_user_outlined, size: 18),
                  label: const Text(
                    'Complete eKYC Rental Verification Now',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CosColors.bgInput,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: CosColors.borderSubtle),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  showSetupPaymentModal(context, store);
                },
                icon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 18,
                  color: CosColors.accentAmber,
                ),
                label: Text(
                  'Payment Setup (${store.selectedPaymentMethod})',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AuthScreen(store: store),
                    ),
                  );
                },
                child: const Text('Switch Account / Sign In'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
