import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_parts/config_box.dart';
import 'package:untitled/custom_widjets/custom_buttons/custom_icon_button.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';
import 'package:untitled/custom_widjets/custom_texts/title_text.dart';
import 'package:untitled/helpers/dimensions.dart';

import '../app_parts/config_options.dart';
import '../states/main_state.dart';

class ConfigurationPage extends StatelessWidget {
  final int index;
  final String title;

  // ignore: prefer_typing_uninitialized_variables
  final userIndex;

  const ConfigurationPage(
      {Key? key, required this.index, required this.title, this.userIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: Dimensions.height(10),
            ),
            alignment: Alignment.center,
            height: Dimensions.height(180),
            width: double.maxFinite,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height(30),
                ),
                TitleText(
                  text: 'Configuration',
                  fontSize: Dimensions.size(30),
                  color: Colors.white,
                ),
                TimeText(
                  text: title,
                  fontSize: Dimensions.size(20),
                  color: Colors.black45,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.height(705),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    Dimensions.size(30),
                  ),
                  topRight: Radius.circular(
                    Dimensions.size(30),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    7,
                    (val) => ConfigBox(
                      userIndex: userIndex,
                      index: index,
                      dayIndex: val,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width(8), top: Dimensions.height(40)),
                child: CustomIconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    function: () {
                      if (state.visibleButtonsList) {
                        state.changeVisibleButtonsList();
                      }
                      Navigator.pop(context);
                    })),
          ),
          ConfigOptions(userIndex: userIndex, index: index),
        ],
      ),
    );
  }
}
