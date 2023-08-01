import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:notification/controllers/notification_controller.dart';
import 'package:notification/pages/connexion.dart';
import 'package:notification/webService/login.dart';

void handleMessageA(RemoteMessage message) async {
  var id = await getFromSession("id");
  if (id.toString() != 'null') {
    NotificationController().fgetremoteDetails();
  } else {
    Get.to(() => const Connexion());
  }
}

Future<void> handleBackgroungMessage(RemoteMessage message) async {
  print(
      'Title : ${message.notification?.title} Body : ${message.notification?.body} Payload : ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  void handleMessage(RemoteMessage? message) {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (message == null) return;
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageA);
    FirebaseMessaging.onBackgroundMessage(handleBackgroungMessage);
  }

  Future<void> initNotification() async {
    // await _firebaseMessaging.requestPermission;
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fCMTocken = await _firebaseMessaging.getToken();
    saveToSession('token', fCMTocken);
    // print(fCMTocken);
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroungMessage);
    initPushNotifications();
  }

  tokeninitialize() async {
    String? fCMTocken = await _firebaseMessaging.getToken();
    // print(fCMTocken);
    saveToSession('token', fCMTocken);
  }
}
