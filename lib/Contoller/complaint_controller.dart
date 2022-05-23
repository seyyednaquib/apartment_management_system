import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/complaint.dart';

class ComplaintController extends GetxController {
  // Rxn<List<AnnouncementModel>> announcementList = Rxn<List<AnnouncementModel>>();
  // List<AnnouncementModel>? get announcements => announcementList.value;

  final _db = FirebaseDatabase.instance.ref();

  Stream<List<ComplaintModel>> getComplaintStream() {
    final orderStream = _db.child('complaints/').orderByKey().onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        print(e.value.toString());
        return ComplaintModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

  Future<void> addComplaint(
      String complaintContent, String complaintTitle) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      final String? key = await _db.child('complaints/').push().key;
      await _db.child('complaints/').child(key!).set({
        'complaintId': key,
        'residentId': FirebaseAuth.instance.currentUser?.uid,
        'complaintContent': complaintContent,
        'complaintTitle': complaintTitle,
        'dateCreated': formattedDate,
        'ComplaintRespond': '',
      }).then((_) => Get.snackbar("UPLOADED", complaintTitle,
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
