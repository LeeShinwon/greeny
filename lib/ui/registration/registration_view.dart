import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/three_leaves.png',width: 200,),
              const Text('환경 지킴이',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                height: 2.5,
              ),),
              const Text('그린이',
              style: TextStyle(
                fontSize: 50,
                //fontFamily: 'NanumGothicFontBold',
                //fontWeight: FontWeight.w500,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),),
              Image.asset('assets/images/greeny.png',width: 100,),

              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xff00C73C),
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.all(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset('assets/images/naver.png', height: 35,),
                          ),
                          Text(
                            '네이버로 시작하기',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xffFEE600),
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.all(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset('assets/images/kakao.png', height: 30,),
                          ),
                          Text(
                            '카카오로 시작하기',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 300,
                  height: 50,

                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xffFFFFFF),
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.all(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Image.asset('assets/images/google.png', height: 33,),
                          ),
                          Text(
                            '구글로 시작하기',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
