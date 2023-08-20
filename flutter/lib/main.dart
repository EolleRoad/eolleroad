import 'package:eolleroad/Home.dart';
import 'package:eolleroad/Navi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

import 'BusStop.dart';
import 'Camera.dart';
import 'Option.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/', //initialRoute 설정해야됨
      getPages: [
        GetPage(name: '/', page: () => Option()),
        GetPage(name: '/busStop', page: () => BusStop()),
        GetPage(name: '/camera', page: () => Camera()),
        GetPage(name: '/navi', page: () => NavigationScreen()),
      ],
      home: const Home(),
    );
  }
}