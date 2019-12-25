import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  TextWidget({@required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          // letterSpacing: 2.0,
          color: color,
        ),
      ),
    );
  }
}
