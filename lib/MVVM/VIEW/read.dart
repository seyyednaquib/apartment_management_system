import 'package:apartment_management_system/Model/cafe_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeView extends StatefulWidget {
  const CafeView({Key? key}) : super(key: key);

  @override
  State<CafeView> createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example S '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Consumer<CafeModel>(builder: (context, model, child) {
              return Expanded(
                  child: ListView(
                children: [
                  ...model.orders.map((order) => Card(
                        child: ListTile(
                          leading: Icon(Icons.local_cafe_outlined),
                          title: Text(order.description),
                          subtitle:
                              Text('${order.customerName} \$${order.price}'),
                        ),
                      ))
                ],
              ));
            })
          ],
        ),
      ),
    );
  }
}
