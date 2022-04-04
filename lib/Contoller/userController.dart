import 'package:apartment_management_system/Model/resident.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;
  void clear() {
    _userModel.value = UserModel();
  }

  final _db = FirebaseDatabase.instance.ref();
  Future<void> createNewUser(UserModel user) async {
    try {
      await _db
          .child('users/')
          .child('${user.id}/')
          .set({'name': user.name, 'email': user.email}).then(
              (_) => print('user Saved'));
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUser(String id) async {
    try {
      final DataSnapshot userData = await _db.child('users/').child(id).get();
      return UserModel.fromRTDB(userData.value as dynamic);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
