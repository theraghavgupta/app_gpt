import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:app_gpt/openai/api_key.dart';
import 'package:app_gpt/openai/completions_request.dart';
import 'package:app_gpt/openai/openai_models.dart';
import 'dart:math';
import 'package:app_gpt/openai/completions_response.dart';

class CompletionsApi {
  // The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  // The headers for the completions endpoint, which are the same for
  // all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIApiKey',
  };

  static final String key = DateFormat.yMMMd().format(DateTime.now());

  static Future<String> outDisplay(int maxTokens, String inPrompt) async {
    // Generate a random number for picking a random prompt
    Random rng = Random();

    // Get a random temperature for this request between 0.6 and 0.8
    double temp = rng.nextInt(3) / 10 + 0.3;

    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textCurie001).identifier,
      // prompt: completionsPrompts[promptIndex],
      prompt: inPrompt,
      maxTokens: maxTokens,
      temperature: temp,
    );

    debugPrint(
        'Sending OpenAI API request with prompt $inPrompt and temperature, $temp.');

    http.Response response = await http.post(completionsEndpoint,
        headers: headers, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    // Check to see if there was an error
    if (response.statusCode != 200) {
      debugPrint(
          'Failed to get a results with status code, ${response.statusCode}');
    }

    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    return completionsResponse.firstCompletion.trim();
  }
}
