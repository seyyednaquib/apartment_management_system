import 'package:apartment_management_system/Model/Visitor.dart';
import 'package:apartment_management_system/Model/work_permit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VistiorController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<VisitorModel>> getVistiorStream() {
    final VistiorStream = _db.child('visitors').orderByKey().onValue;
    final streamToPublish = VistiorStream.map((event) {
      final VistiorMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final VistiorList = VistiorMap.entries.map((e) {
        return VisitorModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return VistiorList;
    });
    return streamToPublish;
  }

  Future<void> NewVistior(String expectedEntryTime, String visitorIcPassport,
      String visitorName) async {
    final residentId = await FirebaseAuth.instance.currentUser?.uid;
    final String? visitorId = await _db.child('visitors/').push().key;
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      await _db.child('visitors/').child(visitorId!).set({
        'visitorId': visitorId,
        'visitorName': visitorName,
        'expectedEntryTime': expectedEntryTime,
        'visitorIcPassport': visitorIcPassport,
        'residentId': residentId,
        'visitorPreRegis': 'true',
        'visitorValidate': '',
        'dateCreated': formattedDate,
      }).then((_) => Get.snackbar("Pre Register Visitor Succesful", visitorName,
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
