import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/controllers/round_controller.dart';
import 'package:word_game_web/screens/game_screen/questionCard/boxes.dart';
import 'package:word_game_web/screens/game_screen/questionCard/description.dart';

class QuestionPageView extends StatelessWidget {
  const QuestionPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    return Obx(
      () => PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: roundController.pageController,
        onPageChanged: roundController.updateTheQnNum,
        itemCount: roundController.questions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: Boxes(index: index),
              ),
              Expanded(
                flex: 4,
                child: Description(index: index),
              ),
            ],
          );
        },
      ),
    );
  }
}
