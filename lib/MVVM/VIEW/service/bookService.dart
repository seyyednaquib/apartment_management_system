import 'package:apartment_management_system/Contoller/service_controller.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Contoller/bindings/root.dart';

class BookService extends StatefulWidget {
  final String serviceId;
  final String serviceTitle;
  final String content;
  final String workingHours;
  BookService(
      {Key? key,
      required this.serviceId,
      required this.serviceTitle,
      required this.content,
      required this.workingHours})
      : super(key: key);

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  TextEditingController detailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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
                    widget.serviceTitle,
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
                        Container(
                          height: 100,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1.0, color: Colors.black54)),
                          child: SingleChildScrollView(
                            child: Text(widget.content,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16)),
                          ),
                        ),

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
                                      'Select Date',
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
                              controller: dateController,
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  if (widget.workingHours
                                      .contains('SUN-FRIDAY')) return false;
                                }

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
                                      'NOTE',
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
                                      controller: detailController,
                                    ),
                                  ),
                                ]))),

                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (detailController.text != ' ' &&
                                dateController.text != ' ') {
                              ServiceController().BookAService(
                                  widget.serviceId,
                                  dateController.text,
                                  detailController.text,
                                  widget.serviceTitle);
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Book',
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
