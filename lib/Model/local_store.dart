import 'package:get/get.dart';

class StoreModel {
  final String content;
  final String title;
  final String address;

  final String ImgUrl;

  StoreModel(
      {required this.content,
      required this.address,
      required this.title,
      required this.ImgUrl});

  factory StoreModel.fromRTDB(Map<String, dynamic> data) {
    return StoreModel(
        content: data['content'] ?? 'unk',
        title: data['title'] ?? 'unk',
        address: data['address'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ?? 'unk');
  }
}
