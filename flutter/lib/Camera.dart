import 'dart:math';
import 'package:camera/camera.dart';
import 'package:eolleroad/Option.dart';
import 'package:eolleroad/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import 'package:slidable_button/slidable_button.dart';

class Camera extends StatefulWidget {
  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  bool isWorking = false;
  String result = "";
  late CameraController cameraController;
  CameraImage? imgCamera; // Nullable로 변경

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/mobilenet_v1_1.0_224.tflite",
        labels: "assets/mobilenet_v1_1.0_224.txt",
      );
    } catch (e) {
      print("Model loading error: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Model Loading Error"),
          content: Text(
              "Failed to load the model. Please make sure the model files are in the correct location."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    if (cameras.isNotEmpty) {
      initCamera();
    }
  }

  initCamera() {
    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      cameraController.initialize().then((value) {
        if (!mounted) {
          return;
        }

        setState(() {
          cameraController.startImageStream((imageFromStream) {
            if (!isWorking) {
              setState(() {
                isWorking = true;
                imgCamera = imageFromStream;
                print('hello');
                runModelOnStreamFrames();
              });
            }
          });
        });
      }).catchError((error) {
        print("Camera initialization error: $error");
        // TODO: 에러 처리 로직 추가 (메시지 표시 등)
      });
    } else {
      print("No cameras available.");
      // TODO: 카메라 없음 처리 로직 추가 (메시지 표시 등)
    }
  }

  runModelOnStreamFrames() async {
    try {
      if (imgCamera != null) {
        var recognitions = await Tflite.runModelOnFrame(
          bytesList: imgCamera!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: imgCamera!.height,
          imageWidth: imgCamera!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 3,
          threshold: 0.1,
        );
        result = "";

        recognitions!.forEach((response) {
          result += response["label"] +
              "  " +
              (response["confidence"] as double).toStringAsFixed(2) +
              "\n\n";
        });
        setState(() {
          result;
        });
        isWorking = false;
      }
    } catch (e) {
      print("Model execution error: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Model Execution Error"),
          content: Text("Failed to run the model. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() async {
    super.dispose();

    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
            child: Column(
          children: [
            Stack(children: [
              Center(
                //alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    initCamera();
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 35),
                      height: 270,
                      width: 360,
                      child: imgCamera == null
                          ? Container(
                              height: 270,
                              width: 360,
                              child: Icon(Icons.photo_camera_front,
                                  color: Colors.blueAccent, size: 40),
                            )
                          : AspectRatio(
                              aspectRatio: cameraController.value.aspectRatio,
                              child: CameraPreview(cameraController),
                            )),
                ),
              ),
            ]),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 55.0),
                  child: SingleChildScrollView(
                      child: Text(
                    result,
                    style: TextStyle(
                        backgroundColor: Colors.black87,
                        fontSize: 30.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ))),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: HorizontalSlidableButton(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 80,
                buttonWidth: 180.0,
                color: Colors.white,
                buttonColor: Color(0xffF6B818),
                dismissible: false,
                label: Center(
                    child: Text('안내종료',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))),
                onChanged: (value) => (value) {},
              ),
            ),
          ],
        )),
      )),
    );
  }
}
