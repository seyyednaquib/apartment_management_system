import 'package:apartment_management_system/Contoller/service_controller.dart';
import 'package:apartment_management_system/Contoller/work_permit_controller.dart';

import 'package:apartment_management_system/MVVM/VIEW/service/bookService.dart';

import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/MVVM/VIEW/workPermit_create.dart';

import 'package:apartment_management_system/Model/service.dart';
import 'package:apartment_management_system/Model/work_permit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWorkPermit extends StatefulWidget {
  const MyWorkPermit({Key? key}) : super(key: key);

  @override
  State<MyWorkPermit> createState() => _MyWorkPermitState();
}

class _MyWorkPermitState extends State<MyWorkPermit> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Work Permit',
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
                  stream: WorkPermitController().getWorkPermitUser(),
                  builder: (context, snapshot) {
                    final tileList = <Container>[];
                    if (snapshot.hasData) {
                      final myOrders = snapshot.data as List<WorkPermitModel>;
                      tileList.addAll(myOrders.map((nextorder) {
                        if (nextorder.residentId == uid)
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
                            height: 150,
                            width: 100,
                            margin: EdgeInsets.only(top: 15, bottom: 15),
                            child: Stack(children: [
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Text(nextorder.companyName.toUpperCase(),
                                    style: GoogleFonts.inter(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ),
                              Positioned(
                                top: 50,
                                left: 10,
                                child: Text(
                                    nextorder.commencementDate +
                                        ' | ' +
                                        nextorder.completionDate,
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(
                                            255, 114, 114, 114))),
                              ),
                              Positioned(
                                top: 83,
                                left: 10,
                                child: Text('Status: ',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(
                                            255, 114, 114, 114))),
                              ),
                              Positioned(
                                top: 82,
                                left: 85,
                                child: Text(
                                    (nextorder.status.toString() == "")
                                        ? 'PENDING'
                                        : nextorder.status,
                                    style: GoogleFonts.inter(
                                        backgroundColor:
                                            (nextorder.status.toString() == "")
                                                ? Colors.amber
                                                : Colors.green,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: (nextorder.status.toString() ==
                                                "")
                                            ? Color.fromARGB(255, 114, 114, 114)
                                            : Color.fromARGB(
                                                255, 255, 255, 255))),
                              ),
                              Positioned(
                                top: 120,
                                left: 10,
                                child: Text(
                                    'applied on ' + nextorder.dateCrated,
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: (nextorder.status.toString() == "")
                                    ? Text('')
                                    : Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.purple,
                                        size: 30,
                                      ),
                              )
                            ]),
                          );
                        else
                          return Container();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => NewWorkPermit());
          },
          backgroundColor: Color.fromARGB(230, 125, 13, 253),
          elevation: 2,
          child: const Icon(Icons.add),
        ));
  }
}
