import 'package:apartment_management_system/Contoller/authController.dart';
import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/MVVM/VIEW/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../MVVM/VIEW/belajar_reatltime.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          return HomeStudyRT();
        } else {
          return Login();
        }
      },
    );
  }
}
