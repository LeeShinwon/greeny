import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/ui/main/mypage/my_write_page.dart';
import 'package:greeny/ui/main/mypage/withdrawal.dart';
import 'package:greeny/ui/registration/login/login_view.dart';

import '../../../util/screen_size.dart';
import 'license.dart';
import 'package:greeny/util/storage.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    
    final user = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color(0xff319E31),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0) // POINT
                        ),
                      ),
                      child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child:StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.data!.get('photoURL')==''){
                                    return Image.asset('assets/images/profile.png', width: 120,height: 120,fit: BoxFit.fitHeight,);
                                  }
                                  return FutureBuilder(
                                    future: storage.downloadURL(snapshot.data!.get('photoURL')),
                                    builder: (BuildContext context, AsyncSnapshot<String> snap) {
                                      if (snap.connectionState == ConnectionState.done && snap.hasData) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          child: Expanded(
                                            child: Image.network(
                                              snap.data!,
                                              width: 100,height: 100,fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      }
                                      if (snap.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff319E31)),
                                          ), //???????????? ???????????? ????????????
                                        );
                                      }
                                      return Image.asset('assets/images/profile.png', width: 120,height: 120,fit: BoxFit.fitHeight,);
                                    },
                                  );
                                }
                            ),

                          ) )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user!.displayName.toString(), style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 25,
                        ),),
                        Text(user!.email.toString(), style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15,height: 2
                        ),),
                        TextButton(onPressed: () {  },child: Row(
                          children: [
                          Icon(CupertinoIcons.pencil, color: Color(0xff319E31),),
                          Text('??????', style: TextStyle(
                            color: Color(0xff319E31),
                          ),),
                        ],),

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                width: getScreenWidth(context),
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('?????? ?????? ?????????', style: TextStyle(
                        fontWeight: FontWeight.w700,fontSize: 20,
                      ),),
                    ),
                    Row(
                      children: [
                        Container(
                          width: getScreenWidth(context)-105,
                          height: 35,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('user/'+user!.uid+'/mygreeny').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color> (Color(0xff319E31)),
                                    ), //???????????? ???????????? ????????????
                                  );
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:(BuildContext context,int index){
                                    var doc = snapshot.data?.docs[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Container(
                                        height: 35,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Center(child: Text(doc?.get('location'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                                        ),
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Color(0xff319E31),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                );
                              }
                          ),
                        ),
                        OutlinedButton(
                          onPressed: (){

                          },
                          child: Text('??????', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 0.5,color: Colors.black12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                            elevation: 5,
                            backgroundColor: Colors.white,

                          ),
                        ),
                      ],

                    ),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff319E31),
                boxShadow: [
                  BoxShadow(color: Colors.green, spreadRadius: 2),
                ],
              ),
              width: getScreenWidth(context)-40,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/greeny.png', width: 30,),
                  TextButton(onPressed: (){
                    Get.to(MyWritePage());
                  }, child: Text('?????? ??? ??? ????????????', style: TextStyle(
                      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600
                  ),)),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: getScreenWidth(context)-40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: (){
                    Get.to(License());

                  }, child: Text('????????????', style: TextStyle(
                      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600
                  ),)),
                  Divider(indent:10, endIndent: 10),
                  TextButton(onPressed: (){
                    Get.to(Withdrawal());

                  }, child: Text('???????????? ??????', style: TextStyle(
                      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600
                  ),)),
                  Divider(indent:10, endIndent: 10),
                  TextButton(onPressed: (){
                    Get.to(Withdrawal());

                  }, child: Text('?????? ??????', style: TextStyle(
                      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600
                  ),)),
                  Divider(indent:10, endIndent: 10),
                  TextButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Get.to(LoginView());
                  }, child: Text('????????????', style: TextStyle(
                      color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600
                  ),)),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
