import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'fitness_tracker_screen.dart';
import 'diet_tracker_screen.dart';
import 'mood_tracker_screen.dart';
import 'workouts_screen.dart';
import 'food_log_screen.dart';
import 'progress_screen.dart';
import 'notifications_screen.dart';
import 'edit_profile_screen.dart';
import 'goals_screen.dart';
import 'meditation_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      drawer: _AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Builder(builder: (ctx) => GestureDetector(
                        onTap: () => Scaffold.of(ctx).openDrawer(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.darkCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.menu, color: Colors.white, size: 22),
                        ),
                      )),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FitSphere 🔥',
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                          Text('Track your wellness journey',
                              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                          Positioned(
                            top: 0, right: 0,
                            child: Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(color: AppTheme.accent, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Steps & Calories
              Row(
                children: [
                  Expanded(child: _StatCard(icon: Icons.directions_walk_rounded, iconColor: AppTheme.green, iconBg: AppTheme.green.withOpacity(0.2), label: 'Steps', sublabel: '/10000', value: '5400')),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icon: Icons.local_fire_department_rounded, iconColor: AppTheme.orange, iconBg: AppTheme.orange.withOpacity(0.2), label: 'Calories', sublabel: 'burned', value: '220')),
                ],
              ),
              const SizedBox(height: 12),

              // Mood card
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MoodTrackerScreen())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      const Text('😊', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Mood', style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
                        Text('Happy', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ])),
                      const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Quick actions
              Row(
                children: [
                  Expanded(child: _ActionButton(label: 'Workouts', color: AppTheme.teal,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutsScreen())))),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionButton(label: 'Meditation', color: AppTheme.purple,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MeditationScreen())))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _ActionButton(label: 'Food Log', color: AppTheme.orange,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodLogScreen())))),
                  const SizedBox(width: 10),
                  Expanded(child: _ActionButton(label: 'Progress', color: AppTheme.accent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen(showBackButton: true))))),
                ],
              ),
              const SizedBox(height: 20),

              // Fitness Tracker banner
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FitnessTrackerScreen(showBackButton: true))),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('View Fitness Tracker →', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DietTrackerScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.orange.withOpacity(0.3)),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Diet Tracker', style: GoogleFonts.poppins(color: AppTheme.orange, fontWeight: FontWeight.w600, fontSize: 13)),
                          Icon(Icons.arrow_forward_ios, color: AppTheme.orange, size: 14),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MoodTrackerScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.purple.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.purple.withOpacity(0.3)),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Mood Tracker', style: GoogleFonts.poppins(color: AppTheme.purple, fontWeight: FontWeight.w600, fontSize: 13)),
                          Icon(Icons.arrow_forward_ios, color: AppTheme.purple, size: 14),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Drawer ──────────────────────────────────────────────────────────────────

class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.darkBg,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 34),
                  ),
                  const SizedBox(height: 12),
                  Text('John', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                  Text('Fitness Enthusiast', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),

            // Nav items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(icon: Icons.home_rounded, label: 'Home', color: AppTheme.primary,
                      onTap: () => Navigator.pop(context)),
                  _DrawerItem(icon: Icons.monitor_heart_outlined, label: 'Fitness Tracker', color: AppTheme.teal,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const FitnessTrackerScreen(showBackButton: true))); }),
                  _DrawerItem(icon: Icons.restaurant_menu_rounded, label: 'Diet Tracker', color: AppTheme.orange,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const DietTrackerScreen())); }),
                  _DrawerItem(icon: Icons.mood_rounded, label: 'Mood Tracker', color: AppTheme.purple,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const MoodTrackerScreen())); }),
                  _DrawerItem(icon: Icons.fitness_center_rounded, label: 'Workouts', color: AppTheme.green,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutsScreen())); }),
                  _DrawerItem(icon: Icons.self_improvement_rounded, label: 'Meditation', color: AppTheme.purple,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const MeditationScreen())); }),
                  _DrawerItem(icon: Icons.fastfood_rounded, label: 'Food Log', color: AppTheme.orange,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodLogScreen())); }),
                  _DrawerItem(icon: Icons.bar_chart_rounded, label: 'Progress', color: AppTheme.accent,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen(showBackButton: true))); }),

                  Divider(color: AppTheme.darkCardLight, height: 24, indent: 16, endIndent: 16),

                  _DrawerItem(icon: Icons.person_outline_rounded, label: 'Profile', color: AppTheme.primary,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen(showBackButton: true))); }),
                  _DrawerItem(icon: Icons.edit_outlined, label: 'Edit Profile', color: AppTheme.teal,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())); }),
                  _DrawerItem(icon: Icons.flag_outlined, label: 'Goals', color: AppTheme.yellow,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const GoalsScreen())); }),
                  _DrawerItem(icon: Icons.notifications_outlined, label: 'Notifications', color: AppTheme.purple,
                      onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())); }),
                ],
              ),
            ),

            // Logout at bottom
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
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
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.logout_rounded, color: AppTheme.accent, size: 18),
                    const SizedBox(width: 8),
                    Text('Logout', style: GoogleFonts.poppins(color: AppTheme.accent, fontWeight: FontWeight.w600, fontSize: 14)),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _DrawerItem({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(label, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon; final Color iconColor; final Color iconBg;
  final String label; final String sublabel; final String value;
  const _StatCard({required this.icon, required this.iconColor, required this.iconBg, required this.label, required this.sublabel, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: iconColor, size: 16)),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
      ]),
      const SizedBox(height: 10),
      Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
      Text(sublabel, style: GoogleFonts.poppins(color: Colors.white38, fontSize: 11)),
    ]),
  );
}

class _ActionButton extends StatelessWidget {
  final String label; final Color color; final VoidCallback onTap;
  const _ActionButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Text(label, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
    ),
  );
}