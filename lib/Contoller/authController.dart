import 'package:apartment_management_system/Contoller/userController.dart';
import 'package:apartment_management_system/Model/resident.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'bindings/root.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.uid;

  @override
  void onInit() {
    _user.bindStream(_auth.userChanges());
  }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //create user in RTDB
      UserModel _user =
          UserModel(id: authResult.user?.uid, email: email, name: name);
      await UserController().createNewUser(_user);
      Get.find<UserController>().user = _user;
      Get.offAll(Root());
    } catch (e) {
      Get.snackbar("Eroor Creating User", 'message',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Trying To loGin ' + authResult.user!.uid);
      Get.find<UserController>().user =
          await UserController().getUser(authResult.user!.uid);
    } catch (e) {
      Get.snackbar("Eroor Login", 'message',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar("Eroor SignOut", 'message',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}