import 'package:apartment_management_system/MVVM/VIEW/announcement_create.dart';
import 'package:apartment_management_system/Model/forum.dart';
import 'package:apartment_management_system/Model/resident.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ForumController extends GetxController {
  // Rxn<List<AnnouncementModel>> announcementList = Rxn<List<AnnouncementModel>>();
  // List<AnnouncementModel>? get announcements => announcementList.value;

  final _db = FirebaseDatabase.instance.ref();

  Stream<List<ForumModel>> getForumStream() {
    final orderStream = _db.child('forums/').orderByKey().onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        print(e.value.toString());
        return ForumModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

  Future<void> addForum(String comment, String ImgUrl) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      final String? key = await _db.child('forums/').push().key;
      print('name');
      print(FirebaseAuth.instance.currentUser?.displayName);
      await _db.child('forums/').child(key!).set({
        'content': comment,
        'id': key,
        'title': '',
        'ImgUrl': ImgUrl,
        'residentName': FirebaseAuth.instance.currentUser?.email,
        'residentId': FirebaseAuth.instance.currentUser?.uid,
        'timeStamp': now.toString(),
      }).then((_) => Get.snackbar("Forum Posted", '',
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ThreadModel>> getThreadStream(forumId) {
    final orderStream =
        _db.child('forums/' + forumId).child('thread/').orderByKey().onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        print(e.value.toString());
        return ThreadModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

  Future<void> addComment(String forumContent, String forumId) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      final String? key =
          await _db.child('forums/' + forumId + '/thread/').push().key;
      print('name');
      print(FirebaseAuth.instance.currentUser?.displayName);
      await _db.child('forums/' + forumId + '/thread/').child(key!).set({
        'content': forumContent,
        'id': key,
        'forumId': forumId,
        'residentName': FirebaseAuth.instance.currentUser?.email,
        'residentId': FirebaseAuth.instance.currentUser?.uid,
        'timeStamp': now.toString(),
      }).then((_) => Get.snackbar("Forum Posted", '',
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
