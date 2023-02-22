import 'package:flutter/material.dart';
import 'package:untitled/helpers/dimensions.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final void Function() function;

  const CustomIconButton({Key? key, required this.icon, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.size30)),
      child: IconButton(
        color: Colors.white,
        icon: icon,
        iconSize: Dimensions.size(22),
        onPressed: function,
      ),
    );
  }
}
