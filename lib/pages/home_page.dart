import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app_parts/box_card.dart';
import 'package:untitled/custom_widjets/custom_buttons/custom_elevated_button.dart';
import 'package:untitled/custom_widjets/custom_texts/title_text.dart';
import '../helpers/dimensions.dart';

class HomePage extends StatelessWidget {
  final String userUid;

  const HomePage({Key? key, required this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Are you sure you want to Log out ?"),
                        content: const Text(""),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomElevatedButton(
                                  color: Colors.red,
                                  text: "No",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  width: Dimensions.width(100),
                                  height: Dimensions.height(60)),
                              CustomElevatedButton(
                                  text: "Yes",
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await FirebaseAuth.instance.signOut();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  width: Dimensions.width(100),
                                  height: Dimensions.height(60)),
                            ],
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.size(18)),
                      bottomRight: Radius.circular(Dimensions.size(18)))),
              height: Dimensions.height(155),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.height(80),
                  ),
                  TitleText(
                    text: "Health Box",
                    fontSize: Dimensions.size(35),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: Dimensions.height(40),
                  ),
                  Column(
                    children: List.generate(
                        6, (index) => BoxCard(index: index, userUid: userUid)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
