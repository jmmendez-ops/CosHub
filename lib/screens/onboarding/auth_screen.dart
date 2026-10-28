import 'package:flutter/material.dart';
import '../../core/theme/cos_colors.dart';
import '../../state/cos_hub_store.dart';
import '../../widgets/cos_hub_logo.dart';
import '../shell/main_shell_screen.dart';

class AuthScreen extends StatefulWidget {
  final CosHubStore store;
  const AuthScreen({super.key, required this.store});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController _nameCtrl =
      TextEditingController(text: 'Cristian Dave Ordoñez');
  final TextEditingController _emailCtrl =
      TextEditingController(text: 'cristian@coshub.ph');
  final TextEditingController _passCtrl =
      TextEditingController(text: '••••••••••••');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submitAuth() {
    widget.store.login(
      _emailCtrl.text.trim().isEmpty
          ? 'cristian@coshub.ph'
          : _emailCtrl.text.trim(),
      _nameCtrl.text.trim().isEmpty
          ? 'Cristian Ordoñez'
          : _nameCtrl.text.trim(),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainShellScreen(store: widget.store)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: CosColors.bgPrimary,
        elevation: 0,
        title: const CosHubLogo(fontSize: 19),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: CosColors.bgInput,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: isLogin
                              ? CosColors.accentAmber
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: isLogin
                                ? CosColors.bgPrimary
                                : CosColors.textSecondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: !isLogin
                              ? CosColors.accentAmber
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: !isLogin
                                ? CosColors.bgPrimary
                                : CosColors.textSecondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Text(
              isLogin ? 'Welcome Back, Cosplayer!' : 'Join the COS HUB Guild',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: CosColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Manage your costume rentals, wishlist, and eKYC rental pass in one place.',
              style: TextStyle(color: CosColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 24),
            if (!isLogin) ...[
              const Text(
                'Full Name (matches Government/Student ID)',
                style: TextStyle(
                  color: CosColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              _AuthTextField(
                controller: _nameCtrl,
                hint: 'Enter your full name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'Email Address',
              style: TextStyle(
                color: CosColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            _AuthTextField(
              controller: _emailCtrl,
              hint: 'you@example.com',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(
                color: CosColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            _AuthTextField(
              controller: _passCtrl,
              hint: 'Enter password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 26),
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
                onPressed: _submitAuth,
                child: Text(
                  isLogin ? 'Continue to COS HUB' : 'Create Cosplayer Account',
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

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;

  const _AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: CosColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: CosColors.textSecondary),
        prefixIcon: Icon(icon, color: CosColors.textSecondary, size: 20),
        filled: true,
        fillColor: CosColors.bgInput,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: CosColors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: CosColors.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: CosColors.accentAmber, width: 1.5),
        ),
      ),
    );
  }
}
