import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';
import 'package:pomodoro/routes/timer_page.dart';
import 'package:pomodoro/theme/theme.dart';
import 'package:pomodoro/widgets/settings_dialog.dart';

import 'services/pomodoro_service/pomodoro_service.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro!',
      theme: theme,
      debugShowCheckedModeBanner: false,
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
        actions: [
          IconButton(
            tooltip: "Restart Pomodoro",
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Settings",
            icon: Icon(Icons.settings),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return SettingsDialog();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: (MediaQuery.of(context).size.height * .25) / 2,
          horizontal: (MediaQuery.of(context).size.width * .25) / 2,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var stage in PomodoroStage.values)
                  Flexible(child: _StageSelection(stage))
              ],
            ),
            Flexible(
              child: Navigator(
                pages: [
                  TimerPage(watch(pomodoroServiceProvider).currentStage),
                ],
                onPopPage: (route, result) {
                  return true;
                },
              ),
            ),
          ],
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
    PomodoroStage currentStage = watch(pomodoroServiceProvider).currentStage;

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
        context.read(pomodoroServiceProvider).setPomodoroStage(stage);
      },
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message,
            style: Theme.of(context).primaryTextTheme.headline4,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
