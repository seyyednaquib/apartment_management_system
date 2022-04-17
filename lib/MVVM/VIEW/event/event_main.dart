import 'package:apartment_management_system/Contoller/event_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_details.dart';
import 'package:apartment_management_system/Model/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Contoller/bindings/root.dart';

class EventPageMain extends StatefulWidget {
  const EventPageMain({Key? key}) : super(key: key);

  @override
  State<EventPageMain> createState() => _EventPageMainState();
}

class _EventPageMainState extends State<EventPageMain> {
  @override
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
        'Event',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        )
      ],
    );

    final makeBody = StreamBuilder(
        stream: EventController().getEventStream(),
        builder: (context, snapshot) {
          final tileList = <Card>[];
          if (snapshot.hasData) {
            final allEvents = snapshot.data as List<EventModel>;
            allEvents.sort((b, a) => a.date.compareTo(b.date));
            tileList.addAll(allEvents.map((nextEvent) {
              return Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(227, 252, 248, 248)),
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.black))),
                        child: const Icon(Icons.event_outlined,
                            color: Colors.black),
                      ),
                      title: Text(
                        nextEvent.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        'Management',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      trailing: Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(nextEvent.ImgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => EventDetails(
                              event: nextEvent,
                            ));
                      }),
                ),
              );
            }));
          }
          return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: tileList);
        });

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
