import 'package:apartment_management_system/MVVM/VIEW/profile/profile.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Contoller/userController.dart';

class EditProfile extends StatefulWidget {
  final String? oldName;
  final String? oldPhone;
  final String? oldUnit;
  const EditProfile(this.oldName, this.oldPhone, this.oldUnit, {Key? key})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    UserController c = Get.put(UserController());
    TextEditingController nameController =
        TextEditingController(text: widget.oldName);
    TextEditingController unitController =
        TextEditingController(text: widget.oldUnit);
    TextEditingController phoneController =
        TextEditingController(text: widget.oldPhone);

    return Scaffold(
      appBar: buildAppBar(context, ''),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: unitController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phone',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            child: ElevatedButton(
              onPressed: () async {
                print(nameController.text +
                    phoneController.text +
                    unitController.text);
                await UserController().updateUser(nameController.text,
                    phoneController.text, unitController.text);
                Get.off(Profile());
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(230, 125, 13, 253),
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: const Text(
                'Confirm Update',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
