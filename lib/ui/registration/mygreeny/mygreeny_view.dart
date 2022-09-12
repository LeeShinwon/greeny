import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/ui/registration/profile/profile_view.dart';
import 'package:greeny/util/screen_size.dart';

List<String> name= ["서울", "경기", "인천", "부산", "대구","광주", "대전", "울산","경남","경북", "충남", "충북","전남","전북", "강원", "제주","세종"];

class MyGreenyView extends StatefulWidget {
  const MyGreenyView({Key? key}) : super(key: key);

  @override
  State<MyGreenyView> createState() => _MyGreenyViewState();
}

class _MyGreenyViewState extends State<MyGreenyView> {
  int _onTapNum =0;

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
                              child: Text(name[index],style: TextStyle(
                                fontSize: getScreenWidth(context) > 400 ? 15 : 10,
                                fontWeight: _onTapNum == index ? FontWeight.w800:FontWeight.w500,
                                color: _onTapNum == index ?Color(0xff319E31):Colors.black,
                              ),),
                              onTap: (){
                                setState(() {
                                  _onTapNum = index;
                                });
                              },
                            ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemCount: name.length,
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
