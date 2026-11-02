import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/cos_hub_logo.dart';
import '../shell/main_shell_screen.dart';
import 'auth_screen.dart';

class LandingScreen extends StatelessWidget {
  final CosHubStore store;
  const LandingScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CosHubLogo(fontSize: 22),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => MainShellScreen(store: store),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip to Store →',
                      style: TextStyle(
                        color: CosColors.accentAmber,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B2230), Color(0xFF2E1F3B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: CosColors.borderSubtle),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Opacity(
                        opacity: 0.38,
                        child: Image.asset(
                          'assets/images/studio/cartethyia.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CosColors.bgPrimary.withValues(alpha: 0.2),
                              CosColors.bgPrimary.withValues(alpha: 0.94),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: CosColors.accentAmber,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: const Text(
                                'PH #1 COSPLAY RENTAL & SHOP',
                                style: TextStyle(
                                  color: CosColors.bgPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Suit Up for Your Next Convention.',
                              style: TextStyle(
                                color: CosColors.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Rent full studio-grade sets starting at ₱350/day or buy brand-new armor, wigs, and props with eKYC-protected security deposits.',
                              style: TextStyle(
                                color: CosColors.textSecondary,
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Row(
                              children: [
                                _FeatureBadge(
                                  icon: Icons.verified_user_outlined,
                                  label: 'eKYC Protected',
                                ),
                                SizedBox(width: 10),
                                _FeatureBadge(
                                  icon: Icons.cleaning_services_outlined,
                                  label: 'Sanitized Sets',
                                ),
                                SizedBox(width: 10),
                                _FeatureBadge(
                                  icon: Icons.bolt,
                                  label: 'Same-Day Dispatch',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosColors.accentAmber,
                    foregroundColor: CosColors.bgPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MainShellScreen(store: store),
                      ),
                    );
                  },
                  child: const Text(
                    'Explore Costumes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: CosColors.textPrimary,
                    side: const BorderSide(color: CosColors.borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AuthScreen(store: store),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign In / Create Cosplayer Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
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

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: CosColors.bgInput.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CosColors.borderSubtle),
        ),
        child: Column(
          children: [
            Icon(icon, color: CosColors.accentAmber, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CosColors.textPrimary,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
