import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel({this.id, this.name, this.email});

  UserModel.fromRTDB(dynamic data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }
}
