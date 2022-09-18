import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/data/model/user_model.dart';
import 'package:greeny/ui/main/home/home_detail_page/home_detail_page.dart';
import 'package:greeny/ui/main/home/home_first_page/home_page_card.dart';

import '../../../../data/model/greentrade_model.dart';

class HomePageList extends StatefulWidget {
  HomePageList(this.myChoice, {Key? key}) : super(key: key);
  MyGreeny myChoice;

  @override
  State<HomePageList> createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {

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

  /*List<MyGreeny> getMyChoiceList(AsyncSnapshot snapshot){
    List<MyGreeny> mygreeny = <MyGreeny>[];

    for(MyGreeny m in snapshot.data){
      if(m.city == widget.myChoice.city && m.location == widget.myChoice.location && m.town == widget.myChoice.town){
        mygreeny.add(m);
      }
    }
    print('mygreeny');
    print(mygreeny);
    return mygreeny;
  }*/

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('greenTrade').orderBy('registrationTime', descending: false).snapshots(),
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
    );
  }
}
