import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_page.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcment_details.dart';
import 'package:apartment_management_system/MVVM/VIEW/belajar_reatltime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Contoller/announcement_controller.dart';
import '../../Model/announcement.dart';

class AnnouncementPageMain extends StatefulWidget {
  const AnnouncementPageMain({Key? key}) : super(key: key);

  @override
  State<AnnouncementPageMain> createState() => _AnnouncementPageMainState();
}

class _AnnouncementPageMainState extends State<AnnouncementPageMain> {
  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      leading: InkWell(
        onTap: () {
          Get.offAll(Root());
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Announcement'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    final items = [];
    final makeBody = StreamBuilder(
        stream: AnnouncementController().getAnnouncementStream(),
        builder: (context, snapshot) {
          final tileList = <Card>[];
          if (snapshot.hasData) {
            final myOrders = snapshot.data as List<AnnouncementModel>;
            tileList.addAll(myOrders.map((nextorder) {
              return Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: const Icon(Icons.newspaper_outlined,
                            color: Colors.white),
                      ),
                      title: Text(
                        nextorder.content,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Get.to(AnnouncementDetails(
                          announcement: nextorder,
                        ));
                      }),
                ),
              );
            }));
          }
          return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: tileList);
        });

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      bottomNavigationBar: makeBottom,
      body: makeBody,
    );
  }
}
