import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'services/fitness_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FitnessService().init();
  runApp(const FitSphereApp());
}

class FitSphereApp extends StatelessWidget {
  const FitSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FitnessService>.value(
      value: FitnessService(),
      child: MaterialApp(
        title: 'FitSphere',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
