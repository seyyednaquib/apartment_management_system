import 'package:apartment_management_system/Contoller/service_controller.dart';
import 'package:apartment_management_system/Contoller/work_permit_controller.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Contoller/bindings/root.dart';

class NewWorkPermit extends StatefulWidget {
  NewWorkPermit();

  @override
  State<NewWorkPermit> createState() => _NewWorkPermitState();
}

class _NewWorkPermitState extends State<NewWorkPermit> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController picNameController = TextEditingController();
  TextEditingController picNRICController = TextEditingController();
  TextEditingController picPhoneNoController = TextEditingController();
  TextEditingController numberOfContracotrController = TextEditingController();
  TextEditingController detailControllerController = TextEditingController();
  TextEditingController commencementDateContoller = TextEditingController();
  TextEditingController completionDateContoller = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

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
                    'Apply Work Permit',
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
                                      'Commencement Date Time',
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
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2100),
                              controller: commencementDateContoller,
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar

                                return true;
                              },
                              decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(40),
                                  border: OutlineInputBorder()),
                              onChanged: (val) => print('onchange' + val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Completion Date Time',
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
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2100),
                              controller: completionDateContoller,
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar

                                return true;
                              },
                              decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.all(40),
                                  border: OutlineInputBorder()),
                              onChanged: (val) => print('onchange' + val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Company Name',
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
                                        controller: companyNameController),
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
                                      'PIC Name',
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
                                        controller: picNameController),
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
                                      'PIC NRIC',
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
                                        controller: picNRICController),
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
                                      'PIC Phone Number',
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
                                        controller: picPhoneNoController),
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
                                      'Number of Contractors',
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
                                        controller:
                                            numberOfContracotrController),
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
                                      'Work to be Carried',
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
                                      minLines: 3,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          //contentPadding: EdgeInsets.all(40),
                                          border: OutlineInputBorder()),
                                      controller: detailControllerController,
                                    ),
                                  ),
                                ]))),

                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (detailControllerController.text != ' ' &&
                                commencementDateContoller.text != ' ') {
                              WorkPermitController().ApplyWorkPermit(
                                  commencementDateContoller.text,
                                  completionDateContoller.text,
                                  companyNameController.text,
                                  picNameController.text,
                                  picNRICController.text,
                                  picPhoneNoController.text,
                                  numberOfContracotrController.text,
                                  detailControllerController.text);
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _selectTime(context);
                        //   },
                        //   child: Text("Choose Time"),
                        // ),
                        // Text("${selectedTime.hour}:${selectedTime.minute}"),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
