import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Emo extends StatefulWidget {
  const Emo({Key? key}) : super(key: key);

  @override
  State<Emo> createState() => _EmoState();
}

class _EmoState extends State<Emo> {
  List<String> emo = [
    "assets/images/emoticon/n1.png",
    "assets/images/emoticon/n2.png",
    "assets/images/emoticon/n3.png",
    "assets/images/emoticon/n4.png",
    "assets/images/emoticon/n5.png",
    "assets/images/emoticon/n6.png",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
              children: [
                Image.asset("assets/images/emoticon/n1.png",width: 50,),
                GridView.builder(
                    itemCount: emo.length, //item 개수
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 10, //수평 Padding
                      crossAxisSpacing: 10, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          child: Image.asset("assets/images/emoticon/n1.png"),
                        ),
                      );
                    }
                )
              ],
            )
        ),
    );

  }
}
