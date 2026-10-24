import 'package:flutter/material.dart';
import 'screens/demo/demo_login_screen.dart';

void main() {
  runApp(const EloDemoApp());
}

class EloDemoApp extends StatelessWidget {
  const EloDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Elo — Demonstração',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF246B5D)),
          scaffoldBackgroundColor: const Color(0xFFF5F7F3),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF5F7F3),
            foregroundColor: Color(0xFF174B43),
            elevation: 0,
          ),
        ),
        home: const DemoLoginScreen(),
      );
}
