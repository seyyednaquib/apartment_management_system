import 'package:apartment_management_system/Model/announcement.dart';
import 'package:apartment_management_system/Model/work_permit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/service.dart';

class WorkPermitController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<WorkPermitModel>> getWorkPermitUser() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final workStream = _db.child('applyWorkPermit/').onValue;
    final streamToPublish = workStream.map((event) {
      final workMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final workList = workMap.entries.map((e) {
        print(e.value.toString());
        return WorkPermitModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return workList;
    });
    return streamToPublish;
  }

  Future<void> ApplyWorkPermit(
      String CommencementDate,
      String completionDate,
      String companyName,
      String PicName,
      String PicNRIC,
      String PICphoneNo,
      String numberOfcontractors,
      String work) async {
    final residentId = await FirebaseAuth.instance.currentUser?.uid;
    final String? applyId = await _db.child('applyWorkPermit/').push().key;
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      await _db.child('applyWorkPermit/').child(applyId!).set({
        'applyId': applyId,
        'residentId': residentId,
        'commencementDate': CommencementDate,
        'completionDate': completionDate,
        'companyName': companyName,
        'picName': PicName,
        'picNRIC': PicNRIC,
        'picphoneNo': PICphoneNo,
        'numberOfcontractors': numberOfcontractors,
        'work': work,
        'status': '',
        'pdfPath': '',
        'dateCrated': formattedDate,
      }).then((_) => Get.snackbar("Applied", companyName,
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
