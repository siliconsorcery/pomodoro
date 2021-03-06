import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';
import 'package:pomodoro/routes/timer_page.dart';
import 'package:pomodoro/services/route_service/route_service.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(
        title: "Pomodoro!",
      ),
    );
  }
}

class Wrapper extends ConsumerWidget {
  Wrapper({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StageSelection(PomodoroStage.work),
            StageSelection(PomodoroStage.shortBreak),
            StageSelection(PomodoroStage.longBreak),
          ],
        ),
      ),
      body: Navigator(
        pages: [
          TimerPage(watch(routeServiceProvider).currentStage),
        ],
        onPopPage: (route, result) {
          return true;
        },
      ),
    );
  }
}

class StageSelection extends ConsumerWidget {
  final PomodoroStage stage;
  const StageSelection(this.stage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    String message;
    PomodoroStage currentStage = watch(routeServiceProvider).currentStage;

    switch (stage) {
      case PomodoroStage.work:
        message = "Work";
        break;
      case PomodoroStage.shortBreak:
        message = "Short Break";
        break;
      case PomodoroStage.longBreak:
        message = "Long Break";
        break;
    }

    BoxDecoration? decoration;

    if (stage == currentStage) {
      decoration = BoxDecoration(
        color: Colors.white24,
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      );
    }

    return InkWell(
      onTap: () {
        context.read(routeServiceProvider).updateRoute(stage);
      },
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(message),
        ),
      ),
    );
  }
}
