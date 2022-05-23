import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/MVVM/VIEWMODEL/complaintViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Contoller/bindings/root.dart';
import '../../Contoller/complaint_controller.dart';

class ComplaintCreate extends StatefulWidget {
  const ComplaintCreate({Key? key}) : super(key: key);

  @override
  State<ComplaintCreate> createState() => _ComplaintCreateState();
}

class _ComplaintCreateState extends State<ComplaintCreate> {
  @override
  ComplaintViewModel complaintviewmodel = Get.put(ComplaintViewModel());
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  title: Text(
                    'New Complaint',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                  )),
              body: Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),

                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            //contentPadding: EdgeInsets.all(40),
                                            border: OutlineInputBorder()),
                                        controller: complaintviewmodel
                                            .ComplaintTitleController),
                                  ),
                                ]))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: TextFormField(
                                      minLines: 5,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          //contentPadding: EdgeInsets.all(40),
                                          border: OutlineInputBorder()),
                                      controller: complaintviewmodel
                                          .ComplaintContenController,
                                    ),
                                  ),
                                ]))),

                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (complaintviewmodel
                                    .ComplaintContenController.text !=
                                "") {
                              ComplaintController().addComplaint(
                                  complaintviewmodel
                                      .ComplaintContenController.text,
                                  complaintviewmodel
                                      .ComplaintTitleController.text);
                              complaintviewmodel.ComplaintContenController
                                  .clear();
                              complaintviewmodel.ComplaintTitleController
                                  .clear();

                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Complaint',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        // StreamBuilder(
                        //     stream:
                        //         AnnouncementController().getAnnouncementStream(),
                        //     builder: (context, snapshot) {
                        //       final tileList = <ListTile>[];
                        //       if (snapshot.hasData) {
                        //         final myOrders =
                        //             snapshot.data as List<AnnouncementModel>;
                        //         tileList.addAll(myOrders.map((nextorder) {
                        //           return ListTile(
                        //             leading: Icon(Icons.newspaper_outlined),
                        //             title: Text(nextorder.title),
                        //             subtitle: Text(nextorder.content + ' S'),
                        //           );
                        //         }));
                        //       }
                        //       return Expanded(
                        //           child: ListView(
                        //         children: tileList,
                        //       ));
                        //     })
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
