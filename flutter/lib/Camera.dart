import 'package:eolleroad/Option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Camera extends StatelessWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A2A2),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              bottom: MediaQuery.of(context).size.height * 0.1),
          //alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            child: Text('얼레길',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30)),
          ),
        ),
      ]),
    );
  }
}
