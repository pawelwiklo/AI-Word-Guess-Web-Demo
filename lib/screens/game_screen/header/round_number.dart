import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';

class RoundNumber extends StatelessWidget {
  const RoundNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    return GestureDetector(
      onTap: () {
        Get.closeAllSnackbars();
        // levelSelectDialog(context);
      },
      child: Obx(
        () => Text(
          'Round ${roundController.qNumToDisplay}/${roundController.questions.length}',
          style: GoogleFonts.oswald(
            textStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: roundNumber),
          ),
        ),
      ),
    );
  }
}
