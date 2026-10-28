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
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: CosColors.bgInput,
          shape: BoxShape.circle,
          border: Border.all(color: CosColors.borderSubtle),
        ),
        child: Icon(icon, size: 16, color: CosColors.textPrimary),
      ),
    );
  }
}
