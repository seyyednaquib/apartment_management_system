import 'package:get/get.dart';

class EventModel {
  final String content;
  final String title;
  final String dateAndTime;
  final String dateCreated;
  final String ImgUrl;

  EventModel(
      {required this.content,
      required this.dateAndTime,
      required this.title,
      required this.dateCreated,
      required this.ImgUrl});

  factory EventModel.fromRTDB(Map<String, dynamic> data) {
    return EventModel(
        content: data['content'] ?? 'unk',
        title: data['title'] ?? 'unk',
        dateAndTime: data['dateAndTime'] ?? 'unk',
        dateCreated: data['dateCreated'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ?? 'unk');
  }
}
