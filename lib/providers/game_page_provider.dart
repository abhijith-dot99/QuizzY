import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GameProvider extends ChangeNotifier {
  final Dio dio = Dio();
  List? question;
  int questionCount = 0;
  int scoreCount = 0;
  String selectedDifficulty;

  BuildContext context;
  GameProvider({required this.context, required this.selectedDifficulty}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php?';
    getDataApi();
  }

  Future<void> getDataApi() async {
    print("selected diff$selectedDifficulty");
    try {
      var response = await dio.get('', queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': selectedDifficulty.toLowerCase()
      });
      var data = jsonDecode(response.toString());
      question = data['results'];
      print("|dd$question");
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  String getQuestions() {
    return question![questionCount]['question'];
  }

  void answerToquestion(String answer) async {
    bool isCorrect = question![questionCount]['correct_answer'] == answer;

    scoreCount += isCorrect ? 1 : 0;
    questionCount++;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                color: Colors.white),
          );
        });
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context);
    print("questionCount$questionCount");
    if (questionCount == 3) {
      endGameCondition();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGameCondition() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color:
                      Colors.black.withOpacity(0.2), // Semi-transparent overlay
                ),
              ),
              AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  "Game End",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 24,
                  ),
                ),
                content: Text(
                  "Your Score : $scoreCount",
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Colors.greenAccent, fontSize: 20),
                ),
              )
            ],
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    questionCount = 0;
    scoreCount = 0;
    Navigator.pop(context);
    notifyListeners();
  }
}
