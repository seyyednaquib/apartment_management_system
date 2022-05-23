import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
      body: Container(
        color: Colors.white,
        child: Text(
          'OKe',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
