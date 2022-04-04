import 'package:get/get.dart';

class AnnouncementModelTEMP {
  final String content;
  final String title;
  final String date;

  AnnouncementModelTEMP(
      {required this.content, required this.title, required this.date});

  factory AnnouncementModelTEMP.fromRTDB(Map<String, dynamic> data) {
    return AnnouncementModelTEMP(
        content: data['content'] ?? 'drink',
        title: data['title'] ?? 'UnknownSs',
        date: data['time'] ?? 'unknownTIME');
  }
}
