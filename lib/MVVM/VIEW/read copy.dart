import 'package:apartment_management_system/Contoller/oder_stream.dart';
import 'package:apartment_management_system/Model/cafe_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeViewTwo extends StatefulWidget {
  const CafeViewTwo({Key? key}) : super(key: key);

  @override
  State<CafeViewTwo> createState() => _CafeViewTwoState();
}

class _CafeViewTwoState extends State<CafeViewTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streamer Example '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            StreamBuilder(
                stream: OrderStreamPublisher().getOrderStream(),
                builder: (context, snapshot) {
                  final tileList = <ListTile>[];
                  if (snapshot.hasData) {
                    final myOrders = snapshot.data as List<Order>;
                    tileList.addAll(myOrders.map((nextorder) {
                      return ListTile(
                        leading: Icon(Icons.local_cafe_outlined),
                        title: Text(nextorder.description),
                        subtitle: Text(nextorder.customerName),
                      );
                    }));
                  }
                  return Expanded(
                      child: ListView(
                    children: tileList,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
