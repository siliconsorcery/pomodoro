import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/features/pomodoro/models.dart';

final pomodoroServiceProvider = ChangeNotifierProvider((ref) => PomodoroService());

class PomodoroService extends ChangeNotifier {
  Timer? _timer;
  AudioPlayer _audioPlayer = AudioPlayer();

  Pomodoro pomodoro = Pomodoro();

  void setPomodoroStage(PomodoroStage stage) {
    pomodoro.currentStage = stage;
    pauseTimer();
    notifyListeners();
  }

  void playAudio(String asset) async {
    await _audioPlayer.play(AssetSource(asset));
  }

  // q` startTimer
  void startTimer() {
    notifyListeners();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (pomodoro.tick()) {
        timer.cancel();

        // q` Sound the alarm.
        switch (pomodoro.currentStage) {
          case PomodoroStage.work:
            playAudio('mixkit-cinematic-tribal-flute-2306.wav');
            // () async {
            //   await _audioPlayer.play(AssetSource('mixkit-cinematic-tribal-flute-2306.wav'));
            //   Log.info("Finish Work");
            // }();
            break;
          case PomodoroStage.shortBreak:
            playAudio('mixkit-cinematic-trailer-apocalypse-horn-724.wav');
            // () async {
            //   await _audioPlayer.play(AssetSource('mixkit-cinematic-trailer-apocalypse-horn-724.wav'));
            //   Log.info("Finish Short Break");
            // }();
            break;
          case PomodoroStage.longBreak:
            playAudio('mixkit-eerie-trailer-horn-transition-2291.wav');
            // () async {
            //   await _audioPlayer.play(AssetSource('mixkit-eerie-trailer-horn-transition-2291.wav'));
            //   Log.info("Finish Long Break");
            // }();
            break;
        }

        // audioPlayer.play(
        //   DeviceFileSource('assets/mixkit-epic-orchestra-transition-2290.wav'),
        // );

        switch (pomodoro.currentStage) {
          case PomodoroStage.work:
            setPomodoroStage(PomodoroStage.shortBreak);
            break;
          case PomodoroStage.shortBreak:
            setPomodoroStage(PomodoroStage.work);
            break;
          case PomodoroStage.longBreak:
            setPomodoroStage(PomodoroStage.work);
            break;
        }
      }

      notifyListeners();
    });
  }

  /// q` pauseTimer
  void pauseTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  bool get isTimerRunning => _timer?.isActive ?? false;

  PomodoroStage get currentStage => pomodoro.currentStage;

  /// Configures the time for the given stage. This will reset the timer
  void setTimeForStage({required PomodoroStage stage, required int minutes}) {
    switch (stage) {
      case PomodoroStage.work:
        pomodoro.workMin = minutes;
        break;
      case PomodoroStage.shortBreak:
        pomodoro.shortBreakMin = minutes;
        break;
      case PomodoroStage.longBreak:
        pomodoro.longBreakMin = minutes;
        break;
    }

    pauseTimer();
    notifyListeners();
  }

  void setTimeSeconds({
    required int seconds,
  }) {
    pomodoro.secondsLeft = seconds;
    notifyListeners();
  }
}
