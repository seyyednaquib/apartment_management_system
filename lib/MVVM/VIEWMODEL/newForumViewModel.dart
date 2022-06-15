import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewForumViewModel extends GetxController {
  final database = FirebaseDatabase.instance.ref();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  get image => _image;

  Future<String> uploadFile() async {
    if (_image == null) return '';
    final fileName = _image!.path;

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('forums/$fileName');
      await ref.putFile(_image!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
      rethrow;
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(pickedFile.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        imgFromGallery();

                        Get.back();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController eventController = TextEditingController();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDateAndTime = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
