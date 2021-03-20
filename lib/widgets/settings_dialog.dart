import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/models/pomodoro.dart';
import 'package:pomodoro/services/pomodoro_service/pomodoro_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsDialog extends StatefulWidget {
  SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  TextEditingController _workController = TextEditingController();
  TextEditingController _shortBreakController = TextEditingController();
  TextEditingController _longBreakController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var ps = context.read(pomodoroServiceProvider);

    String workTime = ps.pomodoro.workMin.toString();
    String shortBreakTime = ps.pomodoro.shortBreakMin.toString();
    String longBreakTime = ps.pomodoro.longBreakMin.toString();

    _workController.value = TextEditingValue(
      text: workTime,
      selection: TextSelection.collapsed(offset: workTime.length),
    );
    _shortBreakController.value = TextEditingValue(
      text: shortBreakTime,
      selection: TextSelection.collapsed(offset: shortBreakTime.length),
    );
    _longBreakController.value = TextEditingValue(
      text: longBreakTime,
      selection: TextSelection.collapsed(offset: longBreakTime.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Settings"),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      content: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: [
            Text("Time"),
            Row(
              children: [
                Flexible(
                  child: SimpleDialogOption(
                    child: _NumericInput(
                      label: "Work",
                      controller: _workController,
                      valueChanged: (min) {
                        context.read(pomodoroServiceProvider).setTimeForStage(
                              stage: PomodoroStage.work,
                              minutes: min,
                            );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: SimpleDialogOption(
                    child: _NumericInput(
                      label: "Short Break",
                      controller: _shortBreakController,
                      valueChanged: (min) {
                        context.read(pomodoroServiceProvider).setTimeForStage(
                              stage: PomodoroStage.shortBreak,
                              minutes: min,
                            );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: SimpleDialogOption(
                    child: _NumericInput(
                      label: "Long Break",
                      controller: _longBreakController,
                      valueChanged: (min) {
                        context.read(pomodoroServiceProvider).setTimeForStage(
                              stage: PomodoroStage.longBreak,
                              minutes: min,
                            );
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NumericInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(int) valueChanged;

  _NumericInput(
      {required this.controller,
      required this.label,
      required this.valueChanged,
      Key? key})
      : super(key: key);

  @override
  _NumericInputState createState() => _NumericInputState();
}

class _NumericInputState extends State<_NumericInput> {
  String _enteredText = "";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(
                  Size(constraints.maxWidth, double.infinity),
                ),
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      return;
                    }

                    // If the entered value isn't a number,
                    if (int.tryParse(value) == null) {
                      setState(() {
                        widget.controller.value = TextEditingValue(
                          text: _enteredText,
                          selection: TextSelection.collapsed(
                              offset: _enteredText.length),
                        );
                      });
                    }

                    // It's a number, update tell our parent
                    else {
                      widget.valueChanged(int.parse(value));
                      setState(() {
                        _enteredText = value;
                      });
                    }
                  },
                ),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    var incrementVal =
                        (int.parse((widget.controller.text)) + 1).toString();

                    setState(() {
                      _enteredText = incrementVal;
                      widget.controller.value = TextEditingValue(
                        text: _enteredText,
                        selection: TextSelection.collapsed(
                          offset: _enteredText.length,
                        ),
                      );
                    });
                    widget.valueChanged(int.parse(incrementVal));
                  },
                  child: Icon(Icons.keyboard_arrow_up),
                ),
                InkWell(
                  onTap: () {
                    var decrementVal =
                        (max(1, int.parse((widget.controller.text)) - 1))
                            .toString();

                    setState(() {
                      _enteredText = decrementVal;
                      widget.controller.value = TextEditingValue(
                        text: _enteredText,
                        selection: TextSelection.collapsed(
                          offset: _enteredText.length,
                        ),
                      );
                    });

                    widget.valueChanged(int.parse(decrementVal));
                  },
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
