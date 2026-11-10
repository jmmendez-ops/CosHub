import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/order_record.dart';
import '../../state/cos_hub_store.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderRecord order;
  final CosHubStore store;

  const OrderTrackingScreen({
    super.key,
    required this.order,
    required this.store,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late OrderRecord _order;
  final Set<int> _checkedPieces = {};

  @override
  void initState() {
    super.initState();
    _order = widget.order;
  }

  void _requestReturnCourier() {
    widget.store.updateOrderStatus(_order.id, OrderStatus.returning);
    setState(() {
      _order = _order.copyWith(status: OrderStatus.returning);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: CosColors.bgElevated,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: CosColors.verifiedGreen, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Return courier requested! Lalamove rider dispatch in progress.',
                style: TextStyle(color: CosColors.textPrimary, fontSize: 13),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
      case OrderStatus.returned:
        return CosColors.verifiedGreen;
      case OrderStatus.inTransit:
      case OrderStatus.readyForMeetup:
      case OrderStatus.delivered:
        return CosColors.accentAmber;
      case OrderStatus.returning:
        return const Color(0xFF8B5CF6);
      case OrderStatus.placed:
      case OrderStatus.confirmed:
      case OrderStatus.preparing:
        return const Color(0xFF0EA5E9);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(_order.status);

    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: CosColors.bgPrimary,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LIVE ORDER TRACKING',
              style: TextStyle(
                color: CosColors.accentAmber,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '#${_order.id}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: CosColors.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Order Support',
            icon: const Icon(Icons.help_outline, color: CosColors.textSecondary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connecting to COS HUB 24/7 Con Support...'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and Item Summary Section
            _buildItemHeader(statusColor),
            const SizedBox(height: 16),

            // Logistics / Courier Card
            _buildLogisticsCard(),
            const SizedBox(height: 20),

            // Milestone Stepper
            _buildMilestoneTimeline(),
            const SizedBox(height: 20),

            // Piece Manifest Checklist
            if (_order.inclusions.isNotEmpty) ...[
              _buildPieceManifestCard(),
              const SizedBox(height: 20),
            ],

            // Rental Escrow & Deposit Tracker (for Rentals)
            if (_order.isRental) ...[
              _buildRentalEscrowCard(),
              const SizedBox(height: 20),
            ],

            // Order Financial & Location Summary
            _buildOrderFinancialSummary(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildItemHeader(Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 68,
                  height: 68,
                  child: _order.heroImageUrl != null
                      ? Image.asset(
                          _order.heroImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: CosColors.bgInput,
                            child: const Icon(
                              Icons.checkroom,
                              color: CosColors.textSecondary,
                              size: 32,
                            ),
                          ),
                        )
                      : Container(
                          color: CosColors.bgInput,
                          child: const Icon(
                            Icons.checkroom,
                            color: CosColors.textSecondary,
                            size: 32,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _order.isRental
                                ? const Color(0xFF8B5CF6).withValues(alpha: 0.16)
                                : const Color(0xFF0EA5E9).withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _order.isRental ? 'RENTAL' : 'PURCHASE',
                            style: TextStyle(
                              color: _order.isRental
                                  ? const Color(0xFF8B5CF6)
                                  : const Color(0xFF0EA5E9),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: CosColors.bgInput,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _order.itemCategory.toUpperCase(),
                            style: const TextStyle(
                              color: CosColors.textSecondary,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _order.itemTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: CosColors.textPrimary,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          _order.sellerHandle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CosColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 13,
                          color: CosColors.verifiedGreen,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.radio_button_checked,
                  size: 14,
                  color: statusColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _order.status.label,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
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

  Widget _buildLogisticsCard() {
    final method = _order.deliveryMethod;

    if (method == DeliveryMethod.conventionMeetup) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CosColors.bgElevated,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CosColors.borderSubtle),
        ),
        child: Column(
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
                    Icons.event_seat_outlined,
                    color: CosColors.accentAmber,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CONVENTION FLOOR MEETUP',
                        style: TextStyle(
                          color: CosColors.accentAmber,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        'Designated Hall Handover',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: CosColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_order.courierDetails.meetupLocation != null) ...[
              _buildLogisticsDetailRow(
                icon: Icons.location_on_outlined,
                label: 'Convention Booth Location',
                value: _order.courierDetails.meetupLocation!,
              ),
              const SizedBox(height: 10),
            ],
            if (_order.courierDetails.meetupTimeWindow != null) ...[
              _buildLogisticsDetailRow(
                icon: Icons.schedule_outlined,
                label: 'Pickup Time Window',
                value: _order.courierDetails.meetupTimeWindow!,
              ),
              const SizedBox(height: 10),
            ],
            if (_order.courierDetails.trackingNumber != null) ...[
              _buildLogisticsDetailRow(
                icon: Icons.qr_code_2_outlined,
                label: 'Convention Pass Ref #',
                value: _order.courierDetails.trackingNumber!,
              ),
            ],
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: CosColors.accentAmber,
                  side: const BorderSide(color: CosColors.accentAmber),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Showing directions to ${_order.courierDetails.meetupLocation ?? "booth"}',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.map_outlined, size: 16),
                label: const Text(
                  'Show Convention Hall Map',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Courier (Lalamove, Grab, J&T)
    final isLalamoveOrGrab = method == DeliveryMethod.lalamove ||
        method == DeliveryMethod.grabExpress;
    final courierTitle = method == DeliveryMethod.lalamove
        ? 'LALAMOVE EXPRESS (SAME DAY)'
        : method == DeliveryMethod.grabExpress
            ? 'GRAB EXPRESS (SAME DAY)'
            : 'J&T EXPRESS PROVINCIAL';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
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
                child: Icon(
                  isLalamoveOrGrab
                      ? Icons.two_wheeler_outlined
                      : Icons.local_shipping_outlined,
                  color: CosColors.accentAmber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courierTitle,
                      style: const TextStyle(
                        color: CosColors.accentAmber,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      _order.courierDetails.riderName ??
                          'Assigned Courier Rider',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: CosColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (_order.courierDetails.vehiclePlate != null) ...[
            _buildLogisticsDetailRow(
              icon: Icons.directions_car_outlined,
              label: 'Vehicle Plate & Unit',
              value: _order.courierDetails.vehiclePlate!,
            ),
            const SizedBox(height: 10),
          ],
          if (_order.courierDetails.trackingNumber != null) ...[
            _buildLogisticsDetailRow(
              icon: Icons.tag,
              label: 'Tracking Number',
              value: _order.courierDetails.trackingNumber!,
            ),
            const SizedBox(height: 10),
          ],
          if (_order.courierDetails.estimatedDelivery != null) ...[
            _buildLogisticsDetailRow(
              icon: Icons.timer_outlined,
              label: 'Estimated Handover',
              value: _order.courierDetails.estimatedDelivery!,
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CosColors.textPrimary,
                      side: const BorderSide(color: CosColors.borderSubtle),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    onPressed: () => _showSimulatedCallModal(context),
                    icon: const Icon(Icons.phone_outlined, size: 16),
                    label: const Text(
                      'Call Rider',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CosColors.bgInput,
                      foregroundColor: CosColors.accentAmber,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                        side: const BorderSide(color: CosColors.borderSubtle),
                      ),
                    ),
                    onPressed: () => _showSimulatedChatModal(context),
                    icon: const Icon(Icons.chat_bubble_outline, size: 16),
                    label: const Text(
                      'Message',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogisticsDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: CosColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: CosColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ORDER & FULFILLMENT TIMELINE',
                style: TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              Icon(
                Icons.timeline,
                size: 16,
                color: CosColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _order.milestones.length,
            itemBuilder: (context, index) {
              final milestone = _order.milestones[index];
              final isLast = index == _order.milestones.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: milestone.isCurrent
                                ? CosColors.accentAmber.withValues(alpha: 0.2)
                                : milestone.isCompleted
                                    ? CosColors.verifiedGreen.withValues(alpha: 0.2)
                                    : CosColors.bgInput,
                            border: Border.all(
                              color: milestone.isCurrent
                                  ? CosColors.accentAmber
                                  : milestone.isCompleted
                                      ? CosColors.verifiedGreen
                                      : CosColors.borderSubtle,
                              width: milestone.isCurrent ? 2 : 1.5,
                            ),
                          ),
                          child: Center(
                            child: milestone.isCurrent
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CosColors.accentAmber,
                                    ),
                                  )
                                : milestone.isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: CosColors.verifiedGreen,
                                      )
                                    : Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CosColors.textSecondary,
                                        ),
                                      ),
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: milestone.isCompleted
                                  ? CosColors.verifiedGreen.withValues(alpha: 0.5)
                                  : CosColors.borderSubtle,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    milestone.title,
                                    style: TextStyle(
                                      color: milestone.isCurrent
                                          ? CosColors.accentAmber
                                          : CosColors.textPrimary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  milestone.timestamp,
                                  style: TextStyle(
                                    color: milestone.isCurrent
                                        ? CosColors.accentAmber
                                        : CosColors.textSecondary,
                                    fontSize: 11,
                                    fontWeight: milestone.isCurrent
                                        ? FontWeight.w800
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              milestone.subtitle,
                              style: const TextStyle(
                                color: CosColors.textSecondary,
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPieceManifestCard() {
    final allChecked = _checkedPieces.length == _order.inclusions.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PIECE MANIFEST CHECKLIST',
                style: TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: allChecked
                      ? CosColors.verifiedGreen.withValues(alpha: 0.16)
                      : CosColors.bgInput,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${_checkedPieces.length}/${_order.inclusions.length} Verified',
                  style: TextStyle(
                    color: allChecked
                        ? CosColors.verifiedGreen
                        : CosColors.textSecondary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Inspect pieces upon handover. Tap each piece to mark as received and undamaged.',
            style: TextStyle(
              color: CosColors.textSecondary,
              fontSize: 12,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _order.inclusions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final piece = _order.inclusions[index];
              final isChecked = _checkedPieces.contains(index);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (isChecked) {
                      _checkedPieces.remove(index);
                    } else {
                      _checkedPieces.add(index);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isChecked
                        ? CosColors.verifiedGreen.withValues(alpha: 0.08)
                        : CosColors.bgInput,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isChecked
                          ? CosColors.verifiedGreen.withValues(alpha: 0.4)
                          : CosColors.borderSubtle,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isChecked
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 18,
                        color: isChecked
                            ? CosColors.verifiedGreen
                            : CosColors.textSecondary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          piece,
                          style: TextStyle(
                            color: isChecked
                                ? CosColors.textPrimary
                                : CosColors.textSecondary,
                            fontSize: 12.5,
                            fontWeight: isChecked
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRentalEscrowCard() {
    final canRequestReturn = _order.status == OrderStatus.delivered ||
        _order.status == OrderStatus.inTransit ||
        _order.status == OrderStatus.readyForMeetup;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RENTAL DURATION & ESCROW DEPOSIT',
                style: TextStyle(
                  color: CosColors.accentAmber,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${_order.rentalDays}-Day Rental Window',
                  style: const TextStyle(
                    color: Color(0xFF8B5CF6),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CosColors.bgInput,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CosColors.borderSubtle),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: CosColors.verifiedGreen,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Held in Escrow: ${formatPeso(_order.securityDeposit)} — Automatically refunded upon return piece inspection',
                        style: const TextStyle(
                          color: CosColors.textPrimary,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Protected by COS HUB Escrow Guarantee. No direct cash handling required.',
                        style: TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (canRequestReturn) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CosColors.accentAmber,
                  foregroundColor: CosColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                onPressed: _requestReturnCourier,
                icon: const Icon(Icons.assignment_return_outlined, size: 18),
                label: const Text(
                  'Request Return Courier',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5),
                ),
              ),
            ),
          ] else if (_order.status == OrderStatus.returning) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: Color(0xFF8B5CF6),
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Return courier dispatch in progress. Lender will verify pieces upon arrival.',
                      style: TextStyle(
                        color: Color(0xFF8B5CF6),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderFinancialSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CosColors.bgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CosColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PAYMENT & DELIVERY SUMMARY',
            style: TextStyle(
              color: CosColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Placed on', _order.createdAt),
          const SizedBox(height: 8),
          _buildSummaryRow('Delivery Method', _order.deliveryMethod.label),
          const SizedBox(height: 8),
          _buildSummaryRow('Seller Location', _order.sellerLocation),
          const Divider(color: CosColors.borderSubtle, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount Paid',
                style: TextStyle(
                  color: CosColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                formatPeso(_order.totalAmount),
                style: const TextStyle(
                  color: CosColors.accentAmber,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: CosColors.textSecondary,
            fontSize: 12.5,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: CosColors.textPrimary,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  void _showSimulatedCallModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        bool isMuted = false;
        bool isSpeaker = false;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
              decoration: const BoxDecoration(
                color: Color(0xFF16181F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(
                  top: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                  left: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                  right: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: CosColors.verifiedGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                        color: CosColors.verifiedGreen.withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, size: 12, color: CosColors.verifiedGreen),
                        SizedBox(width: 5),
                        Text(
                          'In-App Secure Courier Call',
                          style: TextStyle(
                            color: CosColors.verifiedGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CosColors.accentAmber.withValues(alpha: 0.15),
                      border: Border.all(
                        color: CosColors.accentAmber,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CosColors.accentAmber.withValues(alpha: 0.25),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.two_wheeler,
                      size: 42,
                      color: CosColors.accentAmber,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _order.courierDetails.riderName ?? 'Kuya Danilo Santos',
                    style: const TextStyle(
                      color: CosColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_order.courierDetails.vehiclePlate ?? "NCR-4819X"} • ${_order.deliveryMethod.label}',
                    style: const TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: CosColors.verifiedGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '00:04 • Connected (HD Audio)',
                        style: TextStyle(
                          color: CosColors.verifiedGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CosColors.bgInput,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: CosColors.borderSubtle),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          color: CosColors.accentAmber,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"Magandang araw po! On the way na po ako with the ${_order.itemTitle}. Naka-lock po sa insulated box ang props at wig."',
                                style: const TextStyle(
                                  color: CosColors.textPrimary,
                                  fontSize: 12.5,
                                  height: 1.35,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Live Audio Relay Simulation',
                                style: TextStyle(
                                  color: CosColors.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallControlButton(
                        icon: isMuted ? Icons.mic_off : Icons.mic,
                        label: isMuted ? 'Unmute' : 'Mute',
                        isActive: isMuted,
                        onTap: () {
                          setModalState(() => isMuted = !isMuted);
                        },
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(modalContext).pop(),
                        child: Column(
                          children: [
                            Container(
                              width: 62,
                              height: 62,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x66EF4444),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.call_end,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'End Call',
                              style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildCallControlButton(
                        icon: isSpeaker ? Icons.volume_up : Icons.volume_down,
                        label: isSpeaker ? 'Speaker' : 'Ear',
                        isActive: isSpeaker,
                        onTap: () {
                          setModalState(() => isSpeaker = !isSpeaker);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSimulatedChatModal(BuildContext context) {
    final textController = TextEditingController();
    final scrollController = ScrollController();

    final List<Map<String, dynamic>> messages = [
      {
        'isRider': true,
        'text': 'Good day po! Na-pick up ko na po ang costume set kay Seller. Maingat po nakalagay sa insulated box ang props at wig.',
        'time': '11:02 AM',
      },
      {
        'isRider': true,
        'text': 'Papunta na po ako sa delivery address. ETA mga 20-30 mins.',
        'time': '11:03 AM',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void sendMessage(String text) {
              if (text.trim().isEmpty) return;
              setModalState(() {
                messages.add({
                  'isRider': false,
                  'text': text.trim(),
                  'time': 'Just now',
                });
              });
              textController.clear();
              Future.delayed(const Duration(milliseconds: 100), () {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                }
              });

              // Simulated Rider auto-response
              Future.delayed(const Duration(milliseconds: 800), () {
                if (modalContext.mounted) {
                  setModalState(() {
                    messages.add({
                      'isRider': true,
                      'text': 'Sige po Sir, copy po! Ingatan ko po ito.',
                      'time': 'Just now',
                    });
                  });
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (scrollController.hasClients) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                }
              });
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.82,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF14161D),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(
                  top: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                  left: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                  right: BorderSide(color: CosColors.borderSubtle, width: 1.2),
                ),
              ),
              child: Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 12, 12),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CosColors.accentAmber.withValues(alpha: 0.15),
                                border: Border.all(color: CosColors.accentAmber, width: 1.5),
                              ),
                              child: const Icon(
                                Icons.two_wheeler,
                                size: 20,
                                color: CosColors.accentAmber,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: CosColors.verifiedGreen,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF14161D), width: 1.5),
                                ),
                              ),
                            ),
                          ],
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
                                      _order.courierDetails.riderName ?? 'Kuya Danilo Santos',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: CosColors.textPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color: CosColors.bgInput,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      _order.courierDetails.vehiclePlate ?? 'LALAMOVE',
                                      style: const TextStyle(
                                        color: CosColors.textSecondary,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Courier Direct Chat • Active Now',
                                style: TextStyle(
                                  color: CosColors.verifiedGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: CosColors.textSecondary),
                          onPressed: () => Navigator.of(modalContext).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: CosColors.borderSubtle, height: 1),
                  // Order contextual badge
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    color: CosColors.bgElevated,
                    child: Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 14, color: CosColors.accentAmber),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Order #${_order.id} • ${_order.itemTitle}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: CosColors.textSecondary,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Message list
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isRider = msg['isRider'] as bool;

                        return Align(
                          alignment: isRider ? Alignment.centerLeft : Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isRider ? CosColors.bgInput : CosColors.accentAmber,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isRider ? 2 : 16),
                                bottomRight: Radius.circular(isRider ? 16 : 2),
                              ),
                              border: isRider ? Border.all(color: CosColors.borderSubtle) : null,
                            ),
                            child: Column(
                              crossAxisAlignment: isRider ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  msg['text'] as String,
                                  style: TextStyle(
                                    color: isRider ? CosColors.textPrimary : CosColors.bgPrimary,
                                    fontSize: 13,
                                    fontWeight: isRider ? FontWeight.w500 : FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  msg['time'] as String,
                                  style: TextStyle(
                                    color: isRider ? CosColors.textSecondary : Colors.black54,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Quick reply chips
                  Container(
                    height: 38,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildQuickReplyChip('Salamat po Kuya! 🛵', () => sendMessage('Salamat po Kuya! 🛵')),
                        _buildQuickReplyChip('Paki-ingatan po ang props & wig 🙏', () => sendMessage('Paki-ingatan po ang props & wig 🙏')),
                        _buildQuickReplyChip('Pakitawag po pag nasa lobby na', () => sendMessage('Pakitawag po pag nasa lobby na')),
                      ],
                    ),
                  ),
                  // Bottom input field
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF14161D),
                      border: Border(top: BorderSide(color: CosColors.borderSubtle)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: CosColors.bgInput,
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: CosColors.borderSubtle),
                            ),
                            child: TextField(
                              controller: textController,
                              style: const TextStyle(
                                color: CosColors.textPrimary,
                                fontSize: 13,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Message rider...',
                                hintStyle: TextStyle(
                                  color: CosColors.textSecondary,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 11),
                              ),
                              onSubmitted: (val) => sendMessage(val),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => sendMessage(textController.text),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: CosColors.accentAmber,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send_rounded,
                              color: CosColors.bgPrimary,
                              size: 19,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildCallControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? CosColors.accentAmber.withValues(alpha: 0.2)
                  : CosColors.bgInput,
              border: Border.all(
                color: isActive ? CosColors.accentAmber : CosColors.borderSubtle,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? CosColors.accentAmber : CosColors.textPrimary,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? CosColors.accentAmber : CosColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplyChip(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: CosColors.bgInput,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: CosColors.borderSubtle),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: CosColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
