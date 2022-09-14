import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/ui/main/home/home_first_page/home_page_list.dart';
import 'package:greeny/util/screen_size.dart';

import '../../../../data/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  MyGreeny _myChoice = new MyGreeny('city', 'location', 'town');

  bool isSame(QueryDocumentSnapshot doc){
    if(_myChoice.city == doc!.get('city') && _myChoice.location == doc!.get('location') &&_myChoice.town == doc!.get('town')){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
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
                          child: OutlinedButton(
                            onPressed: (){
                              setState(() {
                                _myChoice = new MyGreeny(doc!.get('city'), doc!.get('location'), doc!.get('town'));
                              });
                            },
                            child: Text(doc?.get('location'), style: TextStyle(color: (isSame(doc!))? Colors.white: Colors.black, fontWeight: FontWeight.w600),),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(width: 2,color: Color(0xff319E31)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                                backgroundColor: (isSame(doc!))?Color(0xff319E31):Colors.white,

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
        ),
        Expanded(
            child: HomePageList(_myChoice)
        ),
      ],
    );
  }
}
