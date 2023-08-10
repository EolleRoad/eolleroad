import 'package:eolleroad/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vision/flutter_vision.dart';

FlutterVision vision = FlutterVision();

void main() async {
  await initFlutterVision();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Home(),
    );
  }
}

Future<void> initFlutterVision() async {
  FlutterVision vision = FlutterVision();

  await vision.loadYoloModel(
    labels: 'assets/labelss.txt',
    modelPath: 'assets/yolov5n.tflite',
    modelVersion: "yolov5",
    numThreads: 1,
    useGpu: false,
  );
}
