import 'dart:io';

import 'package:apartment_management_system/MVVM/VIEW/announcement_page.dart';
import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementController extends GetxController {
  Rxn<List<AnnouncementModel>> announcementList =
      Rxn<List<AnnouncementModel>>();
  List<AnnouncementModel>? get announcements => announcementList.value;

  final _db = FirebaseDatabase.instance.ref();

  Stream<List<AnnouncementModel>> getAnnouncementStream() {
    final orderStream =
        _db.child('announcements').orderByChild('dateCreated').onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        return AnnouncementModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

  Future<void> addAnnouncement(
      String content, String title, String ImgUrl) async {
    try {
      await _db.child('announcements/').push().set({
        'title': title,
        'content': content,
        'dateCreated': DateTime.now().millisecondsSinceEpoch,
        'ImgUrl': ImgUrl
      }).then((_) =>
          Get.snackbar("UPLOADED", title, snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }

  Future<XFile?> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
