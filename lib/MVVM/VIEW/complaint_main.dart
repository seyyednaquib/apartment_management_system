import 'package:apartment_management_system/Contoller/complaint_controller.dart';

import 'package:apartment_management_system/MVVM/VIEW/complaint_create.dart';

import 'package:apartment_management_system/Model/complaint.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyComplaint extends StatefulWidget {
  const MyComplaint({Key? key}) : super(key: key);

  @override
  State<MyComplaint> createState() => _MyComplaintState();
}

class _MyComplaintState extends State<MyComplaint> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    print('From Bg' + uid);
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
                Text('My Complaint',
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
                  stream: ComplaintController().getComplaintStream(),
                  builder: (context, snapshot) {
                    final tileList = <Container>[];
                    if (snapshot.hasData) {
                      final myOrders = snapshot.data as List<ComplaintModel>;
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
                              gradient: new LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 241, 241, 241),
                                    Color.fromARGB(255, 230, 229, 229)
                                  ],
                                  begin: Alignment.centerRight,
                                  end: new Alignment(-1.0, -1.0)),
                            ),
                            height: 160,
                            width: 100,
                            margin: EdgeInsets.only(top: 15, bottom: 15),
                            child: Stack(children: [
                              (nextorder.complaintRespond.toString() == "")
                                  ? Container()
                                  : Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        margin:
                                            EdgeInsets.only(top: 10, right: 10),
                                        color:
                                            Color.fromARGB(230, 125, 13, 253),
                                        child: InkWell(
                                            onTap: () {
                                              showAlertDialog(context,
                                                  nextorder.complaintRespond);
                                            },
                                            child: Center(
                                              child: Text(
                                                'RESPONDED',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            )),
                                      )),
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  height: 50,
                                  width: 370,
                                  child: Text(
                                      nextorder.complaintTitle.toUpperCase(),
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ),
                              Positioned(
                                top: 60,
                                left: 10,
                                child: Container(
                                  height: 60,
                                  width: 370,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: SingleChildScrollView(
                                    child: Text(nextorder.complaintContent,
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 114, 114, 114))),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                left: 10,
                                child: Text(
                                    'complained on ' + nextorder.dateCreated,
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                              ),
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
            Get.to(() => ComplaintCreate());
          },
          backgroundColor: Color.fromARGB(230, 125, 13, 253),
          elevation: 2,
          child: const Icon(Icons.add),
        ));
  }

  showAlertDialog(BuildContext context, String text) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Respond from Management"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
