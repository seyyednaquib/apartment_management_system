import 'package:apartment_management_system/Contoller/bindings/authBinding.dart';
import 'package:apartment_management_system/Contoller/bindings/root.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("this massage from bg");

  if (message.data.isEmpty) {
    print(message.notification!.title);
    print(message.notification!.body);
  } else
    print(message.data['route']);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: Root(),
      // theme: ThemeData.dark(),
      theme: ThemeData(
          primaryColor: Color.fromARGB(
        255,
        255,
        255,
        255,
      )),
    );
  }
}

//for notifications purposes
getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print(token! + ' token ni bosq');
}
