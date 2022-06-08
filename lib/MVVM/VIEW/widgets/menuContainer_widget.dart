import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Container buildMenuContainer(
    BuildContext context, String asset, Widget navigatTo, String title) {
  return Container(
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
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
            height: 97,
            width: 97,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              InkWell(
                onTap: (() => Get.to(navigatTo)),
                child: (Image(
                  image: AssetImage(asset),
                  height: 97,
                  width: 97,
                )),
              ),
            ])),
        SizedBox(
          height: 10,
        ),
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black))
      ],
    ),
  );
}
