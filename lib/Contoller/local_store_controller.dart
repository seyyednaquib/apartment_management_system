import 'dart:io';

import 'package:apartment_management_system/Model/local_store.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StoreController extends GetxController {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<StoreModel>> getStoreStream() {
    final StoreStream = _db.child('localstore/').orderByKey().onValue;
    final streamToPublish = StoreStream.map((Store) {
      final StoreMap =
          Map<String, dynamic>.from(Store.snapshot.value as dynamic);
      final StoreList = StoreMap.entries.map((e) {
        return StoreModel.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return StoreList;
    });
    return streamToPublish;
  }
}
