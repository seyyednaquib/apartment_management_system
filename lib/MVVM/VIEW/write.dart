import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestWrite extends StatefulWidget {
  const TestWrite({Key? key}) : super(key: key);

  @override
  State<TestWrite> createState() => _TestWriteState();
}

class _TestWriteState extends State<TestWrite> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    final noticeRef = database.child('notice/');
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await noticeRef.set({
                          'description': 'HOT NEWS FROM DB',
                          'created': formattedDate
                        });
                      } catch (e) {
                        print('you got an error');
                      }
                    },
                    child: Text('TEST'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final nextOrder = <String, dynamic>{
                        'description': getRandomDrink(),
                        'price': Random().nextInt(800) / 100.0,
                        'customer': getRandomName(),
                        'time': formattedDate
                      };
                      database
                          .child('orders')
                          .push()
                          .set(nextOrder)
                          .then((_) => print('order generated'))
                          .catchError((e) => print('you got an error $e'));
                    },
                    child: const Text('Append Order  '),
                  )
                ]))));
  }
}

String getRandomDrink() {
  final drinkList = [
    'latte',
    'Wine',
    'Coffee',
    'Lemonade',
    'Iced ',
    'Hot Chocalte',
    'Juice',
    'Water',
  ];
  return drinkList[Random().nextInt(drinkList.length)];
}

String getRandomName() {
  final drinkList = [
    'Naquib',
    'Balqis',
    'Ryhan',
    'Bob',
    'Rifha',
    'Dhyna',
    'Saipul',
    'Jack',
  ];
  return drinkList[Random().nextInt(drinkList.length)];
}
