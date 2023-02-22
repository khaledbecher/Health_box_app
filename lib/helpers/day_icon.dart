import 'package:flutter/material.dart';
import 'package:untitled/helpers/dimensions.dart';

class DayIcon extends StatelessWidget {
  final Color color;
  final String text;

  const DayIcon({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimensions.size(20),
          ),
        ),
      ),
      height: Dimensions.height(40),
      width: Dimensions.width(40),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimensions.size(13),
        ),
      ),
    );
  }
}
