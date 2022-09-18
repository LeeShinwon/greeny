import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Withdrawal extends StatelessWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        //centerTitle: false,
        elevation: 0,

      ),
      body: Center(
        child: Text('서비스 배포시 사용 가능하도록 하겠습니다.'),
      ),
    );
  }
}
