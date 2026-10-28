import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';

class AlertsTabView extends StatelessWidget {
  final CosHubStore store;
  const AlertsTabView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
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
    );
  }
}
