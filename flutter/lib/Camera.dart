import 'package:camera/camera.dart';
import 'package:eolleroad/Option.dart';
import 'package:eolleroad/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Camera extends StatefulWidget {
  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  bool isWorking = false;
  String result = "";

  late CameraController cameraController;
  CameraImage? imgCamera; // Nullable로 변경

  @override
  void initState() {
    super.initState();
    initCamera(); // 카메라 초기화는 initState에서 호출
  }

  initCamera() {
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
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("")),
            ),
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
                                  aspectRatio:
                                      cameraController.value.aspectRatio,
                                  child: CameraPreview(cameraController),
                                )),
                    ),
                  ),
                ])
              ],
            )),
      )),
    );
  }
}
