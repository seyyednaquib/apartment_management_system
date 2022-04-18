import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/complaint_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/profile/edit_profile_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/profile/profile.dart';
import 'package:apartment_management_system/MVVM/VIEW/profile/testProfileStream.dart';
import 'package:apartment_management_system/MVVM/VIEW/read%20copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Contoller/authController.dart';

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
                return Row(
                  children: [
                    Text(_.user.rName ?? 'Loading'),
                  ],
                );
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
                child: Text('Announcements Page')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(CreateEventPage());
                },
                child: Text('Create Event')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(EventPageMain());
                },
                child: Text('Events Page')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(Profile());
                },
                child: Text('Update Resident Profile')),
            SizedBox(
              height: 6,
              width: MediaQuery.of(context).size.width,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => ComplaintCreate());
                },
                child: Text('Create Complaint')),
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
