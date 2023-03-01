import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/screens/game_screen/game_screen.dart';
import 'package:word_game_web/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        GameScreen.routeName: (ctx) => GameScreen(),
      },
    );
  }
}
