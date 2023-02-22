import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_widjets/custom_buttons/custom_icon_button.dart';
import '../custom_widjets/custom_texts/title_text.dart';
import '../helpers/dimensions.dart';

class ConfigOptions extends StatefulWidget {
  final int index;
  final int userIndex;

  const ConfigOptions({Key? key, required this.index, required this.userIndex})
      : super(key: key);

  @override
  State<ConfigOptions> createState() => _ConfigOptionsState();
}

class _ConfigOptionsState extends State<ConfigOptions> {
  late bool visibleButtonsList;

  @override
  // ignore: must_call_super
  initState() {
    visibleButtonsList = false;
  }

  void changeVisibleButtonsList() {
    setState(() {
      visibleButtonsList = !visibleButtonsList;
    });
  }

  late final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height(15),
                  horizontal: Dimensions.width(8)),
              margin: EdgeInsets.only(
                top: Dimensions.height(5),
                left: Dimensions.width(5),
                right: Dimensions.width(5),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.size(30),
                  ),
                  color: Colors.grey[100]),
              child: SizedBox(
                height: Dimensions.height(30),
                width: Dimensions.width(30),
                child: const CircularProgressIndicator(),
              ),
            );
          }
          final dataMap =
              snapshot.data!.docs[widget.userIndex]['box${widget.index + 1}'];
          return Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: Dimensions.width(8), top: Dimensions.height(40)),
                  child: CustomIconButton(
                    icon: const Icon(Icons.more_vert),
                    function: () {
                      changeVisibleButtonsList();
                    },
                  ),
                ),
                visibleButtonsList
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width(10)),
                        height: Dimensions.height(220),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.size30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 10,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(
                            right: Dimensions.width(20),
                            bottom: Dimensions.height(410)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width(5),
                                vertical: Dimensions.height(5),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30)),
                              child: TextButton(
                                onPressed: () {
                                  var docData =
                                      snapshot.data!.docs[widget.userIndex]
                                          ['box${widget.index + 1}'];
                                  for (int i = 1; i < 8; i++) {
                                    docData['weeks']['week$i']
                                        .update('data', (value) => []);
                                  }
                                  snapshot
                                      .data!.docs[widget.userIndex].reference
                                      .update(
                                          {'box${widget.index + 1}': docData});
                                },
                                child: TitleText(
                                  text: "Clear All",
                                  fontSize: Dimensions.size(20),
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width(5),
                                vertical: Dimensions.height(5),
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: Dimensions.height(5),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30)),
                              child: TextButton(
                                onPressed: () {
                                  bool newOpen = !dataMap['open'];
                                  var docData =
                                      snapshot.data!.docs[widget.userIndex]
                                          ['box${widget.index + 1}'];
                                  docData.update('open', (value) => newOpen);
                                  snapshot
                                      .data!.docs[widget.userIndex].reference
                                      .update(
                                          {'box${widget.index + 1}': docData});
                                },
                                child: TitleText(
                                  text: "Open Box",
                                  fontSize: Dimensions.size(20),
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width(5),
                                vertical: Dimensions.height(5),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.size30)),
                              child: TextButton(
                                onPressed: () {
                                  bool newClose = !dataMap['close'];
                                  var docData =
                                      snapshot.data!.docs[widget.userIndex]
                                          ['box${widget.index + 1}'];
                                  docData.update('close', (value) => newClose);
                                  snapshot
                                      .data!.docs[widget.userIndex].reference
                                      .update(
                                          {'box${widget.index + 1}': docData});
                                },
                                child: TitleText(
                                  text: "Close Box",
                                  fontSize: Dimensions.size(20),
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
  }
}
