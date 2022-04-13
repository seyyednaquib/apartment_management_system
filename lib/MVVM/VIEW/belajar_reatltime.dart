import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_create_2.dart';
import 'package:apartment_management_system/MVVM/VIEW/read%20copy.dart';
import 'package:apartment_management_system/MVVM/VIEW/write.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Contoller/authController.dart';
import '../../Model/cafe_model.dart';

class HomeStudyRT extends GetWidget<AuthController> {
  const HomeStudyRT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetX<UserController>(
              builder: (_) {
                return Text(_.user.name ?? 'Loading');
              },
            ),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(CafeViewTwo());
                },
                child: const Text('Read with Streamer')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(TestWrite());
                },
                child: Text('Test Write')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(Announcement());
                },
                child: Text('Announcements')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(AnnouncementPageMain());
                },
                child: Text('New Announcements Page')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.signOut();
                },
                child: Text('LOGOUT')),
          ],
        ),
      ),
    );
  }
}
