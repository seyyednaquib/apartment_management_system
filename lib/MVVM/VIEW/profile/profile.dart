import 'package:apartment_management_system/MVVM/VIEW/profile/edit_profile.dart';
import 'package:apartment_management_system/MVVM/VIEW/profile/edit_profile_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatars/avatars.dart';
import '../../../Contoller/userController.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserController c = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(context, 'Profile'),
              body: Padding(
                  padding: EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Avatar(
                          shape: AvatarShape.circle(48),
                          name: c.user.rName ?? 'U M',
                          placeholderColors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(230, 125, 13, 253),
                            //...
                          ],
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Seyyed Naquib',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'naquib@melawis.my',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Unit',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: Text(c.user.rUnit ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          )))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Phone',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: Text(c.user.rPhone ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          )))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(() => EditProfile(
                                c.user.rName, c.user.rPhone, c.user.rUnit));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(100, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}
