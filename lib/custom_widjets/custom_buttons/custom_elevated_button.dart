import 'package:flutter/material.dart';
import 'package:untitled/custom_widjets/custom_texts/title_text.dart';
import '../../helpers/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double width, height;
  final Color color;

  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.height,
      this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: Dimensions.height(10),
        fixedSize: Size(width, height),
      ),
      child: TitleText(
        color: Colors.white,
        text: text,
        fontSize: Dimensions.size(25),
      ),
    );
  }
}
