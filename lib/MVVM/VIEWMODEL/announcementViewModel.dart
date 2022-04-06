import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementViewModel extends GetxController {
  String text = '';
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

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  final TextEditingController _anounController = TextEditingController();
  final TextEditingController _anounTitleController = TextEditingController();
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
