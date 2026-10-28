import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';
import '../state/cos_hub_store.dart';

class CosBottomNavBar extends StatelessWidget {
  final CosHubStore store;
  const CosBottomNavBar({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Color(0xFF18191D),
        border: Border(
          top: BorderSide(color: Color(0xFF282B33), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_outlined,
            label: 'Home',
            isActive: store.activeBottomTab == 0,
            onTap: () => store.setTab(0),
          ),
          _NavBarItem(
            icon: Icons.shopping_cart_outlined,
            activeIcon: Icons.shopping_cart_outlined,
            label: 'Cart',
            badgeCount: store.cart.length,
            isActive: store.activeBottomTab == 1,
            onTap: () => store.setTab(1),
          ),
          _NavBarItem(
            icon: Icons.notifications_none_outlined,
            activeIcon: Icons.notifications_outlined,
            label: 'Alerts',
            badgeCount: store.unreadAlertsCount,
            isActive: store.activeBottomTab == 2,
            onTap: () => store.setTab(2),
          ),
          _NavBarItem(
            icon: Icons.favorite_border,
            activeIcon: Icons.favorite_border,
            label: 'Wishlist',
            badgeCount: store.wishlistIds.length,
            isActive: store.activeBottomTab == 3,
            onTap: () => store.setTab(3),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? CosColors.accentAmber : CosColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(isActive ? activeIcon : icon, color: color, size: 24),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: CosColors.accentAmber,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: CosColors.bgPrimary,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
