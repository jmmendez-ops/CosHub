import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';

class AppAlert {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  final IconData icon;
  final Color accentColor;
  bool isUnread;

  AppAlert({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.icon,
    this.accentColor = CosColors.accentAmber,
    this.isUnread = true,
  });
}
