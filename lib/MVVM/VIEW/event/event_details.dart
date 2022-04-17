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
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        Text(
          event.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '-',
                        style: TextStyle(color: Colors.white),
                      ))),
              Expanded(flex: 1, child: Text(''))
            ],
          ),
        ),
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
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
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
            child: Text(
              event.date,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );

    final bottomContentText = Text(
      event.content,
      style: TextStyle(fontSize: 18.0),
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
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
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
