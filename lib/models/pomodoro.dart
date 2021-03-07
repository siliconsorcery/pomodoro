/// The three stages of pomodoro: work, short break, and long break
enum PomodoroStage {
  work,
  shortBreak,
  longBreak,
}

/// Keeps track of which stage of the pomodoro we're in
class Pomodoro {
  PomodoroStage _currentStage = PomodoroStage.work;

  /// Number of seconds left until the timer is over
  /// TODO: read the 25 from somewhere
  int _secondsLeft = 25 * 60;

  int get secondsLeft => _secondsLeft;

  /// Tick the timer left in ths pomodoro down by one.
  /// Returns true if the time is over
  bool tick() {
    return (--_secondsLeft) == 0;
  }

  Pomodoro();

  set currentStage(PomodoroStage newStage) {
    _currentStage = newStage;

    switch (_currentStage) {
      case PomodoroStage.work:
        _secondsLeft = 25 * 60;
        break;
      case PomodoroStage.shortBreak:
        _secondsLeft = 5 * 60;
        break;
      case PomodoroStage.longBreak:
        _secondsLeft = 15 * 60;
        break;
    }
  }

  /// The current stage of pomodoro
  PomodoroStage get currentStage => _currentStage;
}
