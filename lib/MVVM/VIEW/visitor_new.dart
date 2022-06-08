import 'package:apartment_management_system/Contoller/event_controller.dart';
import 'package:apartment_management_system/Contoller/visitor_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/MVVM/VIEWMODEL/eventViewModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Contoller/bindings/root.dart';

class NewVistior extends StatefulWidget {
  NewVistior({Key? key}) : super(key: key);

  @override
  State<NewVistior> createState() => _NewVistiorState();
}

class _NewVistiorState extends State<NewVistior> {
  EventViewModel evenViewModel = Get.put(EventViewModel());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController icpassport = TextEditingController();
  final TextEditingController expectedTime = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(context, 'New Vistior'),
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
                                      'Name',
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
                                        controller: nameController),
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
                                      'Expected Entry Time',
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
                              controller: expectedTime,
                              selectableDayPredicate: (date) {
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
                                      'IC/Passport',
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
                                        controller: icpassport),
                                  ),
                                ]))),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            bool a = await DateTime.parse(expectedTime.text)
                                .isBefore(now);

                            if (DateTime.parse(expectedTime.text)
                                    .isBefore(now) &&
                                nameController.text != "") {
                              VistiorController().NewVistior(expectedTime.text,
                                  icpassport.text, nameController.text);
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
