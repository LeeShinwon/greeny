import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/data/model/greentrade_model.dart';
import 'package:greeny/data/model/user_model.dart';

class HomeDetailPage extends StatefulWidget {
  HomeDetailPage(this.lgt, this.mg, {Key? key}) : super(key: key);
  GreenTrade lgt;
  MyGreeny mg;

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(),
    );
  }
}
