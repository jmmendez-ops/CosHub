import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/cos_hub_logo.dart';
import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  final CosHubStore store;
  const SplashScreen({super.key, required this.store});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  double _progress = 0.15;
  String _loadingLabel = 'Initializing costume vault...';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..repeat(reverse: true);
    _scaleAnim = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _timer = Timer.periodic(const Duration(milliseconds: 450), (timer) {
      if (!mounted) return;
      setState(() {
        _progress += 0.30;
        if (_progress >= 0.45 && _progress < 0.75) {
          _loadingLabel = 'Syncing rental calendar & eKYC gate...';
        } else if (_progress >= 0.75) {
          _loadingLabel = 'Ready for convention season!';
        }
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LandingScreen(store: widget.store),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CosColors.accentAmber.withValues(alpha: 0.08),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: CosColors.bgElevated,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: CosColors.accentAmber.withValues(alpha: 0.35),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CosColors.accentAmber.withValues(alpha: 0.12),
                            blurRadius: 28,
                          ),
                        ],
                      ),
                      child: const CosHubLogo(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'BUY & RENT COSPLAY MARKETPLACE',
                    style: TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 48),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: _progress.clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: CosColors.bgInput,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        CosColors.accentAmber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _loadingLabel,
                    style: const TextStyle(
                      color: CosColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
