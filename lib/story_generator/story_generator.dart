import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:katha_loop/core/apikey.dart';
import 'package:katha_loop/models/history.dart';

class StoryGenerator {
  static const String apiUrl = 'https://api.cohere.com/v1/chat';

  Future<List<HistoryModel>> getStoryContinuation(
      {required String userMessage,
      required List<HistoryModel> history}) async {
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: json.encode({
            'message': userMessage,
            'chat_history': List.generate(
              history.length,
              (index) => history[index].toMap(),
            ),
            'model': 'command-r-08-2024',
            'preamble':
                'You are a storyteller. You are trained to continue the story that user starts with and end the story in an open plot. Don\'t use emojis. Just continue the story without recapping. dont exceed the story more than 30 words. ',
          }),
          encoding: Utf8Codec());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // log(data.toString());
        // print(data);
        // print('Response: ${data['text']}');

        return historyModelFromMap(data['chat_history']);
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  List<HistoryModel> historyModelFromMap(List messageList) {
    return List.generate(
      messageList.length,
      (index) {
        return HistoryModel(
            message: messageList[index]['message'],
            role: messageList[index]['role']);
      },
    );
  }
}
