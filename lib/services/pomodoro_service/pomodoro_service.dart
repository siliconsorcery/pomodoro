import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';

final pomodoroServiceProvider =
    ChangeNotifierProvider((ref) => PomodoroService());

class PomodoroService extends ChangeNotifier {
  Pomodoro pomodoro = Pomodoro();

  void setPomodoroStage(PomodoroStage stage) {
    pomodoro.currentStage = stage;
    notifyListeners();
  }
}
