import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/controllers/round_controller.dart';
import 'package:word_game_web/screens/game_screen/header/header.dart';
import 'package:word_game_web/screens/game_screen/keyboard.dart';
import 'package:word_game_web/screens/game_screen/questionCard/question_card.dart';
import 'dart:math' as math;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/game-screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2));

  late final Animation iconRotate = Tween(
    begin: -0.15,
    end: 0.15,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth > 600 ? false : true;
        return Stack(
          children: [
            Center(
              child: Container(
                width: isMobile
                    ? constraints.maxWidth
                    : constraints.maxWidth * 0.6,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Expanded(flex: 1, child: Header()),
                            Expanded(flex: 10, child: QuestionCard()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Keyboard())
                  ],
                ),
              ),
            ),
            Positioned(
              top: isMobile ? 5.0 : 40.0,
              left: isMobile ? 5.0 : 40.0,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: iconRotate.value,
                      child: GestureDetector(
                        onTap: () {
                          Get.put(RoundController())
                              .gameFinishedDialog(context);
                        },
                        child: SizedBox(
                          width: isMobile ? 50.0 : 150.0,
                          height: isMobile ? 50.0 : 150.0,
                          child: Hero(
                            tag: 'app-icon',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.asset(
                                'assets/app_icon.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
