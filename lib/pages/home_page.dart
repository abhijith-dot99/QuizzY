import 'package:flutter/material.dart';
import 'package:quizzy/pages/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double? _deviceWidth, _deviceHeight;
  double currentSliderValue = 0;
  List<String> difficultyLevel = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(0, 3, 12, 2),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              gameName(),
              sliderButton(),
              startButton(context),
            ])));
  }

  Widget gameName() {
    return Column(children: [
      const Text(
        "Quizzy",
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
      ),
      Text(
        difficultyLevel[currentSliderValue.toInt()],
        style: const TextStyle(color: Colors.white, fontSize: 15),
      )
    ]);
  }

  Widget sliderButton() {
    return Slider(
      label: difficultyLevel[currentSliderValue.toInt()],
      min: 0,
      max: 2,
      value: currentSliderValue,
      divisions: 2,
      onChanged: (value) {
        setState(() {
          currentSliderValue = value;
        });
      },
    );
  }

  Widget startButton(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, color: Colors.red),
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50));
    return Center(
      child: ElevatedButton(
        style: style,
        onPressed: () {
          String selectedDifficulty =
              difficultyLevel[currentSliderValue.toInt()];

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GamePage(selectedDifficulty: selectedDifficulty)),
          );
        },
        child: const Text(
          "Start Game",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
