import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../models/costume_item.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/costume_grid_card.dart';
import '../commerce/costume_detail_screen.dart';

class WishlistTabView extends StatelessWidget {
  final CosHubStore store;
  const WishlistTabView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final items = store.wishlistedCostumes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Saved Wishlist',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        if (items.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 56,
                    color: CosColors.textSecondary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No saved costumes yet',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => store.setTab(0),
                    child: const Text(
                      'Tap the heart on any costume to save it →',
                      style: TextStyle(color: CosColors.accentAmber),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.66,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return CostumeGridCard(
                  costume: item,
                  isWishlisted: true,
                  onToggleWishlist: () => store.toggleWishlist(item.id),
                  onTapCard: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CostumeDetailScreen(
                          store: store,
                          costume: item,
                        ),
                      ),
                    );
                  },
                  onQuickAddToCart: () {
                    store.addToCart(costume: item, mode: OrderMode.rent);
                    store.setTab(1);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
