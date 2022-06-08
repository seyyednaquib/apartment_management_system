import 'package:get/get.dart';

class StoreModel {
  final String content;
  final String name;
  final String coordinate;
  final String ImgUrl;
  final String category;

  StoreModel(
      {required this.content,
      required this.coordinate,
      required this.category,
      required this.name,
      required this.ImgUrl});

  factory StoreModel.fromRTDB(Map<String, dynamic> data) {
    return StoreModel(
        content: data['content'] ?? 'unk',
        name: data['name'] ?? 'unk',
        coordinate: data['coordinate'] ?? 'unk',
        ImgUrl: data['ImgUrl'] ?? 'unk',
        category: data['category'] ?? 'unk');
  }
}
