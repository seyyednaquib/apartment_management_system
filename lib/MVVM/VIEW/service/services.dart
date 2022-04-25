import 'package:apartment_management_system/Contoller/service_controller.dart';

import 'package:apartment_management_system/MVVM/VIEW/service/bookService.dart';

import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';

import 'package:apartment_management_system/Model/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Contoller/bindings/root.dart';
import 'my_services_booking.dart';

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
      appBar: AppBar(
        title: Text(
          'Services',
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
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: [
          Container(
            width: 150,
            height: 100,
            margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
            color: Color.fromARGB(230, 125, 13, 253),
            child: InkWell(
                onTap: () {
                  Get.to(MyBooking());
                },
                child: Center(
                  child: Text(
                    'My Booking',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                )),
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please choose a service',
                  style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(0, 0, 0, 1)))
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: StreamBuilder(
                stream: ServiceController().getServiceStream(),
                builder: (context, snapshot) {
                  final tileList = <Container>[];
                  if (snapshot.hasData) {
                    final myOrders = snapshot.data as List<ServiceModel>;
                    tileList.addAll(myOrders.map((nextorder) {
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
                            gradient: new LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 241, 241, 241),
                                  Color.fromARGB(255, 230, 229, 229)
                                ],
                                begin: Alignment.centerRight,
                                end: new Alignment(-1.0, -1.0)),
                          ),
                          height: 90,
                          width: 90,
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          child: InkWell(
                            onTap: (() => Get.to(() => BookService(
                                  serviceId: nextorder.serviceId,
                                  content: nextorder.content,
                                  serviceTitle: nextorder.serviceTitle,
                                  workingHours: nextorder.workingHours,
                                ))),
                            child: Stack(children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: (Image(
                                  image:
                                      AssetImage('assets/images/service.png'),
                                  height: 90,
                                  width: 90,
                                )),
                              ),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Text(
                                    nextorder.serviceTitle.toUpperCase(),
                                    style: GoogleFonts.inter(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ),
                              Positioned(
                                top: 60,
                                left: 10,
                                child: Text(nextorder.workingHours,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromARGB(
                                            255, 114, 114, 114))),
                              ),
                            ]),
                          ));
                    }));
                  }
                  return ListView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 10, right: 6),
                      shrinkWrap: true,
                      children: tileList);
                }))
      ]),
    );
  }
}
