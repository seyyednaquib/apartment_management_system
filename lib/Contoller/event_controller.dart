import 'dart:io';

import 'package:apartment_management_system/Model/event.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<EventModel>> getEventStream() {
    final eventStream = _db.child('events/').orderByKey().onValue;
    final streamToPublish = eventStream.map((event) {
      final eventMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final eventList = eventMap.entries.map((e) {
        return EventModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return eventList;
    });
    return streamToPublish;
  }

  Stream<List<EventModel>> getEventStreamForHome() {
    final eventStream =
        _db.child('events/').orderByKey().limitToLast(3).onValue;
    final streamToPublish = eventStream.map((event) {
      final eventMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final eventList = eventMap.entries.map((e) {
        return EventModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return eventList;
    });
    return streamToPublish;
  }

  Future<void> addEvent(
      String content, String title, String ImgUrl, String dateAndTime) async {
    if (ImgUrl == '') {
      ImgUrl =
          'https://www.kindpng.com/picc/m/421-4219807_news-events-icon-event-logo-png-transparent-png.png';
    }

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      await _db.child('events/').push().set({
        'title': title,
        'content': content,
        'dateAndTime': dateAndTime,
        'dateCreated': formattedDate,
        'ImgUrl': ImgUrl
      }).then((_) =>
          Get.snackbar("UPLOADED", title, snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
