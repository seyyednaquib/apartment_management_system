import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Model/service.dart';

class ServiceController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<ServiceModel>> getServiceStream() {
    final serviceStream = _db.child('services').orderByKey().onValue;
    final streamToPublish = serviceStream.map((event) {
      final serviceMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final serviceList = serviceMap.entries.map((e) {
        return ServiceModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return serviceList;
    });
    return streamToPublish;
  }

  Stream<List<BookServiceModel>> getBookedServiceUser() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final serviceStream = _db.child('bookedService/').child(uid!).onValue;
    final streamToPublish = serviceStream.map((event) {
      final serviceMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final serviceList = serviceMap.entries.map((e) {
        return BookServiceModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return serviceList;
    });
    return streamToPublish;
  }

  Future<void> BookAService(
      String serviceId, String bookindDateAndTime, String residentId) async {
    final String? bookingId = await _db.child('bookedService/').push().key;
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
      await _db.child('bookedService/').child(bookingId!).push().set({
        'serviceId': serviceId,
        'bookingId': bookingId,
        'residentId': residentId,
        'bookindDateAndTime': bookindDateAndTime,
        'status': '',
      }).then((_) => Get.snackbar("Booked", 'Service',
          snackPosition: SnackPosition.BOTTOM));
    } catch (e) {
      print(e);
    }
  }
}
