import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';
import 'package:word_game_web/screens/game_screen/header/buttons.dart';
import 'package:word_game_web/screens/game_screen/header/round_number.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: header,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChangeQuestionButton(
            icon: Icons.arrow_circle_left_outlined,
            callback: Get.put(RoundController()).previousQuestion,
          ),
          RoundNumber(),
          ChangeQuestionButton(
            icon: Icons.arrow_circle_right_outlined,
            callback: Get.put(RoundController()).nextQuestion,
          ),
        ],
      ),
    );
  }
}
