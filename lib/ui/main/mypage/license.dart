import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/ui/main/mypage/license_web.dart';

class License extends StatefulWidget {
  const License({Key? key}) : super(key: key);

  @override
  State<License> createState() => _LicenseState();
}

class _LicenseState extends State<License> {
  //String uri='';

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
         title:  Text('라이센스', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),
      ),
      body: ListView(
        children: [
          //pub.dev

          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('flutter_launcher_icons', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text("Copyright (c) 2019 Mark O'Sullivan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
                Text("MIT License", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/flutter_launcher_icons/license'));
              }, child: Text('https://pub.dev/packages/flutter_launcher_icons/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('animated_splash_screen', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text("Copyright (c) 2020 Clean Code", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
                Text("MIT License", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],

            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/animated_splash_screen/license'));
              }, child: Text('https://pub.dev/packages/animated_splash_screen/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('get', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright (c) 2019 Jonny Borges\n MIT License', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/get/license'));
              }, child: Text('https://pub.dev/packages/get/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('cupertino_icons', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright (c) 2016 Vladimir Kharlampidi\nMIT License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/cupertino_icons/license'));
              }, child: Text('https://pub.dev/packages/cupertino_icons/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('firebase_core', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright 2017 The Chromium Authors.\nBSD-3-Clause  License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/firebase_core'));
              }, child: Text('https://pub.dev/packages/firebase_core', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('google_sign_in', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright 2013 The Flutter Authors.\nBSD-3-Clause  License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/google_sign_in/license'));
              }, child: Text('https://pub.dev/packages/google_sign_in/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('firebase_auth', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright 2017 The Chromium Authors\nBSD-3-Clause  License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/firebase_auth/license'));
              }, child: Text('https://pub.dev/packages/firebase_auth/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('kakao_flutter_sdk_user', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright [yyyy] [name of copyright owner]\nApache License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/kakao_flutter_sdk_user/license'));
              }, child: Text('https://pub.dev/packages/kakao_flutter_sdk_user/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('kakao_flutter_sdk', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright [yyyy] [name of copyright owner]\nApache License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/kakao_flutter_sdk/license'));
              }, child: Text('https://pub.dev/packages/kakao_flutter_sdk/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('webview_flutter', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright 2013 The Flutter Authors.\nBSD-3-Clause  License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/webview_flutter/license'));
              }, child: Text('https://pub.dev/packages/webview_flutter/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('flutter_web_auth', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright (c) 2019 Linus Unnebäck\nMIT License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/flutter_web_auth/license'));
              }, child: Text('https://pub.dev/packages/flutter_web_auth/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('http', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright 2014, the Dart project authors.\nBSD-3-Clause  License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/http/license'));
              }, child: Text('https://pub.dev/packages/http/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('uuid', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright (c) 2021 Yulian Kuncheff\nMIT License ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://pub.dev/packages/uuid/license'));
              }, child: Text('https://pub.dev/packages/uuid/license', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),

          /*
          *

  : ^0.4.1
  : ^0.13.5
  uuid: ^3.0.6
  flutter_naver_login: ^1.6.0
  cloud_firestore: ^3.4.6
  google_maps_flutter: ^2.2.0
  fluttertoast: ^8.0.9
  image_picker: ^0.8.5+3
  firebase_storage: ^10.3.8
  flutterfire_ui: ^0.4.3+8
  english_words: ^4.0.0
  carousel_slider: ^4.1.1
  location: ^4.4.0
  geolocator: ^9.0.1
  */

          //leaf
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('leaf illustration 참고', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                Text('Copyright (c) seda\nCC BY 4.0 License', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10)),
              ],
            ),
            subtitle: TextButton(
              onPressed: (){
                Get.to(WebViewApp('https://www.figma.com/community/file/943843409604246251'));
              }, child: Text('https://www.figma.com/community/file/943843409604246251', style: TextStyle(color: Color(0xff319E31)),
            ),
            ),
          ),



        ],
      ),
    );
  }
}

