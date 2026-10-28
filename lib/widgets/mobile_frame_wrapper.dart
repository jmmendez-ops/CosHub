import 'package:flutter/material.dart';
import '../core/theme/cos_colors.dart';

class MobileFrameWrapper extends StatelessWidget {
  final Widget child;
  const MobileFrameWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 520) {
          return Scaffold(
            backgroundColor: const Color(0xFF090A0C),
            body: Center(
              child: Container(
                width: 412,
                height: constraints.maxHeight.clamp(680.0, 890.0),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: CosColors.bgPrimary,
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: const Color(0xFF2B2E37),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.75),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
