import 'package:flutter/material.dart';
import 'cos_colors.dart';

class CosTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CosColors.bgPrimary,
      colorScheme: const ColorScheme.dark(
        primary: CosColors.accentAmber,
        secondary: CosColors.accentAmber,
        surface: CosColors.bgElevated,
      ),
      fontFamily: 'Roboto',
      useMaterial3: true,
    );
  }
}
