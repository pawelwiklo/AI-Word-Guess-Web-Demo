import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';

class Boxes extends StatefulWidget {
  const Boxes({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  final Duration duration = const Duration(milliseconds: 500);
  final double errorAnimDistance = 20.0;

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> with TickerProviderStateMixin {
  late final shakeController = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final colorController =
      AnimationController(vsync: this, duration: widget.duration);

  @override
  void dispose() {
    shakeController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    roundController.setAnimationControllers(shakeController, colorController);

    final errorColorTween = errorTween().animate(colorController);
    final correctColTween = correctTween().animate(colorController);

    final wordLength = roundController.questions[widget.index].answer.length;

    double marginValue = 5;
    if (wordLength <= 2) {
      marginValue = 25;
      if (Get.put(RoundController()).wideKeyDialog) {
        marginValue = 100;
      }
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: boxesCard,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(10),
          child: AnimatedBuilder(
            animation: shakeController,
            builder: (BuildContext context, Widget? child) {
              final dx = sin(shakeController.value * 4 * pi) *
                  widget.errorAnimDistance;
              return Transform.translate(
                offset: Offset(dx, 0),
                child: child,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  wordLength,
                  (letterIndex) => Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size =
                            constraints.maxWidth - (marginValue * 2) > 0
                                ? constraints.maxWidth - (marginValue * 2)
                                : 40.0;
                        return Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedBuilder(
                            animation:
                                roundController.questions[widget.index].finished
                                    ? correctColTween
                                    : errorColorTween,
                            builder: (context, child) => Container(
                              height: size,
                              width: size,
                              decoration: BoxDecoration(
                                border: Border.all(color: boxBorder, width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                color: roundController.questions[widget.index]
                                            .hintIndex ==
                                        letterIndex
                                    ? boxAfterHintBackground
                                    : boxColor(roundController, correctColTween,
                                        errorColorTween),
                              ),
                              margin: EdgeInsets.all(marginValue),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    roundController.getLetter(
                                        questionIndex: widget.index,
                                        letterIndex: letterIndex),
                                    style: TextStyle(
                                        color: boxText,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            child: HintButton(
                roundController: roundController, index: widget.index)),
      ],
    );
  }

  ColorTween correctTween() {
    return ColorTween(begin: boxCorrect, end: boxCorrectAccent);
  }

  ColorTween errorTween() => ColorTween(begin: boxBackground, end: boxError);

  Color? boxColor(RoundController roundController,
      Animation<Color?> correctColorTween, Animation<Color?> errorColorTween) {
    return roundController.questions[widget.index].finished
        ? correctColorTween.value
        : errorColorTween.value;
  }
}

class HintButton extends StatelessWidget {
  const HintButton({
    Key? key,
    required this.roundController,
    required this.index,
  }) : super(key: key);

  final RoundController roundController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          roundController.useHint();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: hintBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            roundController.questions[index].isHintUsed
                ? 'Hint 0/1'
                : 'Hint 1/1',
            style: TextStyle(color: hintText),
          ),
        ));
  }
}
