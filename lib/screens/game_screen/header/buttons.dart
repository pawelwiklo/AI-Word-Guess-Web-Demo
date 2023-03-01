import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/constraints/colors.dart';

class ChangeQuestionButton extends StatelessWidget {
  const ChangeQuestionButton({
    Key? key,
    required this.icon,
    required this.callback,
  }) : super(key: key);

  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
        Get.closeAllSnackbars();
      },
      child: Icon(
        icon,
        color: arrowColor,
        size: 25,
      ),
    );
  }
}
