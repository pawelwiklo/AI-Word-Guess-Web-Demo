import 'package:flutter/material.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';
import 'package:word_game_web/models/keyboard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
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
