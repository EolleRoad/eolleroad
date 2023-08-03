import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AssistButton extends StatefulWidget {
  @override
  _AssistButtonState createState() => _AssistButtonState();
}

class _AssistButtonState extends State<AssistButton> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR"); // 음성 언어 설정
    await flutterTts.setPitch(1); // 음성 피치 설정 (0.5 ~ 2.0)
    await flutterTts.speak(text); // 텍스트를 음성으로
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          _speak("이번역은 못골시장, 다음역은 대연역입니다");
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width*0.95,20),
          //shape: const CircleBorder(),
          backgroundColor: Colors.white,
        ),
        child: null,
      ),
    );
  }
}
