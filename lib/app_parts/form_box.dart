import 'package:flutter/material.dart';
import '../helpers/dimensions.dart';

class FormBox extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const FormBox({
    Key? key,
    required this.hint,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  State<FormBox> createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> {
  bool visiblePassword = false;

  void hide() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: Dimensions.height(5),
      child: Stack(
        children: [
          Container(
            width: widget.hint == 'password'
                ? Dimensions.width(290)
                : double.maxFinite,
            padding: EdgeInsets.all(Dimensions.size8),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.hint == 'password' && visiblePassword == false
                  ? true
                  : false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(widget.icon),
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          widget.hint == 'password'
              ? Container(
                  margin: EdgeInsets.only(top: Dimensions.height(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            hide();
                          },
                          icon: Icon(visiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
