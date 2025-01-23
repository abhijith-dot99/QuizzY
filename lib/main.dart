import 'package:flutter/material.dart';
import 'package:quizzy/pages/game_page.dart';
import 'package:quizzy/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzy',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        scaffoldBackgroundColor: const Color.fromARGB(12, 13, 14, 4),
      ),
      home: HomePage(),
    );
  }
}
