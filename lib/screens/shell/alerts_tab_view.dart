import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../models/order_record.dart';
import '../../state/cos_hub_store.dart';
import '../commerce/order_tracking_screen.dart';

class AlertsTabView extends StatelessWidget {
  final CosHubStore store;
  const AlertsTabView({super.key, required this.store});

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
    final activeOrders = store.activeOrders;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active Orders & Live Tracking Section
          if (activeOrders.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ACTIVE ORDERS & LIVE TRACKING',
                    style: TextStyle(
                      color: CosColors.accentAmber,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: CosColors.accentAmber.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${activeOrders.length} Active',
                      style: const TextStyle(
                        color: CosColors.accentAmber,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activeOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final order = activeOrders[index];
                  final statusColor = _getStatusColor(order.status);

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#${order.id}',
                              style: const TextStyle(
                                color: CosColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                order.status.label,
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: order.heroImageUrl != null
                                    ? Image.asset(
                                        order.heroImageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          color: CosColors.bgInput,
                                          child: const Icon(
                                            Icons.checkroom,
                                            size: 24,
                                            color: CosColors.textSecondary,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: CosColors.bgInput,
                                        child: const Icon(
                                          Icons.checkroom,
                                          size: 24,
                                          color: CosColors.textSecondary,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.itemTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.5,
                                      color: CosColors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    order.deliveryMethod ==
                                            DeliveryMethod.conventionMeetup
                                        ? (order.courierDetails.meetupLocation ??
                                            'Convention Floor Meetup')
                                        : (order.courierDetails.riderName ??
                                            order.deliveryMethod.label),
                                    style: const TextStyle(
                                      color: CosColors.textSecondary,
                                      fontSize: 11.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 38,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CosColors.accentAmber,
                              foregroundColor: CosColors.bgPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => OrderTrackingScreen(
                                    order: order,
                                    store: store,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.near_me_outlined, size: 16),
                            label: const Text(
                              'Track Order',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Notifications & Alerts Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications & Alerts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                TextButton(
                  onPressed: store.markAllAlertsRead,
                  child: const Text(
                    'Mark all read',
                    style: TextStyle(
                      color: CosColors.accentAmber,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: store.alerts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final alert = store.alerts[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: alert.isUnread
                        ? CosColors.bgElevated
                        : CosColors.bgPrimary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: alert.isUnread
                          ? alert.accentColor.withValues(alpha: 0.5)
                          : CosColors.borderSubtle,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: alert.accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          alert.icon,
                          color: alert.accentColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    alert.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  alert.timestamp,
                                  style: const TextStyle(
                                    color: CosColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              alert.body,
                              style: const TextStyle(
                                color: CosColors.textSecondary,
                                fontSize: 12.5,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
