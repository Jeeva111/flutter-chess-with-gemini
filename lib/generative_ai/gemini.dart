import 'package:chess/generative_ai/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final class Gemini {
  static final ProviderContainer _container = ProviderContainer();
  static final gptModel = _container.read(geminiProvider);
  static late ChatSession _chatSession;

  static Future<String?> init() async {
    _chatSession = gptModel.startChat();
    const String instruction = '''Can you play chess with me. using FEN ''';
    final response = await _chatSession.sendMessage(Content.text(instruction));
    print(response.text);
    return response.text;
  }
  
  static Future<String?> prompt(String prompt) async {
    final content = Content.text(prompt);
    final tokenCount = await gptModel.countTokens([content]);
    print('Token count: ${tokenCount.totalTokens}');

    final response = await _chatSession.sendMessage(content);
    print(response.text);
    return response.text;
  }

  static void dispose() {
    _container.dispose();
  }
}