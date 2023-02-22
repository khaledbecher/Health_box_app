import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app_parts/time_picker.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';
import '../custom_widjets/custom_texts/title_text.dart';
import '../helpers/dimensions.dart';

class AlarmForm extends StatefulWidget {
  final int index;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int userIndex;
  final int dayIndex;
  final TextEditingController hourController;
  final TextEditingController minuteController;
  final TextEditingController doseController;

  const AlarmForm(
      {Key? key,
      required this.hourController,
      required this.minuteController,
      required this.doseController,
      required this.index,
      required this.dayIndex,
      required this.snapshot,
      required this.userIndex})
      : super(key: key);

  @override
  State<AlarmForm> createState() => _AlarmFormState();
}

class _AlarmFormState extends State<AlarmForm> {
  bool allDays = false;

  void changeAllDays() {
    setState(() {
      allDays = !allDays;
    });
  }

  bool exists(List a, Map b) {
    List elementVariables = [b['dose'], b['hour'], b['minute']];
    bool condition = false;
    for (var element in a) {
      List variables = [element['dose'], element['hour'], element['minute']];
      if (elementVariables[0] == variables[0] &&
          elementVariables[1] == variables[1] &&
          elementVariables[2] == variables[2]) condition = true;
    }
    return condition;
  }

  void modifyData(
      AsyncSnapshot<QuerySnapshot> snapshot, Map element, int weekIndex) {
    var docData =
        snapshot.data!.docs[widget.userIndex]['box${widget.index + 1}'];
    List data = docData['weeks']['week${weekIndex + 1}']['data'];
    if (exists(data, element) == false) {
      data.add(element);
      docData['weeks']['week${weekIndex + 1}'].update('data', (value) => data);
      snapshot.data!.docs[widget.userIndex].reference
          .update({'box${widget.index + 1}': docData});
    }
  }

  void modifyDataAllDays(AsyncSnapshot<QuerySnapshot> snapshot, Map element) {
    var weeks = (snapshot.data!.docs[widget.userIndex]['box${widget.index + 1}']
            ['weeks'] as Map)
        .entries
        .map((e) => e.value)
        .toList();
    var weeksData = [];
    for (var element in weeks) {
      weeksData.add(element.entries.map((e) => e.value).toList()[0]);
    }
    for (var data in weeksData) {
      if (exists(data, element) == false) {
        data.add(element);
      }
    }
    var docData =
        snapshot.data!.docs[widget.userIndex]['box${widget.index + 1}'];
    for (int i = 0; i < 7; i++) {
      (docData['weeks']['week${i + 1}'] as Map)
          .update('data', (value) => weeksData[i]);
    }
    snapshot.data!.docs[widget.userIndex].reference
        .update({'box${widget.index + 1}': docData});
  }

  void addAlarm(
      String hour,
      String minute,
      String dose,
      AsyncSnapshot<QuerySnapshot> snapshot,
      BuildContext context,
      int weekIndex) {
    Map element = {'dose': dose, 'hour': hour, 'minute': minute};
    if (!allDays) {
      modifyData(snapshot, element, weekIndex);
    } else {
      modifyDataAllDays(snapshot, element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(Dimensions.size8),
        height: Dimensions.height(300),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height(8),
                ),
                TimePicker(
                    hourController: widget.hourController,
                    minuteController: widget.minuteController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TimeText(text: "all days", fontSize: Dimensions.size(15)),
                    Checkbox(
                        value: allDays,
                        onChanged: (_) {
                          changeAllDays();
                        })
                  ],
                ),
                SizedBox(
                  height: Dimensions.height(5),
                ),
                Row(
                  children: [
                    TitleText(text: 'Dose   ', fontSize: Dimensions.size30),
                    Container(
                      width: Dimensions.width(80),
                      margin: EdgeInsets.only(
                        right: Dimensions.width(80),
                      ),
                      child: TextFormField(
                        controller: widget.doseController,
                        maxLength: 15,
                        decoration: const InputDecoration(counterText: ''),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'fill this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (int.parse(widget.hourController.text) > 23 ||
                            int.parse(widget.hourController.text) < 0 ||
                            int.parse(widget.minuteController.text) > 59 ||
                            int.parse(widget.minuteController.text) < 0) {
                          return;
                        } else if (widget.hourController.text.length != 2 ||
                            widget.minuteController.text.length != 2) {
                          return;
                        } else {
                          addAlarm(
                              widget.hourController.text,
                              widget.minuteController.text,
                              widget.doseController.text,
                              widget.snapshot,
                              context,
                              widget.dayIndex);
                        }
                        widget.hourController.clear();
                        widget.minuteController.clear();
                        widget.doseController.clear();
                        Navigator.pop(context);
                      },
                      child: TitleText(
                        text: "Save",
                        fontSize: Dimensions.size(22),
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
