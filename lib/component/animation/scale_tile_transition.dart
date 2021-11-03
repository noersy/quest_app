import 'package:flutter/material.dart';

class ScaleTileTransition extends StatefulWidget {
  Widget child;
  Curve curve;

  ScaleTileTransition({Key? key, required this.child, required this.curve})
      : super(key: key);

  @override
  _ScaleTileTransitionState createState() => _ScaleTileTransitionState();
}

class _ScaleTileTransitionState extends State<ScaleTileTransition>
    with SingleTickerProviderStateMixin<ScaleTileTransition> {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
