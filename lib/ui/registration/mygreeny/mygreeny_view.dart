import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

class MyGreenyView extends StatelessWidget {
  MyGreenyView({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _nicknameController = new TextEditingController(text: FirebaseAuth.instance.currentUser?.displayName);
    late String _nickname;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('프로필 설정',
          style: TextStyle(color: Colors.black, fontSize: width > 400 ? 17:14, fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
          size: 15,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: height - kToolbarHeight*2,//appbar 높이 빼기
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Image.network(user?.photoURL.toString()??''),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:30),
                        child: Image.asset('assets/images/profile.png',width: width>400?150:100,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width*0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('닉네임',style: TextStyle(
                              height: 5,
                              fontWeight: FontWeight.w600,
                              fontSize: width > 400 ? 17:14,
                            ),),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: _nicknameController,
                              validator: (value){
                                if(value!.trim().isEmpty){
                                  return '닉네임을 입력하세요.';
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                _nickname = value as String;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff319E31), width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                              ),
                              keyboardType:TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      width: width*0.8,
                      height: width > 400 ? 50 : 40,
                      child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              FirebaseFirestore.instance.collection('user').doc(user!.uid).update(
                                  {
                                    'name':_nickname,
                                  });
                              //Get.to();
                            }
                          },
                          child: Text('다음으로 넘어가기', style: TextStyle(fontSize: width > 400 ? 17:14,
                            fontWeight: FontWeight.w600,),),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff319E31),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),

                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
