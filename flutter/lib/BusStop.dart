import 'package:eolleroad/AssistButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BusStop extends StatefulWidget {
  const BusStop({Key? key}) : super(key: key);

  @override
  State<BusStop> createState() => _BusStopState();
}

Widget BusNumber() {
  return Container(
    alignment: Alignment.center,
    decoration:
        BoxDecoration(border: Border.all(width: 1, color: Color(0xffF6B818))),
    margin: EdgeInsets.only(top: 30, left: 20, right: 20),
    child: Text('500', style: TextStyle(fontSize: 50, color: Colors.white)),
  );
}

/*Widget StopButton() {
  return Container(
    margin: EdgeInsets.only(top: 80),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(250, 250),
            shape: const CircleBorder(),
            backgroundColor: Color(0xff231FAD),

          ),
          child: Text('하차', style: TextStyle(fontSize: 80, color: Color(0xffF6B818)),)));
}*/

Widget BusStation(){
  return Container(
    margin: EdgeInsets.only(right: 30, left: 30),
    decoration:
    BoxDecoration(border: Border.all(width: 1, color: Color(0xffF6B818))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('이번역', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text('못골시장', style: TextStyle(color: Colors.white, fontSize: 40)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('다음역', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text('대연역', style: TextStyle(color: Colors.white, fontSize: 40)),
            )
          ],
        )
      ],
    ),
  );
}

class _BusStopState extends State<BusStop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2),
      appBar: AppBar(
        title: Text('얼레길', textAlign: TextAlign.center),
        backgroundColor: Color(0xFF2A2A2),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BusNumber(),
          StopButton(),
          BusStation(),
          AssistButton(),
        ],
      ),
    );
  }
}

//하차버튼
class StopButton extends StatefulWidget {
  @override
  _StopButtonState createState() => _StopButtonState();
}

class _StopButtonState extends State<StopButton> {
  FlutterTts flutterTts = FlutterTts();
  bool isButtonPressed = false;

  void _onButtonPressed() {
    setState(() {
      isButtonPressed = !isButtonPressed;
    });

    // 음성 출력
    _speak(isButtonPressed ? "하차버튼을 눌렀습니다" : "하차가 취소되었습니다.");
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR"); // 음성 언어 설정
    await flutterTts.setPitch(1); // 음성 피치 설정 (0.5 ~ 2.0)
    await flutterTts.speak(text); // 텍스트를 음성으로
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05, bottom: MediaQuery.of(context).size.height*0.05),
      child: ElevatedButton(
        onPressed: _onButtonPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 250),
          shape: const CircleBorder(),
          backgroundColor: isButtonPressed ? Color(0xff231FAD) : Color(0xffF6B818),
        ),
        child: Text(
          '하차',
          style: TextStyle(fontSize: 80, color: isButtonPressed ? Color(0xffF6B818) : Color(0xff231FAD)),
        ),
      ),
    );
  }
}