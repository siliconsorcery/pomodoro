// q` docs: PomodoroStage
import 'package:shared_preferences/shared_preferences.dart';

/// The three stages of pomodoro: work, short break, and long break
enum PomodoroStage {
  work,
  rest,
  play,
}

// q` docs: Pomodoro
/// Keeps track of which stage of the pomodoro we're in
class Pomodoro {
  late PomodoroStage _stage;
  late int _secondsLeft;

  Pomodoro() {
    _stage = PomodoroStage.work;
    _secondsLeft = 25 * 60;
  }

  int get secondsLeft => _secondsLeft;
  set secondsLeft(int seconds) {
    _secondsLeft = seconds;
  }

  /// Tick the timer left in ths pomodoro down by one.
  /// Returns true if the time is over
  bool tick() {
    return (--_secondsLeft) == 0;
  }

  /// The current stage of pomodoro
  PomodoroStage get stage => _stage;

  void setStage(PomodoroStage newStage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _stage = newStage;
    switch (_stage) {
      case PomodoroStage.rest:
        final restCountDownDefault = prefs.getInt('restCountDownDefault') ?? 5 * 60;
        _secondsLeft = restCountDownDefault;
        break;
      case PomodoroStage.work:
        final workCountDownDefault = prefs.getInt('workCountDownDefault') ?? 25 * 60;
        _secondsLeft = workCountDownDefault;
        break;
      case PomodoroStage.play:
        final playCountDownDefault = prefs.getInt('playCountDownDefault') ?? 60 * 60;
        _secondsLeft = playCountDownDefault;
        break;
    }
  }
}
