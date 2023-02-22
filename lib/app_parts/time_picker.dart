import 'package:flutter/material.dart';
import 'package:untitled/custom_widjets/custom_buttons/select_time_button.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';

import '../helpers/dimensions.dart';

class TimePicker extends StatefulWidget {
  final TextEditingController hourController;
  final TextEditingController minuteController;

  const TimePicker({
    Key? key,
    required this.hourController,
    required this.minuteController,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late bool timeSelected;
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 0);

  @override
  // ignore: must_call_super
  void initState() {
    timeSelected = false;
    time = const TimeOfDay(hour: 12, minute: 0);
  }

  void _showTimePicker(BuildContext context) async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (newTime == null) return;

    widget.hourController.text = newTime.hour.toString().padLeft(2, '0');
    widget.minuteController.text = newTime.minute.toString().padLeft(2, '0');
    setState(() {
      timeSelected = true;
      time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SelectTimeButton(
          text: "Select time",
          onPressed: () {
            _showTimePicker(context);
          },
          width: Dimensions.width(120),
          height: Dimensions.height(50),
        ),
        SizedBox(
          width: Dimensions.width(5),
        ),
        TimeText(
          text: timeSelected
              ? "${time.hour.toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')}"
              : "Time is not selected",
          fontSize: Dimensions.size(15),
          color: timeSelected ? Colors.blueGrey : Colors.red,
        )
      ],
    );
  }
}
