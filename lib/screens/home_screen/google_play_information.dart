import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

import 'package:word_game_web/screens/game_screen/game_screen.dart';

class GooglePlayInformation extends StatelessWidget {
  const GooglePlayInformation({
    super.key,
    required Animation paddingGPlayAnim,
    required Animation opacityGPlayAnim,
  })  : _paddingGPlayAnim = paddingGPlayAnim,
        _opacityGPlayAnim = opacityGPlayAnim;

  final Animation _paddingGPlayAnim;
  final Animation _opacityGPlayAnim;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: _paddingGPlayAnim.value,
      child: Opacity(
        opacity: _opacityGPlayAnim.value,
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'AI Word Guess',
                  style: GoogleFonts.righteous(
                    textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(GameScreen.routeName);
                },
                child: Text(
                  'Try Web Demo Version',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              Text(
                'Or',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Text(
                'Try Mobile Version ',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  html.window.open(
                      'https://play.google.com/store/apps/details?id=com.pawik.word_game',
                      'new tab');
                },
                child: Image.asset(
                  'assets/google-play-badge.png',
                  // fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
