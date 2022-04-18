import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Contoller/bindings/root.dart';

AppBar buildAppBar(BuildContext context, String title) {
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
      title: Text(
        title,
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
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      ));
}
