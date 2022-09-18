import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/data/model/greentrade_model.dart';
import 'package:greeny/data/model/user_model.dart';
import 'package:greeny/util/screen_size.dart';
import 'package:greeny/util/storage.dart';

class HomeDetailPage extends StatefulWidget {
  HomeDetailPage(this.lgt, this.mg, {Key? key}) : super(key: key);
  GreenTrade lgt;
  MyGreeny mg;

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    List<int> list = <int>[];
    print(widget.lgt.picture.length);
        for(int i=0; i<widget.lgt.picture.length; i++){
          list.add(i);
        }
    return Scaffold(
      appBar:AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: Text(''),
         backgroundColor: Colors.white,
         actions: [
           IconButton(icon: Icon(CupertinoIcons.ellipsis_vertical),onPressed: (){

           },),
         ],
      ),
      body:Column(
        children: [
          Container(
            width: getScreenWidth(context),
            height: getScreenHeight(context)-300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Positioned(
                    child: CarouselSlider(
                        items: list.map(
                            (item) => Container(
                              child: FutureBuilder(
                                future: storage.downloadURL(widget.lgt.picture[item]),
                                builder: (BuildContext context, AsyncSnapshot<String> snap) {
                                  if (snap.connectionState == ConnectionState.done && snap.hasData) {
                                    return Image.network(
                                      snap.data!,
                                      width: getScreenWidth(context),height: getScreenWidth(context),fit: BoxFit.fill,
                                    );
                                  }
                                  if (snap.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xff319E31)),
                                      ), //로딩되는 동그라미 보여주기
                                    );
                                  }
                                  return Image.asset('assets/images/profile.png', width: getScreenWidth(context),height: getScreenWidth(context),fit: BoxFit.fitHeight,);
                                },
                              ),
                            )
                        ).toList(),
                        options: CarouselOptions(viewportFraction: 1.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [

                        Container(
                          child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          child: Expanded(
                            child: Image.asset("assets/images/profile.png", width: 50, height: 50,),
                          ),
                        ),
                          decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xffF3ED9F),
                          ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0) // POINT
                            ), ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('user').where('uid', isEqualTo: widget.lgt.writerId).snapshots(),
                                  builder: (context, snap) {
                                    if (snap.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff319E31)),
                                        ), //로딩되는 동그라미 보여주기
                                      );
                                    }
                                    return Text(snap.data?.docs[0]['name'], style: TextStyle(fontWeight: FontWeight.w700),);
                                  }
                              ),
                              Text(widget.mg.city +' > '+widget.mg.town+' > '+widget.mg.location, style: TextStyle(
                                color: Colors.black45, fontSize: 13,height: 2,
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.lgt.title, style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20,
                        ),),
                        Text(widget.lgt.registrationTime, style: TextStyle(
                          color: Colors.black45, fontSize: 12, height: 1.5
                        ),),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: getScreenWidth(context)-40,
                          //height: 50,
                          child: Flexible(
                            child: RichText(
                              overflow: TextOverflow.fade,
                              text: TextSpan(text: widget.lgt.content,style: TextStyle(
                                fontSize: 15,
                                //fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: getScreenWidth(context)-160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){
                                    List l = widget.lgt.like;
                                    if(!l.contains(user!.uid)){
                                      l.add(user!.uid);
                                      FirebaseFirestore.instance.collection('greenTrade').doc(widget.lgt.id).update({
                                        'like':l,
                                      });
                                    }
                                    setState(() {
                                    });
                                  }, child: Row(children: [
                                    Icon(CupertinoIcons.heart, size: 15,color: Colors.black,),
                                    SizedBox(width: 5,),
                                    Text(widget.lgt.like.length.toString(), style: TextStyle(
                                      fontSize: 13,color: Colors.black,
                                    ),),
                                  ],)),
                                  Icon(CupertinoIcons.chat_bubble, size: 15,),
                                  SizedBox(width: 5,),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('greenTrade/'+widget.lgt.id +'/comment').snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color> (Color(0xff319E31)),
                                            ), //로딩되는 동그라미 보여주기
                                          );
                                        }

                                        return Text(snapshot.data!.docs.length.toString(), style: TextStyle(
                                          fontSize: 13,
                                        ),);
                                      }
                                  ),


                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextButton(
                                  onPressed: (){
                                    List l = widget.lgt.report;
                                    if(!l.contains(user!.uid)){
                                      l.add(user!.uid);
                                      FirebaseFirestore.instance.collection('greenTrade').doc(widget.lgt.id).update({
                                        'report':l,
                                      });
                                    }
                                    setState(() {
                                    });
                              }, child: Text('신고하기', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600,),)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Row(

                      children: [
                        Text('댓글', style: TextStyle(fontSize: 12),),
                        Icon(CupertinoIcons.chat_bubble, size: 15,),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('greenTrade/'+widget.lgt.id+'/comment').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color> (Color(0xff319E31)),
                            ), //로딩되는 동그라미 보여주기
                          );
                        }
                      return ListView.builder(
                          itemBuilder:(BuildContext context,int index){
                            return Column(

                            );
                          },
                        itemCount: snapshot.data!.docs.length,

                      );
                    }
                  ),

                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: getScreenWidth(context),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0,-1), // changes position of shadow
                ),
              ],
            ),

            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('제조일자',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        Text(widget.lgt.manufacturingDate,style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                          height: 2,
                        ),)
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('추천 소비기한',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        Text(widget.lgt.expiryDate,style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                          height: 2,
                        ),)
                      ],
                    ),

                    ElevatedButton(onPressed: (){
                      if(!widget.lgt.isGreen){
                        FirebaseFirestore.instance.collection('greenTrade').doc(widget.lgt.id).update({
                          'isGreen':true,
                        });
                        Get.back();
                      }
                    }, child: Row(children: [
                      Text('그린했어요',style: TextStyle(
                        fontWeight: FontWeight.w600,

                      ),),
                      SizedBox(width: 10,),
                      Icon(CupertinoIcons.heart_fill,size: 17,color: Colors.black,),

                    ],),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: !widget.lgt.isGreen? MaterialStateProperty.all<Color>(Color(0xff319E31)):MaterialStateProperty.all<Color>(Color(0xffECECEC)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //side: BorderSide(color: Colors.red)
                              )
                          )
                      ),),
                  ],
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                   // _isComment =1;
                  });
                }, child: Row(children: [
                  Icon(CupertinoIcons.chat_bubble,size: 17,color: Colors.black26,),
                  SizedBox(width: 10,),
                  Text('댓글을 입력하세요.', style: TextStyle(color: Colors.black26),),
                ],),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffECECEC)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            //side: BorderSide(color: Colors.red)
                        )
                    )
                ),),
              ],
            )
          )
        ],
      ),

    );
  }
}
