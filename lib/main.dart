import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/select_student_page.dart';
import 'screens/manual_answers_screen.dart';
import 'screens/results_screen.dart';
import '../core/theme/app_theme.dart';
import 'screens/camera_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniALFA Correção',
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/select-student': (context) => SelectStudentScreen(),
        '/manual-answers': (context) => const ManualAnswersScreen(),
        '/results': (context) => ResultsScreen(),
        '/camera': (context) => const CameraScreen(),
      },
    );
  }
}
