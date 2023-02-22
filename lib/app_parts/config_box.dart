import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app_parts/Alarm_form.dart';
import 'package:untitled/custom_widjets/custom_texts/title_text.dart';
import 'package:untitled/helpers/dimensions.dart';
import 'package:untitled/app_parts/time_box.dart';
import '../helpers/day_icon.dart';

// ignore: must_be_immutable
class ConfigBox extends StatelessWidget {
  final int index;
  final int dayIndex;
  final int userIndex;

  ConfigBox(
      {Key? key,
      required this.index,
      required this.dayIndex,
      required this.userIndex})
      : super(key: key);

  late final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    TextEditingController hourController = TextEditingController();
    TextEditingController minuteController = TextEditingController();
    TextEditingController doseController = TextEditingController();

    List days = ['Mon', 'Tus', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
          final dataMap = snapshot.data!.docs[userIndex]['box${index + 1}']
              ['weeks']['week${dayIndex + 1}'];
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.height(0),
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    bool newState = !dataMap['state'];
                    var docData =
                        snapshot.data!.docs[userIndex]['box${index + 1}'];
                    docData['weeks']['week${dayIndex + 1}']
                        .update('state', (value) => newState);
                    snapshot.data!.docs[userIndex].reference
                        .update({'box${index + 1}': docData});
                  },
                  child: DayIcon(
                    color: dataMap['state'] ? Colors.blue : Colors.grey,
                    text: days[dayIndex],
                  ),
                ),
                SizedBox(
                  width: Dimensions.width(5),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Dimensions.width(225),
                  height: Dimensions.height(60),
                  child: dataMap['data'].length != 0
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            dataMap['data'].length,
                            (val) => TimeBox(
                              hour: dataMap['data'][val]['hour'],
                              minute: dataMap['data'][val]['minute'],
                              dose: dataMap['data'][val]['dose'],
                              index: index,
                              dayIndex: dayIndex,
                              alarmIndex: val,
                              snapshot: snapshot,
                              userIndex: userIndex,
                            ),
                          ),
                        )
                      : TitleText(
                          text: "Nothing added", fontSize: Dimensions.size(15)),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => AlarmForm(
                            hourController: hourController,
                            minuteController: minuteController,
                            doseController: doseController,
                            index: index,
                            dayIndex: dayIndex,
                            snapshot: snapshot,
                            userIndex: userIndex,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                    TextButton(
                      onPressed: () {
                        var docData =
                            snapshot.data!.docs[userIndex]['box${index + 1}'];
                        docData['weeks']['week${dayIndex + 1}']
                            .update('data', (value) => []);
                        snapshot.data!.docs[userIndex].reference
                            .update({'box${index + 1}': docData});
                      },
                      child: TitleText(
                        color: Colors.blue,
                        text: 'Clear',
                        fontSize: Dimensions.size(15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
