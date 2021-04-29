import 'package:flutter/material.dart';

class SweetOpicty extends StatefulWidget {
  final int time;
  final Widget child;
  final curvy;
  SweetOpicty(
      {required this.child, required this.time, this.curvy = Curves.easeIn});
  @override
  _SweetOpictyState createState() => _SweetOpictyState();
}

class _SweetOpictyState extends State<SweetOpicty>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.time),
      lowerBound: 0,
      upperBound: 1,
    )
      ..addStatusListener((status) {
        setState(() {});
      })
      ..forward();
    animation = CurvedAnimation(parent: _controller, curve: widget.curvy);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }
}
