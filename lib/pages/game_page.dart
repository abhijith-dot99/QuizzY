import 'package:quizzy/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  final String selectedDifficulty;
  final int selectedQestionNo;
  double? _deviceHeight, _deviceWidth;

  GameProvider? pageProvider;

  GamePage(
      {required this.selectedDifficulty,
      required this.selectedQestionNo,
      super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GameProvider(
          context: context,
          selectedDifficulty: selectedDifficulty,
          selectedQestionNo: selectedQestionNo),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      pageProvider = context.watch<GameProvider>();
      if (pageProvider!.question != null) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(0, 3, 12, 2),
              centerTitle: true,
              title: const Row(
                mainAxisSize: MainAxisSize.min, // Center aligns Row's content
                children: [
                  SizedBox(width: 8), // Add space between icon and text
                  Text('QuizZy',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  Icon(
                    Icons.question_mark,
                    color: Colors.red,
                  ),
                ],
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.home, // Home icon
                  color: Colors.white, // White color
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Use your navigation logic here
                },
              ),
            ),
            backgroundColor: Color.fromARGB(0, 3, 12, 2),
            body: SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
              child: _gameUI(),
            )));
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        );
      }
    });
  }

  Widget _gameUI() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _questionText(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _trueButton(),
                SizedBox(
                  height: _deviceHeight! * 0.01,
                ),
                _falseButton(),
              ],
            ),
          ]),
    );
  }

  Widget _questionText() {
    return Text(
      pageProvider!.getQuestions(),
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerToquestion('True');
      },
      color: Colors.green,
      minWidth: _deviceHeight! * 0.50,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return Builder(builder: (context) {
      return MaterialButton(
        onPressed: () {
          pageProvider!.answerToquestion('False');
        },
        color: Colors.red,
        minWidth: _deviceHeight! * 0.50,
        height: _deviceHeight! * 0.10,
        child: const Text(
          "false",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
    });
  }
}
