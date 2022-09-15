import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/ui/registration/profile/profile_view.dart';
import 'package:greeny/util/screen_size.dart';
import 'package:greeny/ui/main/bottomnavigationbar.dart';

import '../../../data/model/city_model.dart';


class MyGreenyView extends StatefulWidget {
  const MyGreenyView({Key? key}) : super(key: key);

  @override
  State<MyGreenyView> createState() => _MyGreenyViewState();
}

class _MyGreenyViewState extends State<MyGreenyView> {

  final user = FirebaseAuth.instance.currentUser;

  int _onTapCity =0;
  int _onTapTown =0;

  List<HashMap<String,String>> myGreeny = <HashMap<String,String>>[];

  int getMyGreenyNum(String location){//doc.get('name')
    HashMap<String,String> myOne = getMyOne(location);
    int num=0;

    for(HashMap<String,String> h in myGreeny){

      if(myOne['city']==h['city']&&myOne['location']==h['location']&&myOne['town']==h['town']){
        return num;
      }
      num++;
    }

    return -1;
  }

  HashMap<String,String> getMyOne(String location){
    HashMap<String,String> myOne = new HashMap<String, String>();
    myOne.putIfAbsent('city', () => city[_onTapCity]);
    myOne.putIfAbsent('town', () => town[_onTapCity][_onTapTown]);
    myOne.putIfAbsent('location', () => location);

    return myOne;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('관심 냉장고 설정',
          style: TextStyle(color: Colors.black, fontSize: getScreenWidth(context) > 400 ? 17:14, fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
          size: 15,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
            child: Text('관심있는 냉장고를 선택해주세요.',
              style: TextStyle(
                fontSize: getScreenWidth(context) > 400 ? 15: 12,
              ),),
          ),
          Container(
            width: getScreenWidth(context),
            height: (getScreenHeight(context)- kToolbarHeight - 17)*0.7,

            decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    width: 1,
                    color: Color(0xff92CC92),
                  ),
                )
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          width:getScreenWidth(context) > 400 ? 70 : 60,
                          child: Center(child: Text('시/도',style: TextStyle(
                            fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                          ),)),
                        ),
                        VerticalDivider(thickness: 1),
                        SizedBox(
                            width: getScreenWidth(context) > 400 ? 120 : 100,
                            child: Center(child: Text('시/구/군',style: TextStyle(
                              fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                            ),))
                        ),
                        VerticalDivider(thickness: 1),
                        SizedBox(width:getScreenWidth(context) > 400 ? getScreenWidth(context)-230 : getScreenWidth(context)-200,
                            child: Center(child: Text('냉장고',style: TextStyle(
                              fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                            ),))
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width:getScreenWidth(context) > 400 ? 70 : 60,
                        height: (getScreenHeight(context)- kToolbarHeight - 17)*0.7-45,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context,int index){
                            return Center(child: GestureDetector(
                              child: Text(city[index],style: TextStyle(
                                fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                                fontWeight: _onTapCity == index ? FontWeight.w800:FontWeight.w500,
                                color: _onTapCity == index ?Color(0xff319E31):Colors.black,
                              ),),
                              onTap: (){
                                setState(() {
                                  _onTapCity = index;
                                });
                              },
                            ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemCount: city.length,
                        ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                          width: getScreenWidth(context) > 400 ? 120 : 100,
                          height: (getScreenHeight(context)- kToolbarHeight - 17)*0.7-45,
                          child: ListView.separated(
                            itemBuilder: (BuildContext context,int index){
                              return GestureDetector(
                                child: Text(town[_onTapCity][index],style: TextStyle(
                                  fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                                  fontWeight: _onTapTown == index ? FontWeight.w800:FontWeight.w500,
                                  color: _onTapTown == index ?Color(0xff319E31):Colors.black,
                                ),),
                                onTap: (){
                                  setState(() {
                                    _onTapTown = index;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: town[_onTapCity].length,
                          ),
                      ),
                      VerticalDivider(thickness: 1),
                      Container(
                          width:getScreenWidth(context) > 400 ? getScreenWidth(context)-230 : getScreenWidth(context)-200,
                          height: (getScreenHeight(context)- kToolbarHeight - 17)*0.7-45,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('map').doc(city[_onTapCity]).collection('town').doc(town[_onTapCity][_onTapTown]).collection('location').snapshots(),
                            //.firestore.collection('town').where("town", isEqualTo: _onTapTown).firestore.collection('location').
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color> (Color(0xff319E31)),
                                    ), //로딩되는 동그라미 보여주기
                                  );
                                }

                              if(snapshot.data!.docs.length == 0){
                                return Center(child: Text('등록된 냉장고 없음'));
                              }
                              else{
                                return ListView.separated(
                                  itemBuilder: (BuildContext context,int index){
                                    var doc = snapshot.data!.docs[index];
                                    //print(doc.get('name'));
                                    return GestureDetector(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(text: doc.get('name'),style: TextStyle(
                                                fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                                                fontWeight: (getMyGreenyNum(doc.get('name'))!=-1) ? FontWeight.w800:FontWeight.w500,
                                                color: (getMyGreenyNum(doc.get('name'))!=-1) ?Color(0xff319E31):Colors.black,
                                              ),),
                                            ),
                                          ),
                                          (getMyGreenyNum(doc.get('name'))!=-1)? Icon(
                                            CupertinoIcons.check_mark,
                                            size: getScreenWidth(context) > 400 ? 15 : 10,
                                          ):Text(''),
                                        ],
                                      ),
                                      onTap: (){
                                        int index = getMyGreenyNum(doc.get('name'));
                                        if(index!=-1){//존재함
                                          myGreeny.removeAt(index);
                                        }else{
                                          HashMap<String,String> myOne = getMyOne(doc.get('name'));
                                          myGreeny.add(myOne);
                                        }
                                        print(myGreeny);
                                        setState(() {
                                          //_onTapTown = index;
                                        });
                                      },
                                    );

                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider();
                                  },
                                  itemCount: snapshot.data!.docs.length ,
                                );
                              }

                            }
                          ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: getScreenWidth(context)>400?40:35,
                        height: getScreenWidth(context)>400?40:35,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Color(0xff319E31),),
                          //color: Colors.amber.shade200,
                              borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(//선택 초기화
                            onPressed: (){
                              setState(() {
                                myGreeny.removeRange(0, myGreeny.length);
                              });
                            },
                            icon: Icon(CupertinoIcons.arrow_clockwise, size: getScreenWidth(context)>400?20:15,),
                        ),
                      ),
                    ),
                    Container(
                      width: getScreenWidth(context)-60,
                      height: getScreenWidth(context)>400?40:35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemBuilder:(BuildContext context,int index){
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.only(left:10),
                                    child: Row(
                                      children: [
                                        Text(myGreeny[index]['location']!,
                                        style: TextStyle(
                                          color: Colors.white,
                                            fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                        IconButton(onPressed: (){
                                          setState(() {
                                            myGreeny.remove(myGreeny[index]);
                                          });

                                        }, icon: Icon(CupertinoIcons.clear_circled_solid,size: getScreenWidth(context) > 400 ? 20 : 15,color: Colors.white,))
                                      ],
                                    ),
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff319E31),
                                  )
                              ),
                            );
                          },
                        itemCount: myGreeny.length ,
                      ),
                    )
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: getScreenWidth(context)*0.8,
                    height: getScreenWidth(context)> 400 ? 50 : 40,
                    child: ElevatedButton(
                      onPressed: (){
                        if(myGreeny.length >0){
                          for(HashMap<String,String> h in myGreeny){
                            FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('mygreeny').add(
                                {
                                  'city':h['city'],
                                  'town':h['town'],
                                  'location':h['location'],
                                });
                          }
                          Get.to(bottomNavigationBar());
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: '관심 냉장고를 선택해주세요.',
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }

                      },
                      child: Text('완료하기', style: TextStyle(fontSize: getScreenWidth(context) > 400 ? 17:14,
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

        ],
      ),
    );
  }
}

