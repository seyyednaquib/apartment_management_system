import 'package:apartment_management_system/Contoller/local_store_controller.dart';
import 'package:apartment_management_system/Model/local_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Contoller/event_controller.dart';
import '../../Model/event.dart';

class NearestLocalStore extends StatefulWidget {
  const NearestLocalStore({Key? key}) : super(key: key);

  @override
  State<NearestLocalStore> createState() => _NearestLocalStoreState();
}

class _NearestLocalStoreState extends State<NearestLocalStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              'Nearest Local Store',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            )),
        body: StreamBuilder(
            stream: StoreController().getStoreStream(),
            builder: (context, snapshot) {
              final tileList = <Card>[];
              if (snapshot.hasData) {
                final allEvents = snapshot.data as List<StoreModel>;
                tileList.addAll(allEvents.map((store) {
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(227, 252, 248, 248)),
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.black))),
                            child: const Icon(Icons.event_outlined,
                                color: Colors.black),
                          ),
                          title: Text(
                            store.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: const Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(store.ImgUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            //LAUNCHER MAP
                          }),
                    ),
                  );
                }));
              }
              return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: tileList);
            }));
  }
}
