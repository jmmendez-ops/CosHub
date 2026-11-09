import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../models/costume_item.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/cos_hub_logo.dart';
import '../../widgets/costume_grid_card.dart';
import '../../widgets/hero_banner_card.dart';
import '../../widgets/profile_bottom_sheet.dart';
import '../commerce/costume_detail_screen.dart';

class HomeTabView extends StatelessWidget {
  final CosHubStore store;
  const HomeTabView({super.key, required this.store});

  void _openDetail(BuildContext context, CostumeItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CostumeDetailScreen(store: store, costume: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featuredList = store.featuredCostumes;
    final currentHero =
        featuredList[store.heroCarouselIndex % featuredList.length];
    final products = store.gridCostumes;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                const CosHubLogo(fontSize: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: CosColors.bgInput,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: CosColors.borderSubtle),
                    ),
                    child: TextField(
                      onChanged: store.setSearchQuery,
                      style: const TextStyle(
                        color: CosColors.textPrimary,
                        fontSize: 13.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search costumes',
                        hintStyle: TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 13.5,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => showProfileModal(context, store),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CosColors.bgInput,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: store.isEkycVerified
                                ? CosColors.verifiedGreen
                                : CosColors.borderSubtle,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: CosColors.textPrimary,
                          size: 20,
                        ),
                      ),
                      if (store.isEkycVerified)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: CosColors.verifiedGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                HeroBannerCard(
                  costume: currentHero,
                  onPrev: store.prevHeroSlide,
                  onNext: store.nextHeroSlide,
                  onViewCostume: () => _openDetail(context, currentHero),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(featuredList.length, (idx) {
                    final isSelected = idx == store.heroCarouselIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 24 : 8,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CosColors.accentAmber
                            : const Color(0xFF3A3D46),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 8),
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: store.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = store.categories[index];
                  final isSelected = store.selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => store.setCategory(cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CosColors.accentAmber
                            : CosColors.bgInput,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: isSelected
                              ? CosColors.accentAmber
                              : CosColors.borderSubtle,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected
                              ? CosColors.bgPrimary
                              : CosColors.textSecondary,
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 14),
            child: SizedBox(
              height: 30,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: store.modeFilters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final mode = store.modeFilters[index];
                  final isSelected = store.selectedModeFilter == mode;
                  return GestureDetector(
                    onTap: () => store.setModeFilter(mode),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CosColors.bgElevated
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: isSelected
                              ? CosColors.accentAmber
                              : CosColors.borderSubtle.withValues(alpha: 0.6),
                          width: isSelected ? 1.2 : 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (mode == 'For Rent')
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.sync,
                                size: 13,
                                color: Color(0xFF8B5CF6),
                              ),
                            )
                          else if (mode == 'For Sale')
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 13,
                                color: Color(0xFF0EA5E9),
                              ),
                            ),
                          Text(
                            mode,
                            style: TextStyle(
                              color: isSelected
                                  ? CosColors.accentAmber
                                  : CosColors.textSecondary,
                              fontSize: 11.5,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (products.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'No costumes match your filter.',
                style: TextStyle(color: CosColors.textSecondary),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = products[index];
                  final isWishlisted = store.wishlistIds.contains(item.id);
                  return CostumeGridCard(
                    costume: item,
                    isWishlisted: isWishlisted,
                    onToggleWishlist: () => store.toggleWishlist(item.id),
                    onTapCard: () => _openDetail(context, item),
                    onQuickAddToCart: () {
                      final isBuy = item.listingMode == ListingMode.buyOnly;
                      final mode = isBuy ? OrderMode.buy : OrderMode.rent;
                      store.addToCart(costume: item, mode: mode);
                      final modeLabel = isBuy ? 'Buy' : 'Rent';
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: CosColors.bgElevated,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          content: Text(
                            'Added "${item.title}" ($modeLabel) to Cart',
                            style: const TextStyle(color: CosColors.textPrimary),
                          ),
                          action: SnackBarAction(
                            label: 'VIEW CART',
                            textColor: CosColors.accentAmber,
                            onPressed: () => store.setTab(1),
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: products.length,
              ),
            ),
          ),
      ],
    );
  }
}
