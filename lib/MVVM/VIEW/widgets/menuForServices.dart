import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Container buildMenuService(BuildContext context, Widget navigatTo) {
  return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(1, 2), // Shadow position
          ),
        ],
        color: Colors.purple,
        gradient: new LinearGradient(colors: [
          Color.fromARGB(255, 241, 241, 241),
          Color.fromARGB(255, 230, 229, 229)
        ], begin: Alignment.centerRight, end: new Alignment(-1.0, -1.0)),
      ),
      height: 100,
      width: 100,
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: InkWell(
        onTap: (() => Get.to(navigatTo)),
        child: Stack(children: [
          Positioned(
            top: 0,
            right: 0,
            child: (Image(
              image: AssetImage('assets/images/service.png'),
              height: 100,
              width: 100,
            )),
          ),
        ]),
      ));
}
