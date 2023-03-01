import 'package:flutter/material.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/screens/game_screen/questionCard/question_page_view.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: questionCard,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: const QuestionPageView(),
    );
  }
}
