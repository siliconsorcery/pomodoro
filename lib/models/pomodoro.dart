/// The three stages of pomodoro: work, short break, and long break
enum PomodoroStage {
  work,
  shortBreak,
  longBreak,
}

/// Keeps track of which stage of the pomodoro we're in
class Pomodoro {
  PomodoroStage _currentStage = PomodoroStage.work;

  int _workMin = 25;
  int get workMin => _workMin;
  set workMin(int newMin) {
    _workMin = newMin;
    _calculateSecondsLeft();
  }

  int _shortBreakMin = 5;
  int get shortBreakMin => _shortBreakMin;
  set shortBreakMin(int newMin) {
    _shortBreakMin = newMin;
    _calculateSecondsLeft();
  }

  int _longBreakMin = 15;
  int get longBreakMin => _longBreakMin;
  set longBreakMin(int newMin) {
    _longBreakMin = newMin;
    _calculateSecondsLeft();
  }

  /// Number of seconds left until the timer is over
  late int _secondsLeft;

  Pomodoro() {
    _secondsLeft = workMin * 60;
  }

  int get secondsLeft => _secondsLeft;

  /// Tick the timer left in ths pomodoro down by one.
  /// Returns true if the time is over
  bool tick() {
    return (--_secondsLeft) == 0;
  }

  set currentStage(PomodoroStage newStage) {
    _currentStage = newStage;
    _calculateSecondsLeft();
  }

  /// The current stage of pomodoro
  PomodoroStage get currentStage => _currentStage;

  /// Calculates the number of seconds left the current stage
  void _calculateSecondsLeft() {
    switch (_currentStage) {
      case PomodoroStage.work:
        _secondsLeft = workMin * 60;
        break;
      case PomodoroStage.shortBreak:
        _secondsLeft = shortBreakMin * 60;
        break;
      case PomodoroStage.longBreak:
        _secondsLeft = longBreakMin * 60;
        break;
    }
  }
}
