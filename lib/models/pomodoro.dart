import 'dart:async';

/// The three stages of pomodoro: work, short break, and long break
enum PomodoroStage {
  work,
  shortBreak,
  longBreak,
}

/// Keeps track of which stage of the pomodoro we're in
class Pomodoro {
  Timer? t;

  PomodoroStage _currentStage = PomodoroStage.work;

  /// Number of seconds left until the timer is over
  /// TODO: read the 25 from somewhere
  int _secondsLeft = 25 * 60;

  int get secondsLeft => _secondsLeft;

  Pomodoro();

  set currentStage(PomodoroStage newStage) {
    _currentStage = newStage;
    _secondsLeft = 25 * 60;
  }

  /// The current stage of pomodoro
  PomodoroStage get currentStage => _currentStage;
}
