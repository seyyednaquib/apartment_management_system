import 'package:get/get.dart';

class EventModel {
  final String content;
  final String title;
  final String date;
  final String ImgUrl;

  EventModel(
      {required this.content,
      required this.title,
      required this.date,
      required this.ImgUrl});

  factory EventModel.fromRTDB(Map<String, dynamic> data) {
    return EventModel(
        content: data['content'] ?? 'drink',
        title: data['title'] ?? 'UnknownSs',
        date: data['dateCreated'] ?? 'TIME',
        ImgUrl: data['ImgUrl'] ??
            'https://upload.wikimedia.org/wikipedia/commons/1/14/The_Event_2010_Intertitle.svg');
  }
}
