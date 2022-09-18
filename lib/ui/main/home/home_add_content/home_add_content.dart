import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greeny/data/model/user_model.dart';
import 'package:greeny/ui/main/home/home_add_content/home_add_content_location.dart';
import 'package:greeny/util/screen_size.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../data/model/greentrade_model.dart';

class HomeAddContent extends StatefulWidget {
  HomeAddContent({Key? key}) : super(key: key);


  @override
  State<HomeAddContent> createState() => _HomeAddContentState();
}

class _HomeAddContentState extends State<HomeAddContent> {

  final user = FirebaseAuth.instance.currentUser;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();


  String _title='';
  String _content='';
  String _manufacturingDate='';
  String _expiryDate='';
  String _location='';
  late DateTime _registrationTime;

  MyGreeny mt= new MyGreeny('city', 'location', 'town');

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {
    });
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await imagePicker.pickImage(source: imageSource);
    setState(() {
      imageFileList?.add(XFile(image!.path)) ; // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        width: getScreenWidth(context)-110,
        height: 70,
        child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder:(BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                      children: [
                  Center(child: Image.file(File(imageFileList![index]!.path), )),
                  Positioned(child: IconButton(onPressed: (){
                    setState(() {
                      imageFileList?.removeAt(index);
                    });
                  }, icon: Icon(CupertinoIcons.clear_circled_solid)), top: -10,right: -10,),
                    ]
                  ),
                );
              },
              itemCount: imageFileList?.length,
            )
        )
    );
  }

  void showDatePickerPop(int n) {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2010), //시작일
      //lastDate: DateTime(2022), //마지막일
      lastDate: (new DateTime(2100)).add(new Duration(days: 7)),
      builder: (BuildContext context, Widget? child) {
        return Theme(

          data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Color(0xff319E31), // header background color
            onPrimary: Colors.black, // header text color
            onSurface: Colors.black, // body text color
          ),),
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      setState(() {
        if(n==1){
          _manufacturingDate = dateTime.toString().split(' ')[0].replaceAll('-', '.');
        }
        else{
          _expiryDate = dateTime.toString().split(' ')[0].replaceAll('-', '.');
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: getAppBarHeight(context),
        backgroundColor: Colors.white,
        //centerTitle: false,
        elevation: 0,
        leading: IconButton(onPressed: () { Get.back(); },icon: Icon(CupertinoIcons.clear, color: Colors.black,size: 20,),),
        title:  Text('나눔 글쓰기', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),
        actions: [
          TextButton(onPressed: () async {
            if(_formKey.currentState!.validate() && !_manufacturingDate.isEmpty && _manufacturingDate != 'null'
                && !_expiryDate.isEmpty && _expiryDate != 'null' && !_location.isEmpty && _location != 'null') {


              _formKey.currentState!.save();
              FirebaseStorage storage = FirebaseStorage.instance;
              Reference storageRef = storage.ref('profile/greenTrade/');
              //String downloadURL ='';
              List<String> urlList = <String>[];
              List<String> like = <String>[];
              List<String> report = <String>[];


              try {
                for (int i = 0; i < imageFileList!.length; i++) {
                  storageRef = storage.ref('profile/greenTrade/' +
                      imageFileList![i].path.split('/')[6]);
                  await storageRef.putFile(File(imageFileList![i].path));
                  //downloadURL = await storageRef.getDownloadURL();
                  urlList.add('profile/greenTrade/' +
                      imageFileList![i].path.split('/')[6]);
                }
              }
              on FirebaseAuthException catch (e) {
                print(e);
              }

              _registrationTime = DateTime.now();
              var l = FirebaseFirestore.instance.collection(
                  'greenTrade').add(
                  {
                    'content': _content,
                    'title': _title,
                    'location': '/map/' + mt.city + '/town/' + mt.town + '/location/' +
                        mt.location,
                    'isGreen': false,
                    'manufacturingDate': _manufacturingDate,
                    'expiryDate': _expiryDate,
                    'writerId': user!.uid,
                    'registrationTime': _registrationTime.toLocal(),
                    'picture': urlList,
                    'like': like,
                    'report':report,
                  });


              Get.back();
            }


          }, child: Text('완료', style: TextStyle(
              color: Color(0xff319E31), fontWeight: FontWeight.w600, fontSize: 16,
          ),)),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: getScreenWidth(context),
              height: 100,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: 70,
                    height: 70,
                    child: OutlinedButton(
                      onPressed: (){
                      showModalBottomSheet( //reference : https://api.flutter.dev/flutter/material/showModalBottomSheet.html
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (context) => Container(
                          height: getScreenHeight(context)*0.25,
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Icon(CupertinoIcons.camera),
                                title: Text('카메라'),
                                onTap: (){
                                  getImage(ImageSource.camera);
                                  setState(() {
                                  });
                                  Get.back();
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(CupertinoIcons.photo),
                                title: Text('갤러리'),
                                onTap: (){
                                  selectImages();
                                  Get.back();
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(CupertinoIcons.clear),
                                title: Text('취소'),
                                onTap: (){
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }, child: Icon(CupertinoIcons.camera, color: Colors.black,),
                      style: OutlinedButton.styleFrom(
                          //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                         ),),
                  ),
                  showImage(),
                ],
              ),
            ),
            Container(
              width: getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _titleController,
                        validator: (value){
                          if(value!.trim().isEmpty){
                            return '제목을 입력하세요.';
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          _title = value as String;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff319E31), width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: '제목을 입력하세요',
                        ),
                        keyboardType:TextInputType.text,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _contentController,
                        validator: (value){
                          if(value!.trim().isEmpty){
                            return '내용을 입력하세요.';
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          _content = value as String;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff319E31), width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: '내용을 입력하세요. (최대 10줄)',
                        ),
                        keyboardType:TextInputType.multiline,
                        maxLines: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                        child: Text('제조 일자'),
                      ),
                      Container(
                        width: getScreenWidth(context)-40,
                        height: 50,
                        child: OutlinedButton(
                            onPressed: (){
                              showDatePickerPop(1);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: _manufacturingDate.isEmpty ||_manufacturingDate=='null' ? Text('선택하기', style: TextStyle(color: Color(0xff319E31), fontWeight: FontWeight.w600) ): Text(_manufacturingDate!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                        child: Text('추천 소비 기한'),
                      ),
                      Container(
                        width: getScreenWidth(context)-40,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: (){
                            showDatePickerPop(2);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _expiryDate.isEmpty ||_expiryDate=='null' ? Text('선택하기', style: TextStyle(color: Color(0xff319E31), fontWeight: FontWeight.w600) ): Text(_expiryDate!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                        child: Text('냉장고 위치'),
                      ),
                      Container(
                        width: getScreenWidth(context)-40,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () async {
                            var value =  await Get.to(HomeAddContentLocation());
                            _location = value.city+' '+ value.town+' '+ value.location;
                            mt.location = value.location;
                            mt.city = value.city;
                            mt.town = value.town;

                            setState(() {
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _location.isEmpty? Text('선택하기', style: TextStyle(color: Color(0xff319E31), fontWeight: FontWeight.w600) ): Text(_location, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

