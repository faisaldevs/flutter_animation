import 'dart:math';

import 'package:flutter/material.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()..rotateY(_animation.value),
              alignment: Alignment.center,
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.white,Colors.yellow],stops: [.5,.5]),
                  shape: BoxShape.circle
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
