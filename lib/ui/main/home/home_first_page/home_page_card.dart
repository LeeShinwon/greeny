import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/data/model/greentrade_model.dart';
import 'package:greeny/util/screen_size.dart';
import 'package:greeny/util/storage.dart';

import '../../../../data/model/user_model.dart';

class HomePageCard extends StatefulWidget {
  HomePageCard(this.gt, this.mg,  {Key? key}) : super(key: key);
  GreenTrade gt;
  MyGreeny mg;

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      width: getScreenWidth(context),
      height: 120,
      color: widget.gt.isGreen?Color(0xffECECEC) :Colors.white ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: storage.downloadURL(widget.gt.picture[0]),
              builder: (BuildContext context, AsyncSnapshot<String> snap) {
                if (snap.connectionState == ConnectionState.done && snap.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Expanded(
                      child: Image.network(
                        snap.data!,
                        width: 100,height: 100,fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff319E31)),
                    ), //로딩되는 동그라미 보여주기
                  );
                }
                return Image.asset('assets/images/profile.png', width: 100,height: 100,fit: BoxFit.fitHeight,);
              },
            ),
            //Image.asset('assets/images/profile.png', width: 100,height: 100,fit: BoxFit.fitHeight,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.gt.title, style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18,
                  ),),
                  Text(widget.mg.town + ' '+ widget.mg.location, style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13
                  ),),
                  Text(widget.gt.registrationTime, style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 13
                  ),),
                  Container(
                    width: getScreenWidth(context)-160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(CupertinoIcons.heart, size: 15,),
                      Text(widget.gt.like.length.toString(), style: TextStyle(
                        fontSize: 13,
                      ),),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(CupertinoIcons.chat_bubble, size: 15,),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('greenTrade/'+widget.gt.id +'/comment').snapshots(),
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

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
