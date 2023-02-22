import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';
import 'package:untitled/helpers/dimensions.dart';

class TimeBox extends StatelessWidget {
  final String hour;
  final String minute;
  final String dose;
  final int index;
  final int dayIndex;
  final int alarmIndex;
  final int userIndex;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const TimeBox(
      {Key? key,
      required this.hour,
      required this.minute,
      required this.dose,
      required this.index,
      required this.dayIndex,
      required this.alarmIndex,
      required this.snapshot,
      required this.userIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width(8),
          ),
          padding: EdgeInsets.all(Dimensions.size(12)),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 1,
                    color: Colors.grey[400]!),
              ],
              color: Colors.blue,
              borderRadius: BorderRadius.circular(Dimensions.size30)),
          alignment: Alignment.center,
          child: Column(
            children: [
              TimeText(
                text: "$hour : $minute",
                fontSize: Dimensions.size(15),
                color: Colors.white,
              ),
              TimeText(
                text: dose,
                fontSize: Dimensions.size(15),
                color: Colors.white,
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                SizedBox(
                  width: Dimensions.width(68),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.size30)),
                  margin: EdgeInsets.only(
                    bottom: Dimensions.height(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var docData =
                          snapshot.data!.docs[userIndex]['box${index + 1}'];
                      List toReplace =
                          docData['weeks']['week${dayIndex + 1}']['data'];
                      toReplace.removeAt(alarmIndex);
                      docData['weeks']['week${dayIndex + 1}']
                          .update('data', (value) => toReplace);
                      snapshot.data!.docs[userIndex].reference
                          .update({'box${index + 1}': docData});
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
