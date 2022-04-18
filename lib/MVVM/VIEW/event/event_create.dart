import 'package:apartment_management_system/Contoller/event_controller.dart';
import 'package:apartment_management_system/MVVM/VIEWMODEL/eventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Contoller/bindings/root.dart';
import '../widgets/appbar_widget.dart';

class CreateEventPage extends StatefulWidget {
  CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  EventViewModel evenViewModel = Get.put(EventViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(context, 'New Event'),
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
                                        controller:
                                            evenViewModel.eventTitleController),
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
                                      controller: evenViewModel.eventController,
                                    ),
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
                                      'Upload Picture',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    evenViewModel.showPicker(context);
                                  },
                                  child: GetBuilder<EventViewModel>(
                                    init: EventViewModel(),
                                    builder: (value) => Container(
                                      child: evenViewModel.image != null
                                          ? Image.file(
                                              evenViewModel.image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Icon(
                                              Icons.cloud_upload_outlined,
                                              size: 50,
                                              color: Colors.grey[800],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (evenViewModel.eventController.text != "") {
                              final String imageUrl =
                                  await evenViewModel.uploadFile();

                              EventController().addEvent(
                                  evenViewModel.eventController.text,
                                  evenViewModel.eventTitleController.text,
                                  imageUrl);
                              evenViewModel.eventController.clear();
                              evenViewModel.eventTitleController.clear();

                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'Announce',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
