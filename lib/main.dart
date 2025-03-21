import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Trainee 2025',
      home: const MainScreen(),
    );
  }
}
