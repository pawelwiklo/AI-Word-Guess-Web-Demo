import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';
import 'package:word_game_web/models/keyboard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Keyboard extends StatelessWidget {
  Keyboard({
    Key? key,
  }) : super(key: key);

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) => {
        if (event is RawKeyDownEvent)
          {
            _handleKeyPressed(event, context),
          }
      },
      child: Column(
        children: const [
          KeyboardRow(
            rowNumber: 0,
          ),
          KeyboardRow(
            rowNumber: 1,
          ),
          KeyboardRow(
            rowNumber: 2,
          ),
        ],
      ),
    );
  }

  _handleKeyPressed(RawKeyEvent event, BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    if (event is RawKeyDownEvent) {
      String key = event.data.logicalKey.keyLabel.toUpperCase();
      if (roundController.isWinSnackbarOpen && key == 'ENTER') {
        roundController.isWinSnackbarOpen = false;
        roundController.nextQuestion();
        Get.closeCurrentSnackbar();
      } else {
        roundController.keyboardPress(context, key);
      }
    }
  }
}

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    Key? key,
    required this.rowNumber,
  }) : super(key: key);

  final int rowNumber;

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    return Expanded(
      child: Row(
        children: <Widget>[
          ...List.generate(keys[rowNumber].length, (index) {
            int flex = 1;
            String letter = keys[rowNumber][index];
            if (letter == 'ENTER' || letter == 'DEL') {
              flex = 2;
            }
            GlobalObjectKey _key = GlobalObjectKey(letter);
            return Expanded(
              key: _key,
              flex: flex,
              child: GestureDetector(
                onTap: () {
                  roundController.keyboardPress(context, letter);
                },
                child: Container(
                  height: double.infinity,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    color: keyboardKey,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            letter,
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: keyboardLetter,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
