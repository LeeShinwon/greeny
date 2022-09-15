import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/data/model/user_model.dart';
import 'package:greeny/ui/main/home/home_add_content/home_add_content.dart';
import '../../../../data/model/city_model.dart';
import '../../../../util/screen_size.dart';

class HomeAddContentLocation extends StatefulWidget {
  const HomeAddContentLocation({Key? key}) : super(key: key);

  @override
  State<HomeAddContentLocation> createState() => _HomeAddContentLocationState();
}

class _HomeAddContentLocationState extends State<HomeAddContentLocation> {
  int _onTapCity =0;
  int _onTapTown =0;
  String _onTapMyGreeny='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('냉장고 선택', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(

        children: [
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
                        height: (getScreenHeight(context)- kToolbarHeight - 17) * 0.7-45,
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
                                                fontWeight: (doc.get('name')==_onTapMyGreeny) ? FontWeight.w800:FontWeight.w500,
                                                color: (doc.get('name')==_onTapMyGreeny) ?Color(0xff319E31):Colors.black,
                                              ),),
                                            ),
                                          ),
                                          (doc.get('name')==_onTapMyGreeny)? Icon(
                                            CupertinoIcons.check_mark,
                                            size: getScreenWidth(context) > 400 ? 15 : 10,
                                          ):Text(''),
                                        ],
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _onTapMyGreeny = doc.get('name');
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

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: getScreenWidth(context)*0.8,
              height: getScreenWidth(context) > 400 ? 50 : 40,
              child: ElevatedButton(
                onPressed: (){
                  if(!_onTapMyGreeny.isEmpty){
                    MyGreeny m = MyGreeny(city[_onTapCity], _onTapMyGreeny, town[_onTapCity][_onTapTown]);
                    Get.back(result: m);
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: '냉장고가 아직 선택되지 않았습니다.',
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black12,
                      textColor: Colors.black,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_onTapMyGreeny, style: TextStyle(fontSize: getScreenWidth(context) > 400 ? 17:14,
                      fontWeight: FontWeight.w600, color: Colors.black),),
                    Text(' 으로 선택하기', style: TextStyle(fontSize: getScreenWidth(context) > 400 ? 17:14,
                      fontWeight: FontWeight.w600,),),
                  ],
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff319E31),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),

                ),
              ),
            ),
          ),

          SizedBox(
            width: getScreenWidth(context)*0.8,
            height: getScreenWidth(context) > 400 ? 50 : 40,
            child: ElevatedButton(
              onPressed: (){
                Get.back();
              },
              child: Text('취소', style: TextStyle(fontSize: getScreenWidth(context) > 400 ? 17:14,
                fontWeight: FontWeight.w600,color: Colors.black),),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),

              ),
            ),
          ),
        ],
      ),
    );
  }
}