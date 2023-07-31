import 'dart:async';

import 'package:notification/controllers/notification_controller.dart';
import 'package:notification/webService/login.dart';

class MinuteTimer {
  Timer? _timer;
  Timer? _timerh;
  int time = 0;

  void startTimer() async {
    saveToSession('timer', 'start');
    bool test;
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
      var id = await getFromSession("id");
      var timestop = await getFromSession("timer");
      if ((id != null) && (timestop != 'stop')) {
        test = await NotificationController().fgetNotification();
        print(test);
      } else {
        print('the stopping of the timer');
        stopTimer();
      }
    });
  }

//timer du rappel des réunions :
  void secondtimer() async {
    saveToSession('timer2', 'start');
    bool test;
    _timerh = Timer.periodic(const Duration(seconds: 40), (timer) async {
      var id = await getFromSession("id");
      var timestop = await getFromSession("timer2");
      if ((id != null) && (timestop != 'stop')) {
        print('timer 2 is on');
        test = await NotificationController().fMeetReminder();
        print(test);
      } else {
        print('the stopping of the timer');
        stopTimer();
      }
    });
  }

  void stopTimerh() {
    if (_timerh != null && _timerh!.isActive) {
      _timerh!.cancel();
    }
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
