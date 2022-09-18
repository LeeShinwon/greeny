import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/model/greentrade_model.dart';
import '../../../data/model/user_model.dart';
import '../home/home_detail_page/home_detail_page.dart';
import '../home/home_first_page/home_page_card.dart';

class MyWritePage extends StatefulWidget {
  MyWritePage({Key? key}) : super(key: key);
  MyGreeny myChoice = new MyGreeny('city', 'location', 'town');

  @override
  State<MyWritePage> createState() => _MyWritePageState();
}

class _MyWritePageState extends State<MyWritePage> {
  final user = FirebaseAuth.instance.currentUser;

  bool isAll() {
    if (widget.myChoice.city == 'city' &&
        widget.myChoice.location == 'location' &&
        widget.myChoice.town == 'town') {
      return true; //전체
    }
    else {
      return false; //선택한 것
    }
  }

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
        title:  Text('내가 쓴 글', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),

      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('greenTrade').orderBy('registrationTime', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff319E31)),
                ), //로딩되는 동그라미 보여주기
              );
            }

            late List<GreenTrade> lgt = <GreenTrade>[];
            late List<MyGreeny> mg = <MyGreeny>[];
            var doc = snapshot.data?.docs;

            for (int i = 0; i < doc!.length; i++) {
              if(doc[i].get('writerId')==user!.uid){
              MyGreeny m = new MyGreeny(
                  doc[i].get('location').toString().split('/')[2],
                  doc[i].get('location').toString().split('/')[6],
                  doc[i].get('location').toString().split('/')[4]);

              Timestamp t = doc[i].get('registrationTime');
              print(doc[i].get('registrationTime'));
              String time = DateTime.fromMicrosecondsSinceEpoch(
                  t.microsecondsSinceEpoch).toString().split(" ")[0];
              print(time);
              time = time.replaceAll("-", ".");

              GreenTrade gt = new GreenTrade(
                  doc[i].get('writerId'),
                  doc[i].get('title'),
                  doc[i].get('content'),
                  doc[i].get('isGreen'),
                  time,
                  doc[i].get('manufacturingDate'),
                  doc[i].get('expiryDate'),
                  doc[i].get('location'),
                  doc[i].get('picture'),
                  doc[i].get('like'),
                  doc[i].get('report'),
                  doc[i].id
              );
              if (m.town == widget.myChoice.town &&
                  m.location == widget.myChoice.location &&
                  m.city == widget.myChoice.city) {
                lgt.add(gt);
                mg.add(m);
              }
              else if (isAll()) {
                lgt.add(gt);
                mg.add(m);
              }
            }
            }

            return ListView.builder(
              itemCount: lgt.length,
              itemBuilder: (BuildContext context,int index) {
                return GestureDetector(
                  child: HomePageCard(lgt[index],mg[index] ),
                  onTap: (){
                    Get.to(HomeDetailPage(lgt[index],mg[index] ));
                  },
                );
              },
              /*separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                }*/
            );
          }
      ),
    );
  }
}
