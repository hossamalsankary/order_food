import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FancyButton extends StatefulWidget {
  final GestureTapCallback onpress;
  final String text;
  final Color filcolor;
  final Color splashColor;

  FancyButton(
      {required this.onpress,
      required this.text,
      this.filcolor = Colors.orange,
      this.splashColor = Colors.yellow});
  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: widget.onpress,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      fillColor: widget.filcolor,
      splashColor: widget.splashColor,
      shape: const StadiumBorder(),
    );
  }
}
