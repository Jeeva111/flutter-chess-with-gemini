import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final geminiProvider = Provider<GenerativeModel>((ref) {
  const String apiKey = String.fromEnvironment("GEMINI_API_KEY");
 return GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
});