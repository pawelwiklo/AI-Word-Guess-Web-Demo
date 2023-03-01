import 'package:flutter/material.dart';
import 'package:word_game_web/screens/game_screen/game_screen.dart';

class AppIcon extends StatefulWidget {
  const AppIcon({
    super.key,
    required Animation slideIconAnim,
    required Animation paddingIconAnim,
    required Animation opacityIconAnim,
  })  : _slideIconAnim = slideIconAnim,
        _paddingIconAnim = paddingIconAnim,
        _opacityIconAnim = opacityIconAnim;

  final Animation _slideIconAnim;
  final Animation _paddingIconAnim;
  final Animation _opacityIconAnim;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  double scale = 1.0;

  void onMouseEnter(PointerEvent details) {
    setState(() {
      scale = 1.1;
    });
  }

  void onMouseExit(PointerEvent details) {
    setState(() {
      scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget._slideIconAnim.value,
      padding: widget._paddingIconAnim.value,
      child: Opacity(
        opacity: widget._opacityIconAnim.value,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(GameScreen.routeName);
          },
          child: MouseRegion(
            onEnter: onMouseEnter,
            onExit: onMouseExit,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Transform.scale(
                scale: scale,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Hero(
                      tag: 'app-icon',
                      child: Image.asset(
                        'assets/app_icon.png',
                        // fit: BoxFit.fill,
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
