import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../theme/app_theme.dart';

class HiitScreen extends StatefulWidget {
  const HiitScreen({super.key});

  @override
  State<HiitScreen> createState() => _HiitScreenState();
}

class _HiitScreenState extends State<HiitScreen> {
  int _currentExercise = 0;
  bool _isRunning = false;
  bool _isResting = false;
  int _secondsLeft = 40;
  Timer? _timer;

  final List<Map<String, dynamic>> exercises = [
    {
      'name': 'Jumping Jacks',
      'duration': 40,
      'rest': 20,
      'emoji': '⭐',
      'desc': 'Full body warm up',
    },
    {
      'name': 'Burpees',
      'duration': 40,
      'rest': 20,
      'emoji': '🔥',
      'desc': 'Full body explosive move',
    },
    {
      'name': 'High Knees',
      'duration': 40,
      'rest': 20,
      'emoji': '🦵',
      'desc': 'Cardio & core engagement',
    },
    {
      'name': 'Mountain Climbers',
      'duration': 40,
      'rest': 20,
      'emoji': '⚡',
      'desc': 'Core & upper body',
    },
    {
      'name': 'Jump Squats',
      'duration': 40,
      'rest': 20,
      'emoji': '💥',
      'desc': 'Lower body power',
    },
    {
      'name': 'Push Ups',
      'duration': 40,
      'rest': 20,
      'emoji': '💪',
      'desc': 'Upper body strength',
    },
  ];

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          if (_isResting) {
            // Rest done — move to next exercise
            _isResting = false;
            if (_currentExercise < exercises.length - 1) {
              _currentExercise++;
              _secondsLeft =
                  exercises[_currentExercise]['duration'] as int;
            } else {
              // Workout complete
              _timer?.cancel();
              _isRunning = false;
              _showCompleteDialog();
            }
          } else {
            // Exercise done — start rest
            _isResting = true;
            _secondsLeft = exercises[_currentExercise]['rest'] as int;
          }
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isResting = false;
      _currentExercise = 0;
      _secondsLeft = exercises[0]['duration'] as int;
    });
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.darkCard,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉', style: TextStyle(fontSize: 48),
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Workout Complete!',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Great job! You burned approx. 280 kcal',
                style: GoogleFonts.poppins(
                    color: Colors.white54, fontSize: 13),
                textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetTimer();
            },
            child: Text('Do Again',
                style: GoogleFonts.poppins(color: AppTheme.orange)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Done',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[_currentExercise];
    final totalDuration = _isResting
        ? exercise['rest'] as int
        : exercise['duration'] as int;
    final progress = _secondsLeft / totalDuration;

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            _timer?.cancel();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'HIIT',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: _resetTimer,
            child: Text('Reset',
                style:
                    GoogleFonts.poppins(color: AppTheme.orange, fontSize: 13)),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress indicator row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: exercises.asMap().entries.map((e) {
                final done = e.key < _currentExercise;
                final current = e.key == _currentExercise;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: current ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: done
                        ? AppTheme.green
                        : current
                            ? AppTheme.orange
                            : AppTheme.darkCardLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              '${_currentExercise + 1} / ${exercises.length}',
              style: GoogleFonts.poppins(
                  color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 24),

            // Phase label
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: _isResting
                    ? AppTheme.teal.withOpacity(0.2)
                    : AppTheme.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isResting ? '😮‍💨 REST' : '🔥 WORK',
                style: GoogleFonts.poppins(
                  color: _isResting ? AppTheme.teal : AppTheme.orange,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Timer circle
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: AppTheme.darkCardLight,
                    valueColor: AlwaysStoppedAnimation(
                      _isResting ? AppTheme.teal : AppTheme.orange,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exercise['emoji'] as String,
                      style: const TextStyle(fontSize: 36),
                    ),
                    Text(
                      '$_secondsLeft',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'seconds',
                      style: GoogleFonts.poppins(
                          color: Colors.white38, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Exercise name
            Text(
              _isResting ? 'Rest' : exercise['name'] as String,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _isResting
                  ? 'Catch your breath'
                  : exercise['desc'] as String,
              style: GoogleFonts.poppins(
                  color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 28),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _resetTimer,
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppTheme.darkCard,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.replay_rounded,
                        color: Colors.white60, size: 24),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: _isRunning ? _pauseTimer : _startTimer,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.orange,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.orange.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _timer?.cancel();
                    setState(() {
                      _isResting = false;
                      if (_currentExercise < exercises.length - 1) {
                        _currentExercise++;
                        _secondsLeft =
                            exercises[_currentExercise]['duration'] as int;
                        if (_isRunning) _startTimer();
                      }
                    });
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppTheme.darkCard,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.skip_next_rounded,
                        color: Colors.white60, size: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Upcoming exercises
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Up Next',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...exercises
                .asMap()
                .entries
                .where((e) => e.key > _currentExercise)
                .take(3)
                .map((e) {
              final ex = e.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.darkCard,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(ex['emoji'] as String,
                          style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          ex['name'] as String,
                          style: GoogleFonts.poppins(
                              color: Colors.white60,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        '${ex['duration']}s',
                        style: GoogleFonts.poppins(
                            color: AppTheme.orange, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
