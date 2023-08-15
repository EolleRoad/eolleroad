import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _spokenText = '버튼을 누르고 음성을 입력';
  bool _isListening = false;
  int _staticTimeout = 2; // 정적 상태 타임아웃 (2초)
  int _elapsedTime = 0;

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
      },
      onError: (error) {
      },
    );

    if (available) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
            _resetStaticTimer(); // 음성인식 후 타이머 리셋
          });
        },
      );
    } else {
      print("Speech recognition not available");
    }
  }

  void _resetStaticTimer() {
    setState(() {
      _elapsedTime = 0;
    });
  }

  void _startStaticTimer() {
    _resetStaticTimer();
    // 1초마다 정적 시간을 증가시키는 타이머를 시작합니다.
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
        if (_elapsedTime >= _staticTimeout) {
          _stopListening(); // 정적 타임아웃이 발생하면 음성 입력 중지
          timer.cancel(); // 타이머 중지
        }
      });
    });
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }


  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
      _startStaticTimer();
    }
    setState(() {
      _isListening = !_isListening; // 버튼 상태 변경
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2),
      appBar: AppBar(
        title: Text('얼레길', textAlign: TextAlign.center),
        backgroundColor: Color(0xFF2A2A2),
      ),
      body: Column(
        children: [
          Departure(),
          Arrival(),
          ElevatedButton(
            onPressed: _isListening ? _stopListening : _toggleListening,
            style: ElevatedButton.styleFrom(backgroundColor: _isListening ? Color(0xff231FAD) : Color(0xffF6B818),),
            child: Icon(
              _isListening ? Icons.stop : Icons.mic,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget Departure() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text('출발지',
                style: TextStyle(color: Colors.white, fontSize: 40)),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xffF6B818))),
              child: Text('부산광역시 남구 용소로 45',
                  style: TextStyle(color: Colors.white, fontSize: 25)))
        ],
      ),
    );
  }

  Widget Arrival() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text('도착지',
                style: TextStyle(color: Colors.white, fontSize: 40)),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xffF6B818))),
              child: Text('$_spokenText',
                  style: TextStyle(color: Colors.white, fontSize: 25)))
        ],
      ),
    );
  }
}
