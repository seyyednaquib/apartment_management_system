import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/Model/resident.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestProfile extends GetView<UserController> {
  const TestProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: buildAppBar(context, 'Test'),
          body: Container(
              child: Text(
            controller.user.rName ?? '',
          ))),
    );
  }
}
