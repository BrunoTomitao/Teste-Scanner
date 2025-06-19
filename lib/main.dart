import 'package:flutter/material.dart';
import 'package:hackathon/screens/login_page.dart';
import 'package:hackathon/screens/results_screen.dart';
import 'screens/login_page.dart';
import 'screens/camera_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(const UniAlfaApp());
}

class UniAlfaApp extends StatelessWidget {
  const UniAlfaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniALFA Gabarito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.greenAccent.shade400,
          secondary: Colors.greenAccent.shade700,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.shade400,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/camera': (context) => const CameraScreen(),
        '/results': (context) => const ResultScreen(),
      },
    );
  }
}
