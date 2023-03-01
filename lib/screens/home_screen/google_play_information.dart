import 'package:flutter/material.dart';
import 'dart:html' as html;

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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'AI Word Guess',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const Text(
                'Try Web Demo Version',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Or',
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'Try Mobile Version ',
                style: TextStyle(fontSize: 20),
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
