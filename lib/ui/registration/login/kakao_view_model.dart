import 'package:firebase_auth/firebase_auth.dart';
import 'package:greeny/data/datasource/firebase_auth_remote_data_source.dart';
import 'package:greeny/ui/registration/login/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

import '../../../data/repository/login.dart';

class KakaoViewModel {
  final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
  final SocialLogin _socialLogin;
  bool isLogined = false;
  kakao.User? user;

  KakaoViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if(isLogined){
      user = await kakao.UserApi.instance.me();

      final token = await _firebaseAuthDataSource.createCutomToken({
        'uid': user!.id.toString(),
        'displayName': user!.kakaoAccount!.profile!.nickname,
        'email':user!.kakaoAccount!.email,
        //'photoURL': user!.kakaoAccount!.profile!.profileImageUrl,

      });
      await FirebaseAuth.instance.signInWithCustomToken(token);
      print('token은 : '+token);

      var loginfirestoredatabase = LoginRepository();
      loginfirestoredatabase.createKakaoUser(user);


    }

  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

}