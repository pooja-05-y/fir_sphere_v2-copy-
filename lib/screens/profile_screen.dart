import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'notifications_screen.dart';
import 'edit_profile_screen.dart';
import 'goals_screen.dart';

class ProfileScreen extends StatelessWidget {
  final bool showBackButton;
  const ProfileScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBg,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary, size: 20),
                onPressed: () => Navigator.pop(context))
            : null,
        title: Text('Profile',
            style: GoogleFonts.poppins(color: AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 18)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))]),
              child: Column(
                children: [
                  Stack(children: [
                    Container(width: 80, height: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primary.withOpacity(0.1)),
                        child: const Icon(Icons.person_rounded, color: AppTheme.primary, size: 44)),
                    Positioned(bottom: 0, right: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                        child: Container(width: 24, height: 24,
                            decoration: BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                            child: const Icon(Icons.edit, color: Colors.white, size: 12)),
                      )),
                  ]),
                  const SizedBox(height: 12),
                  Text('John', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                  Text('Fitness Enthusiast', style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textSecondary)),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    _ProfileStat(value: '28', label: 'Age'),
                    Container(height: 30, width: 1, color: AppTheme.lightBorder),
                    _ProfileStat(value: '75', label: 'kg'),
                    Container(height: 30, width: 1, color: AppTheme.lightBorder),
                    _ProfileStat(value: '178', label: 'cm'),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _MenuItem(icon: Icons.edit_outlined, iconBg: AppTheme.primary.withOpacity(0.1), iconColor: AppTheme.primary,
                label: 'Edit Profile', sub: 'Update your personal information',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
            const SizedBox(height: 10),
            _MenuItem(icon: Icons.flag_outlined, iconBg: AppTheme.orange.withOpacity(0.1), iconColor: AppTheme.orange,
                label: 'Goals', sub: 'Set and track your fitness goals',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GoalsScreen()))),
            const SizedBox(height: 10),
            _MenuItem(icon: Icons.notifications_outlined, iconBg: AppTheme.purple.withOpacity(0.1), iconColor: AppTheme.purple,
                label: 'Notifications', sub: 'Manage your notification preferences',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
            const SizedBox(height: 10),
            _MenuItem(icon: Icons.logout_rounded, iconBg: AppTheme.accent.withOpacity(0.1), iconColor: AppTheme.accent,
                label: 'Logout', sub: 'Sign out of your account',
                onTap: () => _showLogoutDialog(context)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Your Progress', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: 14),
                Row(children: [Expanded(child: _ProgressStat(value: '47', label: 'Workouts')), Expanded(child: _ProgressStat(value: '12', label: 'Streak Days'))]),
                const SizedBox(height: 12),
                Row(children: [Expanded(child: _ProgressStat(value: '8.2k', label: 'Best Steps')), Expanded(child: _ProgressStat(value: '15', label: 'Achievements'))]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18)),
        content: Text('Are you sure you want to sign out?', style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 14)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins(color: AppTheme.textSecondary))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text('Logout', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value; final String label;
  const _ProfileStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: AppTheme.textPrimary)),
    Text(label, style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 12)),
  ]);
}

class _MenuItem extends StatelessWidget {
  final IconData icon; final Color iconBg; final Color iconColor;
  final String label; final String sub; final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.iconBg, required this.iconColor, required this.label, required this.sub, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iconColor, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
          Text(sub, style: GoogleFonts.poppins(color: AppTheme.textSecondary, fontSize: 12)),
        ])),
        const Icon(Icons.chevron_right, color: AppTheme.textLight),
      ]),
    ),
  );
}

class _ProgressStat extends StatelessWidget {
  final String value; final String label;
  const _ProgressStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(value, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22)),
    Text(label, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 12)),
    const SizedBox(height: 4),
  ]);
}
