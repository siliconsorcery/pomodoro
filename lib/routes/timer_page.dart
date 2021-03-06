import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro.dart';

/// The timer page is responsible for showing how much time is left in the
/// current pomodoro service.
class TimerPage extends Page {
  final PomodoroStage currentStage;

  TimerPage(this.currentStage) : super(key: ValueKey(currentStage));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        return TimerSection(currentStage);
      },
    );
  }
}

class TimerSection extends StatefulWidget {
  final PomodoroStage currentStage;

  TimerSection(this.currentStage, {Key? key}) : super(key: key);

  @override
  _TimerSectionState createState() => _TimerSectionState();
}

class _TimerSectionState extends State<TimerSection> {
  @override
  Widget build(BuildContext context) {
    String message;

    switch (widget.currentStage) {
      case PomodoroStage.work:
        message = "Work!";
        break;
      case PomodoroStage.shortBreak:
        message = "Short Break!";
        break;
      case PomodoroStage.longBreak:
        message = "Long Break!";
        break;
    }

    return Center(child: Text(message));
  }
}
