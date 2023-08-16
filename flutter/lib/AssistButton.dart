import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class AssistButton extends StatefulWidget {
  final String speakmessage;

  AssistButton({required this.speakmessage});

  @override
  _AssistButtonState createState() => _AssistButtonState();
}

class _AssistButtonState extends State<AssistButton> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          _speak(widget.speakmessage); //speakmessage 사용
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.95, 70),
          backgroundColor: Colors.white,
        ),
        child: Text("Press me"), // 버튼에 텍스트 추가
      ),
    );
  }
}