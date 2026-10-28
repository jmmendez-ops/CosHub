import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';

class CosHubLogo extends StatelessWidget {
  final double fontSize;
  const CosHubLogo({super.key, this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'COS',
          style: TextStyle(
            color: CosColors.textPrimary,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: fontSize * 0.32,
            vertical: fontSize * 0.12,
          ),
          decoration: BoxDecoration(
            color: CosColors.accentAmber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'HUB',
            style: TextStyle(
              color: CosColors.bgPrimary,
              fontSize: fontSize * 0.92,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    );
  }
}
