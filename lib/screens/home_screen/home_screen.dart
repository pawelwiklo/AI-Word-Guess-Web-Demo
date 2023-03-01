import 'package:flutter/material.dart';
import 'package:word_game_web/screens/home_screen/app_icon.dart';
import 'package:word_game_web/screens/home_screen/google_play_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final defaultCurve = Curves.linear;
  bool isMobile = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  Animation _buildAnim(
      {required tweenBegin,
      required tweenEnd,
      required double intervalBegin,
      required double intervalEnd}) {
    return Tween(
      begin: tweenBegin,
      end: tweenEnd,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        intervalBegin,
        intervalEnd,
        curve: defaultCurve,
      ),
    ));
  }

  late final Animation _slideIconAnim;
  late final Animation _opacityIconAnim;
  late final Animation _paddingIconAnim;
  late final Animation _paddingGPlayAnim;
  late final Animation _opacityGPlayAnim;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      setState(() {
        isMobile = true;
      });
    }

    _slideIconAnim = _buildAnim(
        tweenBegin: const EdgeInsets.only(top: 1000),
        tweenEnd: EdgeInsets.zero,
        intervalBegin: 0.0,
        intervalEnd: 0.8);

    _opacityIconAnim = _buildAnim(
        tweenBegin: 0.0, tweenEnd: 1.0, intervalBegin: 0.0, intervalEnd: 0.8);

    _paddingIconAnim = _buildAnim(
        tweenBegin: EdgeInsets.zero,
        tweenEnd: isMobile
            ? EdgeInsets.only(top: 10.0)
            : EdgeInsets.only(right: 350.0),
        intervalBegin: 0.8,
        intervalEnd: 1.0);

    _paddingGPlayAnim = _buildAnim(
        tweenBegin: EdgeInsets.zero,
        tweenEnd: isMobile
            ? EdgeInsets.only(top: 310.0)
            : EdgeInsets.only(left: 350.0),
        intervalBegin: 0.8,
        intervalEnd: 1.0);

    _opacityGPlayAnim = _buildAnim(
        tweenBegin: 0.0, tweenEnd: 1.0, intervalBegin: 0.8, intervalEnd: 1.0);

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              builder: _buildGooglePlayInfoAnimation,
              animation: _controller,
            ),
            if (!isMobile)
              AnimatedBuilder(
                builder: _buildDividerAnimation,
                animation: _controller,
              ),
            AnimatedBuilder(
              builder: _buildAppIconAnimation,
              animation: _controller,
            ),
          ],
        ),
      ),
    );
  }

  AppIcon _buildAppIconAnimation(BuildContext context, Widget? child) {
    return AppIcon(
        slideIconAnim: _slideIconAnim,
        paddingIconAnim: _paddingIconAnim,
        opacityIconAnim: _opacityIconAnim);
  }

  Container _buildDividerAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: _paddingGPlayAnim.value / 2,
      child: Opacity(
        opacity: _opacityGPlayAnim.value,
        child: const SizedBox(
          width: 300,
          height: 300,
          child: VerticalDivider(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  GooglePlayInformation _buildGooglePlayInfoAnimation(
      BuildContext context, Widget? child) {
    return GooglePlayInformation(
        paddingGPlayAnim: _paddingGPlayAnim,
        opacityGPlayAnim: _opacityGPlayAnim);
  }
}
