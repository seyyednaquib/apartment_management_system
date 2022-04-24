import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcment_details.dart';
import 'package:apartment_management_system/MVVM/VIEW/complaint_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/menuContainer_widget.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/menuForServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Contoller/announcement_controller.dart';
import '../../Model/announcement.dart';

class ServicePageMain extends StatefulWidget {
  const ServicePageMain({Key? key}) : super(key: key);

  @override
  State<ServicePageMain> createState() => _ServicePageMainState();
}

class _ServicePageMainState extends State<ServicePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: buildAppBar(context, 'Services'),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please choose a service',
                  style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black))
            ],
          ),
        ),
        SizedBox(height: 25),
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left: 10, right: 6),
          children: [
            buildMenuService(context, ServicePageMain()),
            buildMenuService(context, ServicePageMain()),
            buildMenuService(context, ServicePageMain()),
            buildMenuService(context, ServicePageMain()),
            buildMenuService(context, ServicePageMain()),
          ],
        ),
      ]),
    );
  }
}
