import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  const TypingAnimation({super.key});

  @override
  TypingAnimationState createState() => TypingAnimationState();
}

class TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 8.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                width: 4.0,
                height: _animation.value,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}