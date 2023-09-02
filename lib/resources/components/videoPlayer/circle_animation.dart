import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({required this.child,super.key});
  final Widget child;

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    controller.forward();
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      child: widget.child,
        turns: Tween(
      begin: 0.0,
      end: 1.0,
      
    ).animate(controller));
  }
}
