import 'package:apartment_management_system/Contoller/event_controller.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_create.dart';
import 'package:apartment_management_system/MVVM/VIEW/announcement_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_details.dart';
import 'package:apartment_management_system/MVVM/VIEW/event/event_main.dart';
import 'package:apartment_management_system/MVVM/VIEW/profile/profile.dart';
import 'package:apartment_management_system/MVVM/VIEW/widgets/appbar_widget.dart';
import 'package:apartment_management_system/Model/event.dart';
import 'package:avatars/avatars.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Contoller/announcement_controller.dart';
import '../../Contoller/userController.dart';
import '../../Model/announcement.dart';
import 'announcment_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserController c = Get.put(UserController());
  int choosen_index = 0;
  final String message =
      DateTime.now().hour < 12 ? "Good morning" : "Good afternoon";
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: (() => Get.to(() => Announcement())),
                          child: Icon(Icons.drag_indicator_outlined)),
                      Avatar(
                        onTap: () => Get.to(() => Profile()),
                        shape: AvatarShape.circle(28),
                        name: c.user.rName ?? 'U M',
                        placeholderColors: [
                          Color.fromARGB(255, 39, 28, 28),
                          Color.fromARGB(230, 125, 13, 253),
                          //...
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(c.user.rName ?? '',
                          style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black))
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 214, 213, 213),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                      indicator: BubbleTabIndicator(
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorHeight: 40.0,
                          indicatorColor: Colors.white),
                      tabs: [
                        Text('Announcements'),
                        Text('Events'),
                      ],
                      onTap: (index) {
                        setState(() {
                          choosen_index = index;
                          print(choosen_index);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 100,
                  width: 344,
                  child: (choosen_index == 0)
                      ? StreamBuilder(
                          stream: AnnouncementController()
                              .getAnnouncementStreamForHome(),
                          builder: (context, snapshot) {
                            final announcementContainer = <Padding>[];
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.grey));
                            }
                            if (snapshot.hasData) {
                              final announcements =
                                  snapshot.data as List<AnnouncementModel>;
                              announcements
                                  .sort((b, a) => a.date.compareTo(b.date));
                              announcementContainer
                                  .addAll(announcements.map((announcement) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 100,
                                      width: 344,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          color: Colors.white54),
                                      child: InkWell(
                                          onLongPress: () {
                                            Get.to(() => AnnouncementDetails(
                                                  announcement: announcement,
                                                ));
                                          },
                                          onTap: () {
                                            Get.to(
                                                () => AnnouncementPageMain());
                                          },
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          announcement.ImgUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: 10,
                                                  top: 15,
                                                  child: Container(
                                                    width: 200,
                                                    height: 50,
                                                    child: Text(
                                                      announcement.title,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                  )),
                                              Positioned(
                                                  left: 10,
                                                  bottom: 15,
                                                  child: Container(
                                                    width: 165,
                                                    height: 20,
                                                    child: Text(
                                                      announcement.date,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: Colors.black),
                                                    ),
                                                  ))
                                            ],
                                          ))),
                                );
                              }));
                            }
                            return ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: announcementContainer);
                          })
                      : StreamBuilder(
                          stream: EventController().getEventStreamForHome(),
                          builder: (context, snapshot) {
                            final eventContainer = <Padding>[];
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.grey,
                              ));
                            }
                            if (snapshot.hasData) {
                              final events = snapshot.data as List<EventModel>;
                              events.sort((b, a) => a.date.compareTo(b.date));
                              eventContainer.addAll(events.map((event) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 100,
                                      width: 344,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [
                                              0.1,
                                              0.5,
                                              0.9,
                                              1.0,
                                            ],
                                            colors: [
                                              Color.fromRGBO(102, 167, 197, 1),
                                              Color.fromRGBO(163, 214, 245, 1),
                                              Color.fromRGBO(102, 167, 197, 1),
                                              Color.fromRGBO(102, 167, 197, 1)
                                            ],
                                          )),
                                      child: InkWell(
                                          onLongPress: () {
                                            Get.to(() => EventDetails(
                                                  event: event,
                                                ));
                                          },
                                          onTap: () {
                                            Get.to(() => EventPageMain());
                                          },
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          event.ImgUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: 10,
                                                  top: 15,
                                                  child: Container(
                                                    width: 200,
                                                    height: 50,
                                                    child: Text(
                                                      event.title,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                  )),
                                              Positioned(
                                                  left: 10,
                                                  bottom: 15,
                                                  child: Container(
                                                    width: 165,
                                                    height: 20,
                                                    child: Text(
                                                      event.date,
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: Colors.black),
                                                    ),
                                                  ))
                                            ],
                                          ))),
                                );
                              }));
                            }
                            return ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: eventContainer);
                          }),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 10, right: 6),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(1, 2), // Shadow position
                              ),
                            ],
                            color: Colors.purple,
                            gradient: new LinearGradient(
                                colors: [Colors.red, Colors.cyan],
                                begin: Alignment.centerRight,
                                end: new Alignment(-1.0, -1.0)),
                          ),
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: new FlutterLogo(
                            size: 200.0,
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
