import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';
import 'package:pomodoro/services/pomodoro_service/pomodoro_service.dart';
import 'package:pomodoro/util/extensions/num_extensions.dart';

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
    return Center(
      child: Consumer(
        builder: (context, watch, child) {
          var pomodoroService = watch(pomodoroServiceProvider);
          int secondsLeft = pomodoroService.pomodoro.secondsLeft;
          int minutes = secondsLeft ~/ 60;
          int seconds = secondsLeft % 60;

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "${minutes.toStringWithZeroPadding(2)}:${seconds.toStringWithZeroPadding(2)}",
                  style: Theme.of(context).primaryTextTheme.headline1!.merge(
                        TextStyle(
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                ),
              ),
              ElevatedButton(
                child: Text(pomodoroService.timerRunning ? "Stop" : "Start"),
                onPressed: () {
                  if (pomodoroService.timerRunning) {
                    pomodoroService.stopTimer();
                  } else {
                    pomodoroService.startTimer();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
