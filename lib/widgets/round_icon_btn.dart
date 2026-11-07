import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';

class RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const RoundIconBtn({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: CosColors.bgInput,
            shape: BoxShape.circle,
            border: Border.all(color: CosColors.borderSubtle),
          ),
          child: Icon(icon, size: 16, color: CosColors.textPrimary),
        ),
      ),
    );
  }
}
