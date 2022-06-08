import 'package:apartment_management_system/MVVM/VIEW/service/my_services_booking.dart';
import 'package:apartment_management_system/MVVM/VIEW/service/services.dart';
import 'package:apartment_management_system/MVVM/VIEW/workPermit_my.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'announcement_create.dart';
import 'announcement_main.dart';
import 'complaint_main.dart';
import 'event/event_main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      switch (payload) {
        case 'announcement':
          {
            Get.to(() => AnnouncementPageMain());
          }
          break;
        case 'mycomplaint':
          {
            Get.to(() => MyComplaint());
          }
          break;
        case 'myservice':
          {
            Get.to(() => MyBooking());
          }
          break;
        case 'MyWorkPermit':
          {
            Get.to(() => MyWorkPermit());
          }
      }
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
