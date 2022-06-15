import 'package:apartment_management_system/Contoller/event_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/forum/forum_main.dart';
import 'package:apartment_management_system/MVVM/VIEWMODEL/newForumViewModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Contoller/bindings/root.dart';
import '../../../Contoller/forum_controller.dart';
import '../widgets/appbar_widget.dart';

class CreateForumPage extends StatefulWidget {
  CreateForumPage({Key? key}) : super(key: key);

  @override
  State<CreateForumPage> createState() => _CreateForumPageState();
}

class _CreateForumPageState extends State<CreateForumPage> {
  NewForumViewModel forumViewModel = Get.put(NewForumViewModel());
  @override
  final TextEditingController postController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  title: Text(
                    '',
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
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: [
                                  Expanded(
                                    child: TextField(
                                      controller: postController,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 4,
                                      maxLength: 280,
                                      maxLengthEnforced: true,
                                      decoration: InputDecoration(
                                          hintText: "What's Happening?",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide.none),
                                          filled: true,
                                          fillColor: const Color(0xffF6F8FD)),
                                    ),
                                  ),
                                ]))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    forumViewModel.showPicker(context);
                                  },
                                  child: GetBuilder<NewForumViewModel>(
                                    init: NewForumViewModel(),
                                    builder: (value) => Container(
                                      child: forumViewModel.image != null
                                          ? Image.file(
                                              forumViewModel.image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Icon(
                                              Icons.image,
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
                            if (postController.text != "") {
                              final String imageUrl =
                                  await forumViewModel.uploadFile();
                              await ForumController()
                                  .addForum(postController.text, imageUrl);
                              Get.off(() => ForumPageMain());
                              forumViewModel.eventController.clear();
                              forumViewModel.eventTitleController.clear();
                              forumViewModel.eventDateAndTime.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(230, 125, 13, 253),
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text(
                            'POST',
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
