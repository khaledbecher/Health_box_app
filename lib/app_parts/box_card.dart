import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/helpers/dimensions.dart';
import 'package:untitled/pages/configuration_page.dart';
import '../custom_widjets/custom_texts/title_text.dart';
import 'Title_form.dart';

// ignore: must_be_immutable
class BoxCard extends StatelessWidget {
  final int index;
  final String userUid;

  BoxCard({Key? key, required this.index, required this.userUid})
      : super(key: key);
  late final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return StreamBuilder(
        stream: _dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.maxFinite,
              height: Dimensions.height100 * 0.97,
              padding: EdgeInsets.fromLTRB(Dimensions.width(8), 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height(30),
                    width: Dimensions.width(30),
                    child: const CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
          var userIndex = snapshot.data!.docs
              .indexWhere((element) => element['uid'] == userUid);
          var data = snapshot.data!.docs[userIndex]['box${index + 1}'];
          return Card(
            elevation: Dimensions.height(5),
            child: Stack(
              children: [
                Container(
                  height: Dimensions.height100 * 0.97,
                  padding: EdgeInsets.fromLTRB(Dimensions.width(8), 0, 0, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width(60),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Dimensions.width(220),
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => TitleForm(
                                      index: index,
                                      titleController: titleController,
                                      snapshot: snapshot,
                                      userIndex: userIndex,
                                    ));
                          },
                          child: TitleText(
                            text: data['title'].toString(),
                            fontSize: Dimensions.size(22),
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Switch(
                            value: data['state'],
                            onChanged: (onChanged) {
                              var dataToUpdate = data;
                              dataToUpdate.update(
                                  'state', (value) => !data['state']);
                              var toReplace = dataToUpdate;
                              snapshot.data!.docs[userIndex].reference
                                  .update({'box${index + 1}': toReplace});
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfigurationPage(
                                            userIndex: userIndex,
                                            index: index,
                                            title: data['title'].toString())));
                              },
                              icon: const Icon(Icons.settings))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: Dimensions.height100 * 0.97,
                  width: Dimensions.width(100),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width(5),
                      vertical: Dimensions.height(3)),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          Dimensions.size30,
                        ),
                        bottomRight: Radius.circular(
                          Dimensions.size30,
                        )),
                  ),
                  child: TitleText(
                    text: "Box${index + 1}",
                    fontSize: Dimensions.size(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
