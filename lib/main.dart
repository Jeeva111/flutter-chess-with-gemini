import 'package:chess/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp.router(
      title: 'Chess with Gemini',
      theme: ThemeData(
        fontFamily: "speed",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: routers,
    );
  }
}
