import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileTest extends StatelessWidget {
  const EditProfileTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController c = Get.put(UserController());
    return Obx(() => Scaffold(
          appBar: buildAppBar(context, 'title'),
        ));
  }
}
