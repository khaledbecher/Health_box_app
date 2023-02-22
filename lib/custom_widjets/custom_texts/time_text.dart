import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const TimeText(
      {Key? key,
      required this.text,
      this.color = Colors.grey,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
