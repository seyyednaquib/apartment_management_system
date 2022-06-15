import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:apartment_management_system/Contoller/forum_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcment_details.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/commentPost.widget.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/forumPost.widget.dart';
import 'package:apartment_management_system/Model/forum.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ForumPageDetails extends StatefulWidget {
  final ForumModel forum;
  const ForumPageDetails({Key? key, required this.forum}) : super(key: key);

  @override
  State<ForumPageDetails> createState() => _ForumPageDetailsState();
}

class _ForumPageDetailsState extends State<ForumPageDetails> {
  TextEditingController postController = TextEditingController();
  @override
  bool shows = false;
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      title: const Text(
        'Forum',
        style: TextStyle(color: Colors.black),
      ),
    );

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: topAppBar,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Avatar(
                        shape: AvatarShape.circle(28),
                        name: (widget.forum.residentName == '')
                            ? 'UM'
                            : widget.forum.residentName.toUpperCase(),
                        placeholderColors: [
                          Color.fromARGB(255, 39, 28, 28),
                          Color.fromARGB(230, 125, 13, 253),
                          //...
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        widget.forum.residentName
                            .substring(
                                0, widget.forum.residentName.indexOf('@'))
                            .toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8.0, right: 16),
                child: Text(widget.forum.content),
              ),
              (widget.forum.ImgUrl != '')
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 8.0, right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                            widget.forum.ImgUrl,
                            height: 300,
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8.0, right: 16),
                child: Text(
                  Jiffy(Jiffy.unixFromMillisecondsSinceEpoch(
                          int.parse(widget.forum.timeStamp)))
                      .fromNow(),
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: ForumController().getThreadStream(widget.forum.id),
                    builder: (context, snapshot) {
                      final tileList = <CommentWidget>[];
                      if (snapshot.hasData) {
                        final myThread = snapshot.data as List<ThreadModel>;
                        myThread
                            .sort((b, a) => b.timeStamp.compareTo(a.timeStamp));
                        tileList.addAll(myThread.map((oneComment) {
                          return CommentWidget(comment: oneComment);
                        }));
                      }
                      return ListView(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          children: tileList);
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: postController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 280,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                      hintText: "Comment",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      suffixIcon: ClipOval(
                        child: Material(
                          color: Colors.white.withOpacity(0.0),
                          child: IconButton(
                              onPressed: () async {
                                await ForumController().addComment(
                                    postController.text, widget.forum.id);
                                print(postController.text);
                                postController.clear();
                                Get.back();
                              },
                              icon: Icon(Icons.send)),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xffF6F8FD)),
                ),
              )
            ]));
  }
}
