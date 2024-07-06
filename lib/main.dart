import 'package:chess/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {

  void testGemini() async {
    const String apiKey = String.fromEnvironment("GEMINI_API_KEY");
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    const prompt = 'Write a story about a magic backpack.';
    print('Prompt: $prompt');
    final content = [Content.text(prompt)];
    final tokenCount = await model.countTokens(content);
    print('Token count: ${tokenCount.totalTokens}');

    final response = await model.generateContent(content);
    print('Response:');
    print(response.text);
  }
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
