import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as google;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

class LoginRepository{
  CollectionReference database = FirebaseFirestore.instance.collection('user');
  late QuerySnapshot querySnapshot;

  LoginRepository();


  Future<void> createKakaoUser(kakao.User? user) async {

    if (user != null) {
      int i;
      querySnapshot = await database.get();

      for (i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];

        if (a.get('uid') == user.id.toString()) {
          break;
        }
      }

      if (i == (querySnapshot.docs.length)) {
        database.doc('kakao'+user.id.toString()).set({
          'email': user.kakaoAccount?.email.toString(),
          'name': user!.kakaoAccount!.profile!.nickname.toString(),
          'uid': 'kakao'+user.id.toString(),
          //'photoURL': user!.kakaoAccount!.profile!.profileImageUrl,
          'photoURL':'',
        });
      }
    }
  }
  Future<void> createGoogleUser(google.User? user) async {

    if (user != null) {
      int i;
      querySnapshot = await database.get();

      for (i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];

        if (a.get('uid') == user.uid) {
          break;
        }
      }

      if (i == (querySnapshot.docs.length)) {
        database.doc(user.uid).set({
          'email': user.email.toString(),
          'name': user.displayName.toString(),
          'uid': user.uid,
          //'photoURL': user.photoURL,
          'photoURL': '',
        });
      }
    }
  }
}