import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';

class EkycVerificationScreen extends StatefulWidget {
  final CosHubStore store;
  final VoidCallback onVerifiedSuccess;

  const EkycVerificationScreen({
    super.key,
    required this.store,
    required this.onVerifiedSuccess,
  });

  @override
  State<EkycVerificationScreen> createState() => _EkycVerificationScreenState();
}

class _EkycVerificationScreenState extends State<EkycVerificationScreen> {
  int _step = 0;
  String _selectedIdType = 'PhilSys National ID';
  bool _idCaptured = false;
  bool _selfieCaptured = false;
  bool _isVerifying = false;

  final List<String> _idTypes = const [
    'PhilSys National ID',
    'University / College Student ID',
    'Philippine Passport',
    'Driver’s License / UMID',
  ];

  void _completeVerification() async {
    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    widget.store.completeEkyc(_selectedIdType);
    widget.onVerifiedSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: CosColors.bgPrimary,
        title: const Text(
          'Cosplayer eKYC Verification',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(3, (index) {
                final active = index <= _step;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                    height: 6,
                    decoration: BoxDecoration(
                      color: active ? CosColors.accentAmber : CosColors.bgInput,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 18),
            if (_step == 0) ...[
              const Text(
                'Step 1 of 3: Select Valid ID',
                style: TextStyle(
                  color: CosColors.accentAmber,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Why do we verify cosplayers?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              const Text(
                'Because our rental costumes include handcrafted armor, styled wigs, and props, a 1-time eKYC check protects community gear and keeps security deposits low.',
                style: TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              ..._idTypes.map((idType) {
                final selected = _selectedIdType == idType;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIdType = idType),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: selected
                            ? CosColors.accentAmber.withValues(alpha: 0.14)
                            : CosColors.bgElevated,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected
                              ? CosColors.accentAmber
                              : CosColors.borderSubtle,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            color: selected
                                ? CosColors.accentAmber
                                : CosColors.textSecondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              idType,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.check_circle,
                              color: CosColors.accentAmber,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ] else if (_step == 1) ...[
              const Text(
                'Step 2 of 3: Capture ID Card',
                style: TextStyle(
                  color: CosColors.accentAmber,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Scan your $_selectedIdType',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => setState(() => _idCaptured = true),
                child: Container(
                  height: 210,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CosColors.bgElevated,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: _idCaptured
                          ? CosColors.verifiedGreen
                          : CosColors.accentAmber,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _idCaptured
                            ? Icons.check_circle
                            : Icons.document_scanner_outlined,
                        size: 54,
                        color: _idCaptured
                            ? CosColors.verifiedGreen
                            : CosColors.accentAmber,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _idCaptured
                            ? 'ID Front & OCR Barcode Captured!'
                            : 'Tap to Simulate Camera ID Scan',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Name matched: Cristian Dave Ordoñez',
                        style: TextStyle(
                          color: CosColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              const Text(
                'Step 3 of 3: Selfie Liveness Check',
                style: TextStyle(
                  color: CosColors.accentAmber,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Quick Liveness Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 18),
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => _selfieCaptured = true),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: CosColors.bgElevated,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selfieCaptured
                            ? CosColors.verifiedGreen
                            : CosColors.accentAmber,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selfieCaptured
                              ? Icons.verified_user
                              : Icons.face_retouching_natural,
                          size: 56,
                          color: _selfieCaptured
                              ? CosColors.verifiedGreen
                              : CosColors.accentAmber,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _selfieCaptured
                              ? 'Biometric Match 99.4%'
                              : 'Tap to Scan Selfie',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CosColors.accentAmber,
                  foregroundColor: CosColors.bgPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                onPressed: _isVerifying
                    ? null
                    : () {
                        if (_step == 0) {
                          setState(() => _step = 1);
                        } else if (_step == 1) {
                          setState(() {
                            _idCaptured = true;
                            _step = 2;
                          });
                        } else {
                          setState(() => _selfieCaptured = true);
                          _completeVerification();
                        }
                      },
                child: _isVerifying
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: CosColors.bgPrimary,
                        ),
                      )
                    : Text(
                        _step < 2
                            ? 'Continue Verification →'
                            : 'Complete eKYC & Unlock Rentals',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
