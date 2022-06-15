import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:apartment_management_system/Contoller/forum_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcment_details.dart';
import 'package:apartment_management_system/MVVM/VIEW/forum/forum_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/forumPost.widget.dart';
import 'package:apartment_management_system/Model/forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ForumPageMain extends StatefulWidget {
  const ForumPageMain({Key? key}) : super(key: key);

  @override
  State<ForumPageMain> createState() => _ForumPageMainState();
}

class _ForumPageMainState extends State<ForumPageMain> {
  TextEditingController postController = TextEditingController();
  @override
  bool shows = false;
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      leading: InkWell(
        onTap: () {
          Get.offAll(Root());
        },
        child: const Icon(Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      title: const Text(
        'Forum Melawis',
        style: TextStyle(color: Colors.black),
      ),
    );

    final makeBody = StreamBuilder(
        stream: ForumController().getForumStream(),
        builder: (context, snapshot) {
          final tileList = <PostWidget>[];
          if (snapshot.hasData) {
            final allForum = snapshot.data as List<ForumModel>;
            allForum.sort((b, a) => a.timeStamp.compareTo(b.timeStamp));
            tileList.addAll(allForum.map((forumTemp) {
              return PostWidget(
                forum: forumTemp,
              );
            }));
          }
          return ListView(
              scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              children: tileList);
        });

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: topAppBar,
        body: Stack(children: [
          Expanded(child: makeBody),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreateForumPage());
            setState(() {
              shows = true;
            });
          },
          backgroundColor: Color.fromARGB(230, 125, 13, 253),
          elevation: 2,
          child: const Icon(Icons.add),
        ));
  }
}
