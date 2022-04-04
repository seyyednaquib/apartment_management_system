import 'package:apartment_management_system/Contoller/announcement_controller.dart';
import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _anounController = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text('Announcements')),
        body: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add Announcement Here:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              controller: _anounController,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (_anounController.text != "") {
                                AnnouncementController().addAnnouncement(
                                    _anounController.text, 'New Title');
                                _anounController.clear();
                              }
                            },
                          ),
                        ]))),
                StreamBuilder(
                    stream: AnnouncementController().getAnnouncementStream(),
                    builder: (context, snapshot) {
                      final tileList = <ListTile>[];
                      if (snapshot.hasData) {
                        final myOrders =
                            snapshot.data as List<AnnouncementModelTEMP>;
                        tileList.addAll(myOrders.map((nextorder) {
                          return ListTile(
                            leading: Icon(Icons.newspaper_outlined),
                            title: Text(nextorder.title),
                            subtitle: Text(nextorder.content + ' S'),
                          );
                        }));
                      }
                      return Expanded(
                          child: ListView(
                        children: tileList,
                      ));
                    })
              ],
            )));
  }
}
