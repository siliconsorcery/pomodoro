import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/features/pomodoro/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pomodoroServiceProvider = ChangeNotifierProvider((ref) => PomodoroService());

class PomodoroService extends ChangeNotifier {
  Pomodoro pomodoro = Pomodoro();

  Timer? _timer;
  bool _isCountingDown = false;
  AudioPlayer _audioPlayer = AudioPlayer();
  DateTime _today = DateTime.now();
  List<double> _hours = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setStage(PomodoroStage stage) {
    pomodoro.setStage(stage);

    pauseTimer();
    notifyListeners();
  }

  List<double> get hours => _hours;

  void logTime({int seconds = 1}) {
    final hour = DateTime.now().hour;
    _hours[hour] += seconds / 3600;
    notifyListeners();
  }

  void playAudio(String asset) async {
    await _audioPlayer.play(AssetSource(asset));
  }

  // q` feat: startTimer
  void startTimer() {
    _dayChangeResetHours();
    _isCountingDown = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      // Add one second to the hourly running totals
      logTime();

      // Are we finished?
      if (pomodoro.tick()) {
        timer.cancel();
        _isCountingDown = false;

        // q` feat: Sound the alarm
        switch (pomodoro.stage) {
          case PomodoroStage.rest:
            playAudio('mixkit-cinematic-tribal-flute-2306.wav');
            break;
          case PomodoroStage.work:
            playAudio('mixkit-cinematic-trailer-apocalypse-horn-724.wav');
            break;
          case PomodoroStage.play:
            playAudio('mixkit-eerie-trailer-horn-transition-2291.wav');
            break;
        }

        // q` Advance to next stage
        switch (pomodoro.stage) {
          case PomodoroStage.rest:
            setStage(PomodoroStage.work);
            break;
          case PomodoroStage.work:
            setStage(PomodoroStage.rest);
            break;
          case PomodoroStage.play:
            setStage(PomodoroStage.work);
            break;
        }
      }

      notifyListeners();
    });
  }

  // q` feat: pauseTimer
  void pauseTimer() {
    _dayChangeResetHours();
    _isCountingDown = false;
    _timer?.cancel();
    notifyListeners();
  }

  // q` feat: isTimerRunning
  bool get isTimerRunning => _timer?.isActive ?? false;

  // q` feat: stage
  PomodoroStage get stage => pomodoro.stage;

  // q` feat: setTimeForStage
  // Set the default countdown timer for the given stage
  void setTimeForStage({
    required PomodoroStage stage,
    required int seconds,
  }) async {
    final SharedPreferences prefs = await _prefs;
    final _seconds = seconds.clamp(1 * 60, 2 * 60 * 60);
    if (_isCountingDown == false) {
      switch (stage) {
        case PomodoroStage.rest:
          prefs.setInt('restCountDownDefault', _seconds);
          break;
        case PomodoroStage.work:
          prefs.setInt('workCountDownDefault', _seconds);
          break;
        case PomodoroStage.play:
          prefs.setInt('playCountDownDefault', _seconds);
          break;
      }
    }
    // pauseTimer();
    notifyListeners();
  }

  // q` Get from user preferences default countdown timer for the given stage
  Future<int> getTimeForStage({required PomodoroStage stage}) async {
    final SharedPreferences prefs = await _prefs;
    _dayChangeResetHours();
    switch (stage) {
      case PomodoroStage.rest:
        return prefs.getInt('restCountDownDefault') ?? 5 * 60;
      case PomodoroStage.work:
        return prefs.getInt('workCountDownDefault') ?? 25 * 60;
      case PomodoroStage.play:
        return prefs.getInt('playCountDownDefault') ?? 60 * 60;
    }
  }

  // q` feat: setCountDown
  void setCountDown({
    required PomodoroStage stage,
    required int seconds,
  }) async {
    _dayChangeResetHours();
    pomodoro.secondsLeft = seconds;
    notifyListeners();

    setTimeForStage(stage: stage, seconds: seconds);
  }

  // Reset the hourly running totals at midnight
  void _dayChangeResetHours() {
    final now = DateTime.now();
    if (_today.day == now.day && _today.month == now.month && _today.year == now.year) {
      return;
    } else {
      _today = now;
      _hours = [
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0
      ];
    }
  }
}
