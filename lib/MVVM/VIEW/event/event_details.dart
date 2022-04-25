import 'package:apartment_management_system/Model/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({Key? key, required this.event}) : super(key: key);
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 40.0),
        SizedBox(height: 30.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(event.ImgUrl),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(
            left: 40.0,
            bottom: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
              child: Text(
                event.dateCreated,
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );

    final readButton = const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      // child: RaisedButton(
      //   onPressed: () => {},
      //   color: Color.fromRGBO(58, 66, 86, 1.0),
      //   child: const Text("OPEN PDF", style: TextStyle(color: Colors.white)),
      // )
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            child: Text(
              event.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 40.0),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 30,
            width: 380,
            child: Text(
              'DATE AND TIME ' + event.dateAndTime.toUpperCase(),
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w300,
                  fontSize: 20.0),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 200,
            width: 380,
            child: Text(
              event.content,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 18.0),
            ),
          ),
          readButton
        ],
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
