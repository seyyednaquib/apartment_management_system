import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'announcement_create.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      if (payload == 'announcement') Get.to(() => Announcement());
    });
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    final notifDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.example.apartment_management_system",
            "apartment_management_system",
            playSound: true,
            sound: RawResourceAndroidNotificationSound('mixkit'),
            importance: Importance.max,
            priority: Priority.high));
    _notificationsPlugin.show(DateTime.now().microsecond,
        message.notification!.title, message.notification!.body, notifDetails,
        payload: message.data['route']);
  }
}
