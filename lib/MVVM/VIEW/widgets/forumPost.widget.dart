import 'package:apartment_management_system/MVVM/VIEW/forum/forum_details.dart';
import 'package:apartment_management_system/Model/forum.dart';
import 'package:avatars/avatars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class PostWidget extends StatelessWidget {
  final ForumModel forum;
  const PostWidget({Key? key, required this.forum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('residents/' + forum.residentId)
          .onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;

        return Column(children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Avatar(
                    shape: AvatarShape.circle(28),
                    name: (forum.residentName == '')
                        ? 'UM'
                        : forum.residentName.toUpperCase(),
                    placeholderColors: [
                      Color.fromARGB(255, 39, 28, 28),
                      Color.fromARGB(230, 125, 13, 253),
                      //...
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForumPageDetails(forum: forum));
                  },
                  child: Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            forum.residentName
                                .substring(0, forum.residentName.indexOf('@'))
                                .toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: Text(forum.content),
                      ),
                      (forum.ImgUrl != '')
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 8.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                  forum.ImgUrl,
                                  height: 200,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        Jiffy(Jiffy.unixFromMillisecondsSinceEpoch(
                                int.parse(forum.timeStamp)))
                            .fromNow(),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
                ),
              ]),
          Container(
            margin: EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width - 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]);
      },
    );
  }
}
