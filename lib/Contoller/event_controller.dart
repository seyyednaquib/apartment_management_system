import 'dart:io';

import 'package:apartment_management_system/Model/event.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<EventModel>> getEventStream() {
    final eventStream = _db.child('announcements').orderByKey().onValue;
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

  Future<void> addEvent(String content, String title, String ImgUrl) async {
    if (ImgUrl == '') {
      ImgUrl =
          'https://upload.wikimedia.org/wikipedia/commons/1/14/The_Event_2010_Intertitle.svg';
    }

    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      await _db.child('events/').push().set({
        'title': title,
        'content': content,
        'dateCreated': formattedDate,
        'ImgUrl': ImgUrl ??
            'https://upload.wikimedia.org/wikipedia/commons/1/14/The_Event_2010_Intertitle.svg',
      }).then((_) =>
          Get.snackbar("UPLOADED", title, snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
