import 'package:eolleroad/AssistButton.dart';
import 'package:eolleroad/BusStop.dart';
import 'package:eolleroad/Navi.dart';
import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:eolleroad/Camera.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final String routeName;

  const OptionButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(routeName);
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.white,
          fixedSize: Size(
            MediaQuery.of(context).size.width * 0.4,
            MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '얼레길',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
          Row(children: [
            OptionButton(
              buttonColor: Colors.blue,
              buttonText: '신호등',
              routeName: 'camera',
            ),
            OptionButton(
              buttonColor: Colors.red,
              buttonText: '도보',
              routeName: 'camera',
            ),
          ]),
          Row(children: [
            OptionButton(
              buttonColor: Colors.yellow,
              buttonText: '지하철',
              routeName: 'navi',
            ),
            OptionButton(
              buttonColor: Colors.green,
              buttonText: '버스',
              routeName: 'camera',
            ),
          ]),
          Expanded( // 화면 맨 아래에 위치하도록
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: AssistButton(speakmessage: '원하시는 기능에 따라, 버튼을 선택해주세요.'),
            ),
          ),
        ],
      ),
    );
  }
}
