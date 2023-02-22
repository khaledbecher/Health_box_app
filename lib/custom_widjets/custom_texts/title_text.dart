import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const TitleText(
      {Key? key,
      required this.text,
      this.color = Colors.blueGrey,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }
}
