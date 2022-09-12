import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/ui/registration/profile/profile_view.dart';
import 'package:greeny/util/screen_size.dart';

const List<String> city= ["서울", "경기", "인천", "부산", "대구","광주", "대전", "울산","경남","경북", "충남", "충북","전남","전북", "강원", "제주","세종"];
const List<List<String>> town = [
  //서울
  ['강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용상구','은평구','종로구','중구','중랑구'],
  //경기
  ['가평군','고양시 덕양구','고양시 일산동구','고양시 일산서구','과천시','광명시','광주시','구리시','군포시','김포시','남양주시','동두천시','부천시','성남시 분당구','성남시 수정구','성남시 중원구','수원시 권선구','수원시 영통구','수원시 장안구','수원시 팔달구','시흥시',
    '안산시 단원구','안산시 상록구','안성시','안양시 동안구','안양시 만안구','양주시','양평군','여주시','연천군','오산시','용인시 기흥구','용인시 수지구','용인시 처인구','의왕시','의정부시','이천시','파주시','평택시','포천시','하남시','화성시'],
  //인천
  ['강화군','계양구','미추홀구','남동구','동구','부평구','서구','연수구','옹진군','중구'],
  //부산
  ['강서구','금정구','기장군','남구','동구','동래구','부산진구','북구','사상구','사하구','서구','수영구','연제구','영도구','중구','해운대구'],
  //대구
  ['남구','달서구','달성군','동구','북구','서구','수성구','중구'],
  //광주
  ['광산구','남구','동구','북구','서구'],
  //대전
  ['대덕구','동구','서구','유성구','중구'],
  //울산
  ['남구','동구','북구','울주군','중구'],
  //경남
  ['거제시','거창군','고성군','김해시','남해군','밀양시','사천시','산청군','양산시','의령군','진주시','창녕군','창원시 마산합포구','창원시 마산회원구','창원시 성산구','성산시 의창구','창원시 진해구','통영시','하동군','함안군','함양군','합천군'],
  //경북
  ['경산시','경주시','고령군','구미시','군위군','김천시','문경시','봉화군','상주시','성주군','안동시','영덕군','영양군','영주시','영천시','예천군','울릉군','울진군','의성군','청도군','청송군','칠곡군','포항시 북구','포항시 남구'],
  //충남
  ['계룡시','공주시','금산군','논산시','당진시','보령시','부여군','서산시','서천군','아산시','연기군','예산군','천안시 동남구','천안시 서북구','청양군','태안군','홍성군'],
  //충북
  ['괴산군','단양군','보은군','영동군','옥천군','음성군','제천시','증평군','진천군','청주시 상당구','청주시 흥덕구','청주시 서원구','청주시 청원군','충주시'],
  //전남
  ['강진군','고흥군','곡성군','광양시','구례군','나주시','담양군','목포시','무안군','보성군','순천시','신안군','여수시','영광군','영암군','완도군','장성군','장흥군','진도군','함평군','해남군','화순근'],
  //전북
  ['고창군','군산시','김제시','남원시','무주군','부안군','순창군','완주군','임실군','장수군','전주시 덕진구','전주시 완산구','정읍시','진안군'],
  //강원
  ['강릉시','고성군','동해시','삼척시','속초시','양구군','양양군','영원군','원주시','인제군','정선군','철원군','춘천시','태백시','평창군','홍천군','화천군','횡성군'],
  //제주
  ['서귀포시','제주시'],
  //세종은 없음...

];

class MyGreenyView extends StatefulWidget {
  const MyGreenyView({Key? key}) : super(key: key);

  @override
  State<MyGreenyView> createState() => _MyGreenyViewState();
}

class _MyGreenyViewState extends State<MyGreenyView> {
  int _onTapCity =0;

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
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: Text('관심있는 냉장고를 선택해주세요.',
              style: TextStyle(
                fontSize: 12,
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






              ],
            ),

          ),
        ],
      ),
    );
  }
}
