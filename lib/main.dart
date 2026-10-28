import 'package:flutter/material.dart';
import 'core/theme/cos_theme.dart';
import 'state/cos_hub_store.dart';
import 'widgets/mobile_frame_wrapper.dart';
import 'screens/onboarding/splash_screen.dart';

void main() {
  runApp(const CosHubApp());
}

class CosHubApp extends StatefulWidget {
  const CosHubApp({super.key});

  @override
  State<CosHubApp> createState() => _CosHubAppState();
}

class _CosHubAppState extends State<CosHubApp> {
  final CosHubStore store = CosHubStore();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COS HUB — Buy & Rent Cosplay',
      debugShowCheckedModeBanner: false,
      theme: CosTheme.darkTheme,
      home: MobileFrameWrapper(
        child: SplashScreen(store: store),
      ),
    );
  }
}
