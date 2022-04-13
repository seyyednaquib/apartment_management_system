import 'dart:io';
import 'package:apartment_management_system/MVVM/VIEWMODEL/announcementViewModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:apartment_management_system/Contoller/announcement_controller.dart';
import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Contoller/bindings/root.dart';

class Announcement extends StatefulWidget {
  Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  AnnouncementViewModel anonviewmodel = Get.put(AnnouncementViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  title: const Text(
                    "New Announcement",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: InkWell(
                    onTap: () {
                      Get.offAll(Root());
                    },
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                  )),
              body: Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),

                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            //contentPadding: EdgeInsets.all(40),
                                            border: OutlineInputBorder()),
                                        controller:
                                            anonviewmodel.anounTitleController),
                                  ),
                                ]))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                      minLines: 5,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          //contentPadding: EdgeInsets.all(40),
                                          border: OutlineInputBorder()),
                                      controller: anonviewmodel.anounController,
                                    ),
                                  ),
                                ]))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Upload Picture',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    anonviewmodel.showPicker(context);
                                  },
                                  child: GetBuilder<AnnouncementViewModel>(
                                    init: AnnouncementViewModel(),
                                    builder: (value) => Container(
                                      child: anonviewmodel.image != null
                                          ? Image.file(
                                              anonviewmodel.image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Icon(
                                              size: 50,
                                              Icons.cloud_upload_outlined,
                                              color: Colors.grey[800],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (anonviewmodel.anounController.text != "") {
                              final String imageUrl =
                                  await anonviewmodel.uploadFile();

                              AnnouncementController().addAnnouncement(
                                  anonviewmodel.anounController.text,
                                  anonviewmodel.anounTitleController.text,
                                  imageUrl);
                              anonviewmodel.anounController.clear();
                              anonviewmodel.anounTitleController.clear();

                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Announce',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        // StreamBuilder(
                        //     stream:
                        //         AnnouncementController().getAnnouncementStream(),
                        //     builder: (context, snapshot) {
                        //       final tileList = <ListTile>[];
                        //       if (snapshot.hasData) {
                        //         final myOrders =
                        //             snapshot.data as List<AnnouncementModel>;
                        //         tileList.addAll(myOrders.map((nextorder) {
                        //           return ListTile(
                        //             leading: Icon(Icons.newspaper_outlined),
                        //             title: Text(nextorder.title),
                        //             subtitle: Text(nextorder.content + ' S'),
                        //           );
                        //         }));
                        //       }
                        //       return Expanded(
                        //           child: ListView(
                        //         children: tileList,
                        //       ));
                        //     })
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}