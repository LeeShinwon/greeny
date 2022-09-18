import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greeny/ui/main/location/location_detail_page.dart';
import 'package:greeny/util/screen_size.dart';
import 'package:location/location.dart';

final itemTitle =[
  "푸드 쉐어링","나눔.공유 냉장고","그린이"
];

final itemContent =[
  "개인이나 단체가 음식을 버리는 대신 공유하는 것입니다. 독일의 영화제작자이자 저널리스트인 발렌틴 턴이 자신의 다큐멘터리 '쓰레기를 맛보자(Taste the Waste)'를 통해 음식물 쓰레기를 줄이자는 캠페인을 벌이며 시작되었습니다. 현재 약 240개 도시에 냉장고나 선반을 설치해 음식을 나누고 있습니다.",
  "한국에도 수십개의 공유.나눔 냉장고가 전국적으로 분포해 있습니다. 지역사회의 음식을 나누고 음식물 쓰레기 배출량을 줄여 나눔과 탄소 중립을 실천할 수 있습니다. ",
  "지자체, 주민, 개인으로 냉장고를 운영하는 특성상, 냉장고 정보에 대해 사용자들이 정확히 알 수 없습니다. 또한 관리, 운영 차원에서도 지역별 편차가 큽니다. 이러한 점을 보완하기 위해 '그린이' 앱을 출시 하였습니다."
];

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Completer<GoogleMapController> _controller = Completer();
  final user = FirebaseAuth.instance.currentUser;

  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.321655, 127.378953),
    zoom: 6.5,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 220, viewportFraction: 1.0, autoPlay: true,autoPlayInterval: Duration(seconds: 5), autoPlayAnimationDuration: Duration(seconds: 1),),
            items: [0,1,2].map((i) {
              return Builder(builder: (BuildContext context){
                return Container(
                  /*decoration: BoxDecoration(
                    color: Color(0xffF9FCF9),
                    border: Border(
                        bottom: BorderSide(
                          color: Color(0xff92C992),
                          width: 0.5,
                        )
                    ),
                  ),*/
                  //color: Color(0xffF9FCF9),
                  width: getScreenWidth(context),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(itemTitle[i],style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: i==2 || i==1? getScreenWidth(context)-180: getScreenWidth(context)-40,
                                child: Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.fade,
                                    text: TextSpan(text: itemContent[i],style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),),
                                  ),
                                ),
                              ),



                              //Flexible(child: RichText(text: TextSpan(text: itemContent[i],), overflow: TextOverflow.fade,),),
                            ],
                          ),
                          i==2? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Image.asset('assets/images/greeny.png', width: 85,),
                              ),
                              Text('그린이', style: TextStyle(fontWeight: FontWeight.w600, height: 2),),
                            ],
                          ):i==1?Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset('assets/images/fork.png', width: 85,),
                          ):Text(''),
                        ],
                      ),
                    ],
                  ),
                );
              });
            }).toList(), ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
            width: getScreenWidth(context),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('나의 관심 냉장고', style: TextStyle(
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
                                  ), //로딩되는 동그라미 보여주기
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
                        child: Text('변경', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
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

          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                width: getScreenWidth(context)-40,
                height: (getScreenHeight(context)-250-kToolbarHeight)*0.6,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Positioned(
                child: Container(
                  width: getScreenWidth(context)-150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: (){
                      Get.to(LocationDetailPage());
                    },
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.map, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text('큰 지도로 위치정보 파악하기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                  ),
                ),
                top: 10,
                left: 60,
              ),
            ],
          ),


        ],
      ),
    );
  }
}



