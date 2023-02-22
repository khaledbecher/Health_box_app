import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';
import '../custom_widjets/custom_texts/title_text.dart';
import '../helpers/dimensions.dart';

class TitleForm extends StatelessWidget {
  final TextEditingController titleController;
  final int userIndex;
  final int index;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const TitleForm(
      {Key? key,
      required this.index,
      required this.titleController,
      required this.snapshot,
      required this.userIndex})
      : super(key: key);

  void changeTitle(String newTitle, AsyncSnapshot<QuerySnapshot> snapshot) {
    var data = snapshot.data!.docs[userIndex]['box${index + 1}'];
    var dataToUpdate = data;
    dataToUpdate.update('title', (value) => newTitle);
    var toReplace = dataToUpdate;
    snapshot.data!.docs[userIndex].reference
        .update({'box${index + 1}': toReplace});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(Dimensions.size8),
        height: Dimensions.height(220),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height(20),
                ),
                TimeText(
                  text: "New medicament",
                  fontSize: Dimensions.size(18),
                ),
                SizedBox(
                  width: Dimensions.width(250),
                  child: TextFormField(
                    maxLength: 30,
                    decoration: const InputDecoration(counterText: ''),
                    controller: titleController,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height(40),
                ),
                TextButton(
                  onPressed: () {
                    changeTitle(titleController.text, snapshot);
                    Navigator.pop(context);
                    titleController.clear();
                  },
                  child: TitleText(
                    text: "Save",
                    fontSize: Dimensions.size(22),
                    color: Colors.teal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
