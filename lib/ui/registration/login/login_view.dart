import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greeny/auth.dart';
import 'package:greeny/ui/registration/login/google_login.dart';

import '../../../data/repository/login.dart';
import 'kakao_login.dart';
import 'kakao_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final kakaoViewModel = KakaoViewModel(KakaoLogin());
  final googleViewModel = GoogleLogin();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/three_leaves.png',
              width: width > 400 ? 200 : 130,
            ),
            Text(
              '환경 지킴이',
              style: TextStyle(
                fontSize : width > 400 ? 15 : 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                height: 1.5,
              ),
            ),
            Text(
              '그린이',
              style: TextStyle(
                fontSize: width > 400 ? 50 : 35,
                //fontFamily: 'NanumGothicFontBold',
                //fontWeight: FontWeight.w500,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            Image.asset(
              'assets/images/greeny.png',
              width: width > 400 ? 100 : 70,
            ),


            //naver login 보류


            Padding(
              padding: EdgeInsets.only(top: width > 400 ? 100 : 50,),
              child: SizedBox(
                width: width*0.8,
                height: width > 400 ? 50 : 40,
                child: ElevatedButton(
                    onPressed: () async {
                      await kakaoViewModel.login();
                      Get.to(Authenticaton());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xffFEE600),
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      //padding: EdgeInsets.all(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'assets/images/kakao.png',
                            height: width > 400 ? 30: 25,
                          ),
                        ),
                        Text(
                          '카카오로 시작하기',
                          style: TextStyle(
                            fontSize: width > 400 ? 17:14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                width: width*0.8,
                height: width > 400 ? 50 : 40,
                child: ElevatedButton(
                    onPressed: () async {
                      await googleViewModel.login();

                      Get.to(Authenticaton());

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xffFFFFFF),
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      //padding: EdgeInsets.all(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Image.asset(
                            'assets/images/google.png',
                            height: width > 400 ? 33: 28,
                          ),
                        ),
                        Text(
                          '구글로 시작하기',
                          style: TextStyle(
                            fontSize: width > 400 ? 17:14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
