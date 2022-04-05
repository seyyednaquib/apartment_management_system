import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:apartment_management_system/Contoller/announcement_controller.dart';
import 'package:apartment_management_system/Model/announcement.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final database = FirebaseDatabase.instance.ref();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<String> uploadFile() async {
    if (_image == null) return '';
    final fileName = _image!.path;
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('announcements/$fileName');
      await ref.putFile(_image!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
      rethrow;
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _anounController = TextEditingController();
    final TextEditingController _anounTitleController = TextEditingController();

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
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xffFDCF09),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                Card(
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              controller: _anounTitleController,
                            ),
                          ),
                        ]))),
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
                            onPressed: () async {
                              if (_anounController.text != "") {
                                final String imageUrl = await uploadFile();
                                AnnouncementController().addAnnouncement(
                                    _anounController.text,
                                    _anounTitleController.text,
                                    imageUrl);
                                _anounController.clear();
                                _anounTitleController.clear();
                                _image!.delete();
                                Get.back();
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
                            snapshot.data as List<AnnouncementModel>;
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
