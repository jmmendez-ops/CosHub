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
  late OrderMode _selectedMode;
  late final PageController _imagePageController;
  int _activeImageIndex = 0;
  String _selectedSize = 'M';
  int _rentalDays = 3;

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController();
    if (widget.costume.listingMode == ListingMode.buyOnly) {
      _selectedMode = OrderMode.buy;
    } else {
      _selectedMode = OrderMode.rent;
    }
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.costume;
    final images = c.carouselImages;
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
                    height: 350,
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
                        if (images.isNotEmpty)
                          PageView.builder(
                            controller: _imagePageController,
                            itemCount: images.length,
                            onPageChanged: (idx) {
                              setState(() => _activeImageIndex = idx);
                            },
                            itemBuilder: (context, idx) {
                              final img = images[idx];
                              return GestureDetector(
                                onTap: () => _openFullscreenGallery(context, idx),
                                child: img.startsWith('assets/')
                                    ? Image.asset(
                                        img,
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
                                    : Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        errorBuilder: (_, __, ___) => Center(
                                          child: Icon(
                                            c.motifIcon,
                                            size: 80,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                              );
                            },
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
                          top: 12,
                          left: 12,
                          child: GestureDetector(
                            onTap: () => _openFullscreenGallery(context, _activeImageIndex),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.72),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 0.8,
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.zoom_in,
                                    size: 13,
                                    color: CosColors.accentAmber,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Pinch to Zoom',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (images.length > 1) ...[
                          Positioned(
                            left: 4,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_activeImageIndex > 0) {
                                    _imagePageController.previousPage(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    _imagePageController.animateToPage(
                                      images.length - 1,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.65),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.25),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_activeImageIndex < images.length - 1) {
                                    _imagePageController.nextPage(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    _imagePageController.animateToPage(
                                      0,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.65),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.25),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.72),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.photo_library_outlined,
                                    size: 12,
                                    color: CosColors.accentAmber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_activeImageIndex + 1} / ${images.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            right: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(images.length, (idx) {
                                  final isSelected = idx == _activeImageIndex;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                    width: isSelected ? 16 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? CosColors.accentAmber
                                          : Colors.white.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
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
                  if (images.length > 1) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 64,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, idx) {
                          final img = images[idx];
                          final isSelected = idx == _activeImageIndex;
                          return GestureDetector(
                            onTap: () {
                              _imagePageController.animateToPage(
                                idx,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 52,
                              height: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected
                                      ? CosColors.accentAmber
                                      : CosColors.borderSubtle,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Opacity(
                                opacity: isSelected ? 1.0 : 0.6,
                                child: img.startsWith('assets/')
                                    ? Image.asset(
                                        img,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      )
                                    : Image.network(
                                        img,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      c.sellerLocation,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: CosColors.textSecondary,
                                        fontSize: 11,
                                      ),
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
                          child: Text(
                            c.makerBadgeLabel,
                            style: const TextStyle(
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
                  if (c.listingMode == ListingMode.both)
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
                            onInfoTap: () => _showDepositExplainer(
                              context,
                              c.securityDeposit,
                            ),
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
                    )
                  else if (c.listingMode == ListingMode.rentOnly)
                    _ModeOptionCard(
                      title: 'EXCLUSIVE RENTAL SET',
                      priceText: '${formatPeso(c.rentPricePerDay)}/day',
                      subtitle:
                          '+ ${formatPeso(c.securityDeposit)} refundable deposit • Rental Exclusive',
                      isSelected: true,
                      onTap: () {},
                      onInfoTap: () => _showDepositExplainer(
                        context,
                        c.securityDeposit,
                      ),
                    )
                  else if (c.listingMode == ListingMode.buyOnly)
                    _ModeOptionCard(
                      title: 'BUY BRAND NEW ONLY',
                      priceText: formatPeso(c.buyPrice),
                      subtitle:
                          'Keep forever • No deposit • Outright Purchase Exclusive',
                      isSelected: true,
                      onTap: () {},
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
                              const Expanded(
                                child: Column(
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
                              ),
                              const SizedBox(width: 8),
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
                                      : 'Rentals can be added to cart now; eKYC ID check will be requested at Checkout.',
                                  style: const TextStyle(
                                    color: CosColors.textSecondary,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () => _showDepositExplainer(
                                  context,
                                  c.securityDeposit,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CosColors.accentAmber
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: CosColors.accentAmber
                                          .withValues(alpha: 0.35),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: const Text(
                                    'Deposit Info',
                                    style: TextStyle(
                                      color: CosColors.accentAmber,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
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

  void _openFullscreenGallery(BuildContext context, int initialIndex) {
    final images = widget.costume.carouselImages;
    if (images.isEmpty) return;

    showDialog(
      context: context,
      useSafeArea: false,
      builder: (ctx) {
        int modalIndex = initialIndex;
        final PageController modalController =
            PageController(initialPage: initialIndex);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  '${modalIndex + 1} / ${images.length} • ${widget.costume.title}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  PageView.builder(
                    controller: modalController,
                    itemCount: images.length,
                    onPageChanged: (i) {
                      setModalState(() => modalIndex = i);
                      setState(() => _activeImageIndex = i);
                      if (_imagePageController.hasClients) {
                        _imagePageController.jumpToPage(i);
                      }
                    },
                    itemBuilder: (context, i) {
                      final img = images[i];
                      return InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.5,
                        child: Center(
                          child: img.startsWith('assets/')
                              ? Image.asset(img, fit: BoxFit.contain)
                              : Image.network(img, fit: BoxFit.contain),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Text(
                          'Pinch to zoom • Pan to inspect seams & craftsmanship',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDepositExplainer(BuildContext context, int depositAmount) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CosColors.bgElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CosColors.accentAmber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.security,
                      color: CosColors.accentAmber,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Refundable Security Deposit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: CosColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${formatPeso(depositAmount)} Escrow Protection',
                          style: const TextStyle(
                            fontSize: 12,
                            color: CosColors.accentAmber,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: CosColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const Divider(color: CosColors.borderSubtle, height: 24),
              const _DepositTimelineStep(
                icon: Icons.lock_clock,
                title: '1. Secure Escrow Hold',
                desc:
                    'Your deposit is held safely in COS HUB escrow throughout the rental duration.',
              ),
              const SizedBox(height: 12),
              const _DepositTimelineStep(
                icon: Icons.check_circle_outline,
                title: '2. Post-Convention Check',
                desc:
                    'Upon return, the lender confirms all costume inclusions are present and intact.',
              ),
              const SizedBox(height: 12),
              const _DepositTimelineStep(
                icon: Icons.account_balance_wallet_outlined,
                title: '3. 24-Hour Instant Release',
                desc:
                    'The full deposit is refunded back to your GCash or Maya wallet within 24 hours.',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CosColors.accentAmber,
                    foregroundColor: CosColors.bgPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'Got it, Understood',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ModeOptionCard extends StatelessWidget {
  final String title;
  final String priceText;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onInfoTap;

  const _ModeOptionCard({
    required this.title,
    required this.priceText,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.onInfoTap,
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ),
                if (onInfoTap != null)
                  GestureDetector(
                    onTap: onInfoTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.info_outline,
                        size: 14,
                        color: isSelected
                            ? CosColors.accentAmber
                            : CosColors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DepositTimelineStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _DepositTimelineStep({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: CosColors.accentAmber, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: CosColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
