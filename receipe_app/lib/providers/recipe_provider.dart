import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecipeProvider with ChangeNotifier {
  String _recipe = '';

  String get recipe => _recipe;
  final apikey = dotenv.env['token'];

  Future<void> fetchRecipe(List<String> ingredients, String cuisine) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apikey!,
    );
    final prompt = _generatePrompt(ingredients, cuisine);

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      _recipe = response.text!;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load recipe: $e');
    }
  }

  void clearRecipe() {
    _recipe = '';
    notifyListeners();
  }

  String _generatePrompt(List<String> ingredients, String cuisine) {
    String prompt =
        'Generate a $cuisine recipe with the following ingredients: ${ingredients.join(", ")}';

    return prompt;
  }
}
