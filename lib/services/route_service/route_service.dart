import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/models/pomodoro.dart';
import 'package:pomodoro/services/pomodoro_service/pomodoro_service.dart';

final routeServiceProvider = ChangeNotifierProvider(
    (ref) => RouteService(ref.read(pomodoroServiceProvider)));

/// Service for handling changing routes
class RouteService extends ChangeNotifier {
  final PomodoroService pomodoroService;

  RouteService(this.pomodoroService);

  void updateRoute(PomodoroStage newStage) {
    if (newStage != currentStage) {
      pomodoroService.setPomodoroStage(newStage);
      notifyListeners();
    }
  }

  PomodoroStage get currentStage => pomodoroService.pomodoro.currentStage;
}
