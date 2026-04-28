import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class StrengthScreen extends StatelessWidget {
  const StrengthScreen({super.key});

  final List<Map<String, dynamic>> exercises = const [
    {
      'name': 'Bench Press',
      'sets': '4 sets',
      'reps': '10 reps',
      'rest': '90 sec',
      'icon': Icons.fitness_center,
    },
    {
      'name': 'Squats',
      'sets': '4 sets',
      'reps': '12 reps',
      'rest': '90 sec',
      'icon': Icons.accessibility_new_rounded,
    },
    {
      'name': 'Deadlift',
      'sets': '3 sets',
      'reps': '8 reps',
      'rest': '120 sec',
      'icon': Icons.fitness_center,
    },
    {
      'name': 'Pull Ups',
      'sets': '3 sets',
      'reps': '8 reps',
      'rest': '60 sec',
      'icon': Icons.expand_less_rounded,
    },
    {
      'name': 'Shoulder Press',
      'sets': '3 sets',
      'reps': '12 reps',
      'rest': '60 sec',
      'icon': Icons.fitness_center,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Strength',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.green.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.fitness_center,
                  color: Colors.white, size: 48),
            ),
            const SizedBox(height: 20),
            Text(
              'Strength Training',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Build muscle and increase your overall strength',
              style: GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: _QuickStat(
                      icon: Icons.timer_outlined,
                      label: 'Duration',
                      value: '60 min',
                      color: AppTheme.green),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _QuickStat(
                      icon: Icons.local_fire_department_rounded,
                      label: 'Calories',
                      value: '350 kcal',
                      color: AppTheme.orange),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _QuickStat(
                      icon: Icons.bar_chart_rounded,
                      label: 'Level',
                      value: 'Medium',
                      color: AppTheme.purple),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Exercise list
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Exercises',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...exercises.asMap().entries.map((entry) {
              final i = entry.key;
              final ex = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.darkCard,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppTheme.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: GoogleFonts.poppins(
                            color: AppTheme.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ex['name'] as String,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                _Tag(label: ex['sets'] as String),
                                const SizedBox(width: 6),
                                _Tag(label: ex['reps'] as String),
                                const SizedBox(width: 6),
                                _Tag(
                                    label: 'Rest ${ex['rest']}',
                                    color: AppTheme.orange.withOpacity(0.2),
                                    textColor: AppTheme.orange),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            // Tips
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppTheme.green.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tips',
                      style: GoogleFonts.poppins(
                          color: AppTheme.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                  const SizedBox(height: 8),
                  ...[
                    'Warm up for 10 minutes before starting',
                    'Keep proper form over heavy weight',
                    'Rest fully between sets',
                    'Stay hydrated throughout',
                  ].map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $t',
                            style: GoogleFonts.poppins(
                                color: Colors.white54, fontSize: 12)),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Strength workout started! 💪'),
                      backgroundColor: AppTheme.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Start Workout',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _QuickStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14)),
          Text(label,
              style:
                  GoogleFonts.poppins(color: Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;

  const _Tag({required this.label, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: textColor ?? Colors.white60,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}