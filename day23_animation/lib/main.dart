import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const AnimatedWidgetExampleApp());

class AnimatedWidgetExampleApp extends StatelessWidget {
  const AnimatedWidgetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogoApp(),
    );
  }
}

class SpinContainer extends AnimatedWidget {
  const SpinContainer({
    super.key,
    required AnimationController controller,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * math.pi,
      child: Container(
        color: Colors.amber,
        child: const FlutterLogo(),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

    static final _opacityTween = Tween<double>(begin: 0.2, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {super.key, required this.child, required this.animation});
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  // late final AnimationController controller = AnimationController(
  //   duration: const Duration(seconds: 10),
  //   vsync: this,
  // )..repeat();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut)
      ..addStatusListener((status) {
        print('$status $animation.value');
        // if(status == AnimationStatus.completed) {
        //   controller.reverse();
        // } else if(status == AnimationStatus.dismissed){
        //   controller.forward();
        // }
      });
    // ..addListener(() {
    //   setState(() {});
    // });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation,);

    // return GrowTransition(
    //   animation: animation,
    //   child: Container(
    //     margin: const EdgeInsets.symmetric(vertical: 10),
    //     child: const FlutterLogo(),
    //   ),
    // );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
