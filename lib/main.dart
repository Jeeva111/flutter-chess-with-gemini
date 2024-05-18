import 'package:chess/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess with Gemini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
