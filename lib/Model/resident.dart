import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? residentId;
  String? rName;
  String? rPhone;
  String? rUnit;
  String? rEmail;

  UserModel(
      {this.residentId, this.rName, this.rPhone, this.rEmail, this.rUnit});

  UserModel.fromRTDB(dynamic data) {
    residentId = data['residentId'];
    rName = data['rName'];
    rPhone = data['rphone'];
    rEmail = data['rEmail'];
    rUnit = data['rUnit'];
  }
}
