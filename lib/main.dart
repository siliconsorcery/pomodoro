import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/pomodoro/pomodoro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
  doWhenWindowReady(() {
    final initialSize = Size(500, 400);
    appWindow.minSize = initialSize;
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: PomodoroPage(),
    );
  }
}
