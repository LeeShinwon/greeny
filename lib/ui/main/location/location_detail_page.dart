import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:greeny/data/model/city_model.dart' as cm;
import 'package:location/location.dart';
import 'package:greeny/data/model/map_model.dart' as mm;

class LocationDetailPage extends StatefulWidget {
  const LocationDetailPage({Key? key}) : super(key: key);

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  Completer<GoogleMapController> _controller = Completer();
  final user = FirebaseAuth.instance.currentUser;
  final Set<Marker> markers = new Set();
  List<mm.Map> mapInfo = <mm.Map>[];


  void getStream(){
    print('he');
    print(cm.town[0].length);
      for(int j=0; j<cm.town[0].length; j++){

        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('map/서울/town/'+cm.town[0][j]+'/location').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color> (Color(0xff319E31)),
                  ), //로딩되는 동그라미 보여주기
                );
              }
              print('hera');
              print(snapshot.hasData);
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder:(BuildContext context,int index){
                  var doc = snapshot.data?.docs[index];
                  mm.Map m = new mm.Map(doc?.get('name'), doc?.get('address'), doc?.get('point'));
                  mapInfo.add(m);
                  return Text('');
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
        );
      }


  }



  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.509,127.0839),
    zoom: 15,
  );

  Set<Marker> getmarkers(){

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(LatLng(37.509,127.0839).toString()),
          position:  LatLng(37.509,127.0839),
          infoWindow: InfoWindow(
            title: '새마을전통시장',
            snippet: '서울특별시 송파구 석촌호수로12길 24',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId(LatLng(37.5107,127.0828).toString()),
          position:  LatLng(37.5107,127.0828),
          infoWindow: InfoWindow(
            title: '잠실사회복지관',
            snippet: '서울특별시 송파구 올림픽로12길 12',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId(LatLng(37.5063,127.0844).toString()),
          position:  LatLng(37.5063,127.0844),
          infoWindow: InfoWindow(
            title: '잠실본동 주민센터',
            snippet: '서울특별시 송파구 백제고분로15길 9',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ),
      );
    });

    return markers;
  }



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
        title:  Text('위치', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),


      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            markers: getmarkers(),
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          //Positioned(child: IconButton(icon: Icon(CupertinoIcons.clear, color: Colors.white,), onPressed: () { Get.back(); },), top: 30,left: 10,),

        ],
      ),
    );
  }
}
