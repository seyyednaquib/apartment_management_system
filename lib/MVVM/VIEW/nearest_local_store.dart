import 'package:apartment_management_system/Contoller/local_store_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/map_utils.dart';
import 'package:apartment_management_system/Model/local_store.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
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
  int choosen_index = 0;
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
                allEvents
                    .sort((b, a) => b.dateCreated.compareTo(a.dateCreated));
                tileList.addAll(allEvents.map((store) {
                  if (choosen_index == 0 && store.category == 'restaurant') {
                    return Card(
                      elevation: 8.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(227, 252, 248, 248)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black))),
                                child: Icon(
                                    (store.category == 'restaurant'
                                        ? Icons.restaurant_menu
                                        : Icons.store),
                                    color: Colors.black),
                              ),
                              title: Text(
                                store.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                store.category,
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('DESCRIPTION'),
                                  onPressed: () {
                                    showAlertDialog(
                                        context, store.name, store.content);
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('NAVIGATE'),
                                  onPressed: () {
                                    MapUtils.openMap(store.coordinate);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (choosen_index == 1 && store.category == 'store') {
                    return Card(
                      elevation: 8.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(227, 252, 248, 248)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black))),
                                child: Icon(
                                    (store.category == 'restaurant'
                                        ? Icons.restaurant_menu
                                        : Icons.store),
                                    color: Colors.black),
                              ),
                              title: Text(
                                store.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                store.category,
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('DESCRIPTION'),
                                  onPressed: () {
                                    showAlertDialog(
                                        context, store.name, store.content);
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('NAVIGATE'),
                                  onPressed: () {
                                    MapUtils.openMap(store.coordinate);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Card();
                  }
                }));
              }
              return Column(children: [
                DefaultTabController(
                  length: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    height: 50.0,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BubbleTabIndicator(
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorHeight: 30.0,
                          indicatorColor: Colors.grey,
                          insets: EdgeInsets.all(1),
                          padding: EdgeInsets.all(10)),
                      tabs: [
                        Text('Restaurant'),
                        Text('Store'),
                      ],
                      onTap: (index) {
                        setState(() {
                          choosen_index = index;
                          print(choosen_index);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: tileList),
                ),
              ]);
            }));
  }

  showAlertDialog(BuildContext context, String title, String text) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
