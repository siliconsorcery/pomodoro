import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';

final pomodoroServiceProvider =
    ChangeNotifierProvider((ref) => PomodoroService());

class PomodoroService extends ChangeNotifier {
  Timer? _timer;

  Pomodoro pomodoro = Pomodoro();

  void setPomodoroStage(PomodoroStage stage) {
    pomodoro.currentStage = stage;
    stopTimer();
    notifyListeners();
  }

  /// starts the pomodoro timer
  void startTimer() {
    notifyListeners();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (pomodoro.tick()) {
        timer.cancel();


        // TODO: determine which stage to move to
      }

      notifyListeners();
    });
  }

  /// stops the timer
  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  bool get timerRunning => _timer?.isActive ?? false;
}
