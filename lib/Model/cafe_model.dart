import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class CafeModel extends ChangeNotifier {
  List<Order> _orders = [];
  final _db = FirebaseDatabase.instance.ref();

  static const ORDERS_PATH = 'orders';

  late StreamSubscription<DatabaseEvent> _orderStream;

  List<Order> get orders => _orders;

  CafeModel() {
    _listenToOrders();
  }
  void _listenToOrders() {
    _orderStream = _db.child(ORDERS_PATH).onValue.listen((event) {
      final allOrders =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      _orders = allOrders.values
          .map((orderAsJson) =>
              Order.fromRTDB(Map<String, dynamic>.from(orderAsJson)))
          .toList();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _orderStream.cancel();
    super.dispose();
  }
}

class Order {
  final String description;
  final double price;
  final String customerName;
  final String date;

  Order(
      {required this.description,
      required this.price,
      required this.customerName,
      required this.date});

  factory Order.fromRTDB(Map<String, dynamic> data) {
    return Order(
        description: data['description'] ?? 'drink',
        price: data['price'] ?? 0.0,
        customerName: data['customer'] ?? 'Unknown',
        date: data['time'] ?? 'unknownTIME');
  }
}
