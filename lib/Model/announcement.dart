import 'package:get/get.dart';

class AnnouncementModel {
  final String content;
  final String title;
  final String important;
  final String date;
  final String ImgUrl;

  AnnouncementModel(
      {required this.content,
      required this.title,
      required this.important,
      required this.date,
      required this.ImgUrl});

  factory AnnouncementModel.fromRTDB(Map<String, dynamic> data) {
    return AnnouncementModel(
        content: data['content'] ?? 'unk',
        title: data['title'] ?? 'unk',
        important: data['important'] ?? 'unk',
        date: data['dateCreated'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ??
            'http://clipart-library.com/images/8cEjdgeXi.jpg');
  }
}
