import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/features/pomodoro/models.dart';
import 'package:pomodoro/features/pomodoro/services.dart';

final audioPlayer = AudioPlayer();

class PomodoroPage extends ConsumerWidget {
  PomodoroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final stage = watch(pomodoroServiceProvider).currentStage;
    final baseColor = () {
      switch (stage) {
        case PomodoroStage.work:
          return Colors.green;
        case PomodoroStage.shortBreak:
          return Colors.amber.shade800;
        case PomodoroStage.longBreak:
          return Colors.blue;
      }
    }();
    return Material(
      color: baseColor,
      child: Column(
        children: [
          _topBar(context),
          _content(context, stage),
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 8.0, 4.0),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
          Text(
            "Pomodoro",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
          Spacer(),
          // InkWell(
          //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
          //   onTap: () async {
          //     await showDialog(
          //       context: context,
          //       builder: (context) {
          //         return SettingsDialog();
          //       },
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Icon(
          //       Icons.settings,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context, PomodoroStage stage) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(64),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Align(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StageSelection(PomodoroStage.work),
                        _StageSelection(PomodoroStage.shortBreak),
                        _StageSelection(PomodoroStage.longBreak),
                      ],
                    ),
                  ),
                  TimerWidget(stage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StageSelection extends ConsumerWidget {
  final PomodoroStage stage;
  const _StageSelection(this.stage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    String message;
    var service = watch(pomodoroServiceProvider);
    PomodoroStage currentStage = service.currentStage;

    switch (stage) {
      case PomodoroStage.work:
        message = "Pomodoro";
        break;
      case PomodoroStage.shortBreak:
        message = "Short Break";
        break;
      case PomodoroStage.longBreak:
        message = "Long Break";
        break;
    }

    BoxDecoration decoration = () {
      if (stage == currentStage) {
        return BoxDecoration(
          color: Colors.black.withAlpha(40),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        );
      }
      return BoxDecoration();
    }();

    return InkWell(
      onTap: () {
        service.playAudio('mixkit-tech-click-1140.wav');
        context.read(pomodoroServiceProvider).setPomodoroStage(stage);
      },
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            message,
            style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

final theme = ThemeData(
  appBarTheme: AppBarTheme(color: Color(0xFF33691e)),
  scaffoldBackgroundColor: Color(0xFFf44336),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFef5350),
      textStyle: TextStyle(
          fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none, fontSize: 56),
      padding: const EdgeInsets.all(32),
    ),
  ),
  fontFamily: "Roboto",
  primaryTextTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Segoe UI',
      inherit: true,
      color: Colors.black,
      decoration: TextDecoration.none,
    ),
    displayMedium:
        TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    displaySmall:
        TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    headlineMedium:
        TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    headlineSmall:
        TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    titleLarge: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    bodyLarge: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    bodyMedium: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    titleMedium: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    titleSmall: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    bodySmall: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    labelLarge: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
    labelSmall: TextStyle(fontFamily: 'Segoe UI', inherit: true, color: Colors.black, decoration: TextDecoration.none),
  ),
  textTheme: Typography.material2018().englishLike,
);

class TimerWidget extends StatefulWidget {
  final PomodoroStage stage;

  TimerWidget(this.stage, {Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  double dragSecondsLeft = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, watch, child) {
          var service = watch(pomodoroServiceProvider);
          final stage = service.pomodoro.currentStage;
          final secondsLeft = service.pomodoro.secondsLeft;
          final minutes = (secondsLeft ~/ 60).toStringWithZeroPadding(2);
          final seconds = (secondsLeft % 60).toStringWithZeroPadding(2);
          final timeStyle = Theme.of(context).primaryTextTheme.displayLarge!.merge(
                TextStyle(
                  fontFeatures: [FontFeature.tabularFigures()],
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              );
          final baseColor = () {
            switch (stage) {
              case PomodoroStage.work:
                return Colors.green;
              case PomodoroStage.shortBreak:
                return Colors.amber.shade800;
              case PomodoroStage.longBreak:
                return Colors.blue;
            }
          }();

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Countdown
              GestureDetector(
                onHorizontalDragStart: (details) {
                  setState(() {
                    dragSecondsLeft = service.pomodoro.secondsLeft.toDouble();
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    dragSecondsLeft += details.delta.dx;
                  });
                  final seconds = max(0, dragSecondsLeft.toInt());
                  context.read(pomodoroServiceProvider).setTimeSeconds(seconds: seconds);
                },
                onTap: () {
                  final seconds = service.pomodoro.secondsLeft + 60;
                  context.read(pomodoroServiceProvider).setTimeSeconds(seconds: seconds);
                },
                child: Center(
                  child: Text(
                    "$minutes:$seconds",
                    style: timeStyle,
                  ),
                ),
              ),
              // Pause/Start button
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  onTap: () {
                    service.playAudio('mixkit-tech-click-1140.wav');
                    if (service.isTimerRunning) {
                      service.pauseTimer();
                    } else {
                      service.startTimer();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 56.0,
                      width: 220.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            service.isTimerRunning ? "PAUSE" : "START",
                            style: Theme.of(context).primaryTextTheme.headlineSmall!.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: baseColor,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension NumExtensions on num {
  /// Returns this number as a string, padding it with leading 0s to make sure
  /// its at least [numDigits] long
  String toStringWithZeroPadding(int numDigits) {
    String leading0s = "";
    // int digitCounter =
    for (int i = numDigits - 1; i > 0; i--) {
      var digit = pow(10, i);

      if (this < digit) {
        leading0s += "0";
      } else {
        break;
      }
    }
    return "$leading0s$this";
  }
}
