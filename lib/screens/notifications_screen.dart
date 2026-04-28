import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool workoutReminders = true;
  bool waterIntake = true;
  bool meditationSessions = false;
  bool dailyGoals = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppTheme.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stay Updated',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              'Your recent activity reminders',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Recent notifications
            _NotifCard(
              icon: Icons.directions_run,
              iconBg: AppTheme.orange.withOpacity(0.15),
              iconColor: AppTheme.orange,
              title: 'Workout',
              message: 'Time for your evening workout!',
              time: '6:00 PM',
            ),
            const SizedBox(height: 10),
            _NotifCard(
              icon: Icons.water_drop_outlined,
              iconBg: AppTheme.primary.withOpacity(0.1),
              iconColor: AppTheme.primary,
              title: 'Water',
              message: "Don't forget to drink water",
              time: '5:00 PM',
            ),
            const SizedBox(height: 10),
            _NotifCard(
              icon: Icons.self_improvement,
              iconBg: AppTheme.purple.withOpacity(0.1),
              iconColor: AppTheme.purple,
              title: 'Meditation',
              message: 'Your daily meditation session awaits',
              time: '3:00 PM',
            ),
            const SizedBox(height: 24),

            Text(
              'Notification Settings',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: AppTheme.cardDecoration(),
              child: Column(
                children: [
                  _ToggleTile(
                    label: 'Workout Reminders',
                    value: workoutReminders,
                    onChanged: (v) => setState(() => workoutReminders = v),
                    showDivider: true,
                  ),
                  _ToggleTile(
                    label: 'Water Intake',
                    value: waterIntake,
                    onChanged: (v) => setState(() => waterIntake = v),
                    showDivider: true,
                  ),
                  _ToggleTile(
                    label: 'Meditation Sessions',
                    value: meditationSessions,
                    onChanged: (v) =>
                        setState(() => meditationSessions = v),
                    showDivider: true,
                  ),
                  _ToggleTile(
                    label: 'Daily Goals',
                    value: dailyGoals,
                    onChanged: (v) => setState(() => dailyGoals = v),
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.lightBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Clear All Notifications',
                  style: GoogleFonts.poppins(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
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

class _NotifCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String message;
  final String time;

  const _NotifCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: AppTheme.cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.textPrimary,
                    )),
                Text(message,
                    style: GoogleFonts.poppins(
                        color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(time,
              style:
                  GoogleFonts.poppins(color: AppTheme.textLight, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const _ToggleTile({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  )),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppTheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: AppTheme.lightBorder, indent: 16),
      ],
    );
  }
}
