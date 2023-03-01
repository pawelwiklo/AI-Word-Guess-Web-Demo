import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'package:word_game_web/controllers/round_controller.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.put(RoundController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: descriptionCard,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Text(
          roundController.questions[index].description,
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
              color: descriptionText,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
