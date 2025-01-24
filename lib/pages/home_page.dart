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
  int? selectedQestionNo = 5;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(0, 3, 12, 2),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              gameName(),
              const Spacer(),
              selectQuestionNo(),
              const SizedBox(
                height: 10,
              ),
              sliderButton(),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              startButton(context),
              const SizedBox(
                height: 30,
              ),
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

  Widget selectQuestionNo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            flex: 5,
            child: Text(
              "Select no of questions:",
              style: TextStyle(
                  fontSize: 16, color: Colors.white), // Optional: Styling
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: DropdownButton<int>(
              isExpanded: true,
              value: selectedQestionNo,
              items: <int>[5, 10, 15].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedQestionNo = value;
                });
                print("selectedQestionNo$selectedQestionNo");
              },
              dropdownColor: Colors.black,
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined, // Use a different icon
                color: Colors.white, // Optional: Change icon color
                size: 24, // Optional: Change icon size
              ),
            ),
          ),
        ],
      ),
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
                builder: (context) => GamePage(
                    selectedDifficulty: selectedDifficulty,
                    selectedQestionNo: selectedQestionNo!)),
          );
        },
        child: const Text(
          "Start",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
