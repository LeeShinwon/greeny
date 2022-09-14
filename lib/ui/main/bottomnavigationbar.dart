import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/ui/main/community/community_page.dart';
import 'package:greeny/ui/main/location/location_page.dart';
import 'package:greeny/ui/main/mypage/my_page.dart';

import 'home/home_first_page/home_page.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int _selectedIndex = 0; //선택한 메뉴의 인덱스를 기억


  //특정 텍스트 스타일을 상수로 지정
  static const TextStyle optionStyle = TextStyle(
      color: Colors.black,
      //fontSize: 25,
      fontWeight: FontWeight.bold,);

  //메뉴별 다른 AppBar의 텍스트 지정을 위해 List<Text> 선언
  static final List<Widget> _appBarOptions = <Widget>[
    Text('홈', style: optionStyle),
    Text('위치', style: optionStyle),
    Text('게시판', style: optionStyle),
    Text('나', style: optionStyle),

  ];



  //메뉴별 다른 body 지정을 위해 List<Widget> 선언
  static const List<Widget> _bodyOptions = <Widget>[
    HomePage(),
    LocationPage(),
    CommunityPage(),
    MyPage(),
  ];

  //함수 구현
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: getAppBarHeight(context),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title:  _appBarOptions.elementAt(_selectedIndex),
        actions: [
          _selectedIndex==0?IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search, color: Colors.black,)):Text(''),
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.bell,color: Colors.black,)),
        ],

      ),
      body: Center(
        child: _bodyOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: '홈',
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.placemark),
            label: '위치',
            activeIcon: Icon(CupertinoIcons.placemark_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.text_bubble),
            label: '게시판',
            activeIcon: Icon(CupertinoIcons.text_bubble_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: '나',
          ),

        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
          showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
      floatingActionButton: _selectedIndex==0?FloatingActionButton(
        onPressed: (){},
        child: Icon(CupertinoIcons.plus,),
        backgroundColor: Color(0xff319E31),
      ):Text(''),
    );
  }
}

