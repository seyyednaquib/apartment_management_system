import 'package:firebase_database/firebase_database.dart';

import '../Model/cafe_model.dart';

class OrderStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();
  Stream<List<Order>> getOrderStream() {
    final orderStream = _database.child('orders').onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final orderList = orderMap.entries.map((e) {
        return Order.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }
}
