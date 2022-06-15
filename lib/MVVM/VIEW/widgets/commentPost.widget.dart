import 'package:apartment_management_system/MVVM/VIEW/forum/forum_details.dart';
import 'package:apartment_management_system/Model/forum.dart';
import 'package:avatars/avatars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CommentWidget extends StatelessWidget {
  final ThreadModel comment;
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('residents/' + comment.residentId)
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
                    name: (comment.residentName == '')
                        ? 'UM'
                        : comment.residentName.toUpperCase(),
                    placeholderColors: [
                      Color.fromARGB(255, 39, 28, 28),
                      Color.fromARGB(230, 125, 13, 253),
                      //...
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          comment.residentName
                              .substring(0, comment.residentName.indexOf('@'))
                              .toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Text(comment.content),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      Jiffy(Jiffy.unixFromMillisecondsSinceEpoch(
                              int.parse(comment.timeStamp)))
                          .fromNow(),
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ]),
          Container(
            width: MediaQuery.of(context).size.width,
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
