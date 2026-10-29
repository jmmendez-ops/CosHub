import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/cos_bottom_nav_bar.dart';
import '../onboarding/splash_screen.dart';
import '../onboarding/landing_screen.dart';
import '../onboarding/auth_screen.dart';
import '../commerce/costume_detail_screen.dart';
import '../commerce/ekyc_verification_screen.dart';
import '../commerce/checkout_screen.dart';
import 'home_tab_view.dart';
import 'cart_tab_view.dart';
import 'alerts_tab_view.dart';
import 'wishlist_tab_view.dart';
import '../../widgets/profile_bottom_sheet.dart';

class MainShellScreen extends StatelessWidget {
  final CosHubStore store;
  const MainShellScreen({super.key, required this.store});

  void _openDevScreenJumper(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CosColors.bgElevated,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '⚡ Quick Screen Jumper (All 11 Views)',
                    style: TextStyle(
                      color: CosColors.accentAmber,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              const Divider(color: CosColors.borderSubtle),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _JumpChip(
                    label: '1. Animated Splash',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SplashScreen(store: store),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '2. Landing Page',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LandingScreen(store: store),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '3. Auth (Login/Signup)',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AuthScreen(store: store),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '4. Home Tab',
                    onTap: () {
                      Navigator.pop(ctx);
                      store.setTab(0);
                    },
                  ),
                  _JumpChip(
                    label: '5. Costume Detail (Buy/Rent)',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CostumeDetailScreen(
                            store: store,
                            costume: store.catalog.first,
                          ),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '6. Cart Tab',
                    onTap: () {
                      Navigator.pop(ctx);
                      store.setTab(1);
                    },
                  ),
                  _JumpChip(
                    label: '7. eKYC 3-Step Wizard',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EkycVerificationScreen(
                            store: store,
                            onVerifiedSuccess: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '8. Checkout & Mock Payment',
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(store: store),
                        ),
                      );
                    },
                  ),
                  _JumpChip(
                    label: '9. Alerts Tab',
                    onTap: () {
                      Navigator.pop(ctx);
                      store.setTab(2);
                    },
                  ),
                  _JumpChip(
                    label: '10. Wishlist Tab',
                    onTap: () {
                      Navigator.pop(ctx);
                      store.setTab(3);
                    },
                  ),
                  _JumpChip(
                    label: '11. Profile & Payment Setup',
                    onTap: () {
                      Navigator.pop(ctx);
                      showProfileModal(context, store);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: CosColors.bgPrimary,
          body: SafeArea(
            child: IndexedStack(
              index: store.activeBottomTab,
              children: [
                HomeTabView(store: store),
                CartTabView(store: store),
                AlertsTabView(store: store),
                WishlistTabView(store: store),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.small(
            backgroundColor: CosColors.bgInput,
            foregroundColor: CosColors.accentAmber,
            tooltip: 'Quick Screen Jumper',
            onPressed: () => _openDevScreenJumper(context),
            child: const Icon(Icons.bolt, size: 20),
          ),
          bottomNavigationBar: CosBottomNavBar(store: store),
        );
      },
    );
  }
}

class _JumpChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _JumpChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: CosColors.bgInput,
      side: const BorderSide(color: CosColors.borderSubtle),
      label: Text(
        label,
        style: const TextStyle(
          color: CosColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: onTap,
    );
  }
}
