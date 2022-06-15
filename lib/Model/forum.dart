import 'package:get/get.dart';

class ForumModel {
  final String content;
  final String id;
  final String title;
  final String ImgUrl;
  final String residentId;
  final String timeStamp;
  final String residentName;

  ForumModel(
      {required this.content,
      required this.title,
      required this.residentId,
      required this.id,
      required this.ImgUrl,
      required this.timeStamp,
      required this.residentName});

  factory ForumModel.fromRTDB(Map<String, dynamic> data) {
    return ForumModel(
        content: data['content'] ?? 'unk',
        id: data['id'] ?? 'unk',
        title: data['title'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ?? 'unk',
        residentId: data['residentId'] ?? 'unk',
        timeStamp: data['timeStamp'] ?? 'unk',
        residentName: data['residentName'] ?? 'unk');
  }
}

class ThreadModel {
  final String content;
  final String id;
  final String forumId;
  final String residentName;
  final String residentId;
  final String timeStamp;

  ThreadModel(
      {required this.content,
      required this.forumId,
      required this.residentId,
      required this.id,
      required this.residentName,
      required this.timeStamp});

  factory ThreadModel.fromRTDB(Map<String, dynamic> data) {
    return ThreadModel(
        content: data['content'] ?? 'unk',
        id: data['id'] ?? 'unk',
        forumId: data['title'] ?? 'unk',
        residentName: data['residentName'] ?? 'unk',
        residentId: data['residentId'] ?? 'unk',
        timeStamp: data['timeStamp'] ?? 'unk');
  }
}
