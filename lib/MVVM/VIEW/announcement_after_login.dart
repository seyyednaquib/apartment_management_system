import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcment_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Contoller/announcement_controller.dart';
import '../../Model/announcement.dart';

class AnnouncementImportant extends StatefulWidget {
  const AnnouncementImportant({Key? key}) : super(key: key);

  @override
  State<AnnouncementImportant> createState() => _AnnouncementImportantState();
}

class _AnnouncementImportantState extends State<AnnouncementImportant> {
  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      leading: InkWell(
        onTap: () {
          Get.offAll(Root());
        },
        child: const Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      title: const Text(
        'Important Announcement',
        style: TextStyle(color: Colors.black),
      ),
    );

    final makeBody = StreamBuilder(
        stream: AnnouncementController().getAnnouncementStream(),
        builder: (context, snapshot) {
          final tileList = <Card>[];
          if (snapshot.hasData) {
            final myOrders = snapshot.data as List<AnnouncementModel>;
            myOrders.sort((b, a) => a.date.compareTo(b.date));
            tileList.addAll(myOrders.map((nextorder) {
              if (nextorder.important == "true") {
                return Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(227, 252, 248, 248)),
                    child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Icon(
                            Icons.notification_important,
                            size: 35,
                            color: Color.fromARGB(255, 228, 104, 104),
                          ),
                        ),
                        title: Text(nextorder.title),
                        subtitle: Text('posted on ' + nextorder.date),
                        onTap: () {
                          Get.to(() => AnnouncementDetails(
                                announcement: nextorder,
                              ));
                        }),
                  ),
                );
              } else
                return Card();
            }));
          }
          return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: tileList);
        });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: topAppBar,
        body: makeBody,
      ),
    );
  }
}
