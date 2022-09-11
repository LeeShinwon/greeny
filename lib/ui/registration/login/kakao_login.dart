import 'package:greeny/ui/registration/login/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';


class KakaoLogin implements SocialLogin{
  @override
  Future<bool> login() async {
    try{
      bool isInstalled = await isKakaoTalkInstalled();
      if(isInstalled){//설치 되어있으면 카카오톡으로
        try{
          await UserApi.instance.loginWithKakaoTalk();

          return true;
        }catch(e){
          return false;
        }
      }
      else{//설치 안되어 있으면 카카오톡 계정으로
        try{
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        }catch(e) {
          return false;
        }
      }
    }catch(e){
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try{
      await UserApi.instance.unlink();
      return true;
    }catch(error){
      return false;
    }
  }

}