import 'package:get/get.dart';

class AnnouncementModel {
  final String content;
  final String title;
  final String date;
  final String ImgUrl;

  AnnouncementModel(
      {required this.content,
      required this.title,
      required this.date,
      required this.ImgUrl});

  factory AnnouncementModel.fromRTDB(Map<String, dynamic> data) {
    return AnnouncementModel(
        content: data['content'] ?? 'unk',
        title: data['title'] ?? 'unk',
        date: data['dateCreated'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ??
            'http://clipart-library.com/images/8cEjdgeXi.jpg');
  }
}
