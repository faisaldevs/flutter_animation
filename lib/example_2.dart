import 'dart:math';

import 'package:flutter/material.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

extension on VoidCallback{
  Future<void> delayed(Duration duration) => Future.delayed(duration,this);
}

class _ExampleTwoState extends State<ExampleTwo>
    with TickerProviderStateMixin {
  late AnimationController _counterClockWiseRotationController;
  late AnimationController _flipController;
  late Animation _counterClockWiseRotationAnimation;
  late Animation _flipAnimation;

  @override
  void initState() {
    const Duration(seconds: 1);
    _counterClockWiseRotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _counterClockWiseRotationAnimation = Tween(begin: 0.0, end: -(pi / 2))
        .animate(CurvedAnimation(parent: _counterClockWiseRotationController, curve: Curves.bounceOut));

    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _flipAnimation = Tween(begin: 0.0, end: -(pi))
        .animate(CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _counterClockWiseRotationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _flipAnimation = Tween(begin: _counterClockWiseRotationAnimation.value, end: _counterClockWiseRotationAnimation.value+pi)
            .animate(CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

        _flipController..reset()..forward();

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _counterClockWiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockWiseRotationController..repeat()..reset()..forward.delayed(const Duration(seconds: 1));
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedBuilder(
              animation: _counterClockWiseRotationAnimation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_counterClockWiseRotationAnimation.value),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.blue
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.yellow],
                            stops: [.5, .5])),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
