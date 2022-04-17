import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatars/avatars.dart';
import '../../Contoller/bindings/root.dart';
import '../../Contoller/userController.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: const Text(
                "Profile",
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
                child:
                    const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              )),
          body: Padding(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: GetX<UserController>(
                      builder: (_) {
                        return Avatar(
                          shape: AvatarShape.circle(48),
                          name: _.user.rName ?? 'U M',
                          placeholderColors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(230, 125, 13, 253),
                            //...
                          ],
                        );
                      },
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: GetX<UserController>(
                                  builder: (_) {
                                    return Text(_.user.rName!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ));
                                  },
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: GetX<UserController>(
                                  builder: (_) {
                                    return Text(_.user.rEmail!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ));
                                  },
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                                child: GetX<UserController>(
                                  builder: (_) {
                                    return Text(_.user.rUnit!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ));
                                  },
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                                child: GetX<UserController>(
                                  builder: (_) {
                                    return Text(_.user.rPhone!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ));
                                  },
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(230, 185, 184, 185),
                          fixedSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
