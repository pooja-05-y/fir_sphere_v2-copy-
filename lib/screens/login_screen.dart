import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: Center(child: Text('💪', style: const TextStyle(fontSize: 34))),
              ),
              const SizedBox(height: 14),
              Text('FitSphere',
                  style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.primary)),
              Text('Your wellness companion',
                  style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(height: 28),

              // Tab bar
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.lightBorder,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  controller: _tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.textSecondary,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                  dividerColor: Colors.transparent,
                  tabs: const [Tab(text: 'Login'), Tab(text: 'Sign Up')],
                ),
              ),
              const SizedBox(height: 28),

              // Tab views
              SizedBox(
                height: _tab.index == 0 ? 380 : 500,
                child: TabBarView(
                  controller: _tab,
                  children: const [
                    _LoginForm(),
                    _SignUpForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Login form ───────────────────────────────────────────────────────────────

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Email'),
        const SizedBox(height: 6),
        _field(controller: _emailCtrl, hint: 'Enter your email', icon: Icons.email_outlined, type: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _label('Password'),
        const SizedBox(height: 6),
        _field(
          controller: _passCtrl,
          hint: 'Enter your password',
          icon: Icons.lock_outline,
          obscure: _obscure,
          suffix: IconButton(
            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: AppTheme.textLight, size: 20),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => _showForgotPassword(context),
            child: Text('Forgot Password?',
                style: GoogleFonts.poppins(color: AppTheme.primary, fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: _loading ? null : () async {
              setState(() => _loading = true);
              await Future.delayed(const Duration(milliseconds: 800));
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell()));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: _loading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : Text('Login', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 20),
        // Social divider
        Row(children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('or continue with', style: GoogleFonts.poppins(color: AppTheme.textLight, fontSize: 12)),
          ),
          const Expanded(child: Divider()),
        ]),
        const SizedBox(height: 16),
        _SocialButton(icon: '🔍', label: 'Continue with Google', onTap: () {}),
      ],
    );
  }

  void _showForgotPassword(BuildContext context) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.lightBorder, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            Text('Forgot Password?',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
            const SizedBox(height: 6),
            Text("Enter your email and we'll send a reset link.",
                style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 20),
            _field(controller: ctrl, hint: 'Enter your email', icon: Icons.email_outlined, type: TextInputType.emailAddress),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reset link sent to ${ctrl.text.isEmpty ? "your email" : ctrl.text}!'),
                      backgroundColor: AppTheme.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text('Send Reset Link',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 8),
          ]),
        ),
      ),
    );
  }
}

// ─── Sign Up form ─────────────────────────────────────────────────────────────

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  bool _loading = false;

  String? _validate() {
    if (_nameCtrl.text.trim().isEmpty) return 'Please enter your name';
    if (_emailCtrl.text.trim().isEmpty) return 'Please enter your email';
    if (!_emailCtrl.text.contains('@')) return 'Please enter a valid email';
    if (_passCtrl.text.length < 6) return 'Password must be at least 6 characters';
    if (_passCtrl.text != _confirmCtrl.text) return 'Passwords do not match';
    if (!_agreeTerms) return 'Please agree to the terms';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Full Name'),
        const SizedBox(height: 6),
        _field(controller: _nameCtrl, hint: 'Enter your full name', icon: Icons.person_outline),
        const SizedBox(height: 14),
        _label('Email'),
        const SizedBox(height: 6),
        _field(controller: _emailCtrl, hint: 'Enter your email', icon: Icons.email_outlined, type: TextInputType.emailAddress),
        const SizedBox(height: 14),
        _label('Password'),
        const SizedBox(height: 6),
        _field(
          controller: _passCtrl, hint: 'Create a password', icon: Icons.lock_outline, obscure: _obscurePass,
          suffix: IconButton(
            icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility, color: AppTheme.textLight, size: 20),
            onPressed: () => setState(() => _obscurePass = !_obscurePass),
          ),
        ),
        const SizedBox(height: 14),
        _label('Confirm Password'),
        const SizedBox(height: 6),
        _field(
          controller: _confirmCtrl, hint: 'Confirm your password', icon: Icons.lock_outline, obscure: _obscureConfirm,
          suffix: IconButton(
            icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: AppTheme.textLight, size: 20),
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ),
        const SizedBox(height: 14),
        Row(children: [
          Checkbox(
            value: _agreeTerms,
            onChanged: (v) => setState(() => _agreeTerms = v ?? false),
            activeColor: AppTheme.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(
            child: Text.rich(TextSpan(
              style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(text: 'Terms of Service', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                const TextSpan(text: ' and '),
                TextSpan(text: 'Privacy Policy', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
              ],
            )),
          ),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: _loading ? null : () async {
              final err = _validate();
              if (err != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(err), backgroundColor: AppTheme.accent));
                return;
              }
              setState(() => _loading = true);
              await Future.delayed(const Duration(milliseconds: 1000));
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell()));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: _loading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : Text('Create Account',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 14),
        _SocialButton(icon: '🔍', label: 'Sign up with Google', onTap: () {}),
      ],
    );
  }
}

// ─── Shared helpers ───────────────────────────────────────────────────────────

Widget _label(String text) => Text(text,
    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textSecondary));

Widget _field({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  TextInputType type = TextInputType.text,
  bool obscure = false,
  Widget? suffix,
}) {
  return TextField(
    controller: controller,
    keyboardType: type,
    obscureText: obscure,
    style: GoogleFonts.poppins(fontSize: 14, color: AppTheme.textPrimary),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: AppTheme.textLight, fontSize: 14),
      prefixIcon: Icon(icon, color: AppTheme.textLight, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.lightBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.lightBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primary, width: 1.5)),
    ),
  );
}

class _SocialButton extends StatelessWidget {
  final String icon; final String label; final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.lightBorder),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Text(label, style: GoogleFonts.poppins(color: AppTheme.textPrimary, fontWeight: FontWeight.w500, fontSize: 14)),
      ]),
    ),
  );
}