import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:eolleroad/Camera.dart';
import 'package:get/get.dart';

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  Widget optionButton(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.to(Camera());
          },
          style: ElevatedButton.styleFrom(
              primary: Color(0xff231FAD),
              onPrimary: Colors.white,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.4,
                  MediaQuery.of(context).size.height * 0.4)),
          child: Text(
            '카\n메\n라',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
        Spacer(flex: 1),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Color(0xffF6B818),
              onPrimary: Colors.black,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.4,
                  MediaQuery.of(context).size.height * 0.4)),
          child: Text('길\n안\n내',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.2,
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
        Container(child: optionButton(context)),

        //슬라이드 버튼_삭제하면 됨
        HorizontalSlidableButton(
          width: MediaQuery.of(context).size.width / 3,
          buttonWidth: 60.0,
          color: Colors.white,
          buttonColor: Color(0xffF6B818),
          dismissible: false,
          label: Center(child: Text('')),
          onChanged: (value) => (value) {},
        ),
      ]),
    );
  }
}
