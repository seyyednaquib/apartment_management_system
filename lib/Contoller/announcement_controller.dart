import 'package:apartment_management_system/MVVM/VIEW/announcement_page.dart';
import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  Rxn<List<AnnouncementModelTEMP>> announcementList =
      Rxn<List<AnnouncementModelTEMP>>();
  List<AnnouncementModelTEMP>? get announcements => announcementList.value;

  final _db = FirebaseDatabase.instance.ref();

  Stream<List<AnnouncementModelTEMP>> getAnnouncementStream() {
    final orderStream = _db.child('announcements').onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        return AnnouncementModelTEMP.fromRTDB(
            Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

  Future<void> addAnnouncement(String content, String title) async {
    try {
      await _db.child('announcements/').push().set({
        'title': title,
        'content': content,
        'dateCreated': DateTime.now().millisecondsSinceEpoch
      }).then((_) => print('announcement Uploaded'));
    } catch (e) {
      print(e);
    }
  }
}
