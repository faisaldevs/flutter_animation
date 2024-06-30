import 'dart:math';
import 'package:flutter/material.dart';

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation _animation;


  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: const Duration(seconds: 3))..repeat();
    _animation = Tween(begin: 0.0,end: 2*pi).animate(_controller);
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
      appBar: AppBar(title: const Text("Flutter Animation",),foregroundColor: Colors.white,backgroundColor: Colors.black,elevation: 0,centerTitle: true,),
      backgroundColor: Colors.white10,

      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)
                      )
                    ]
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
