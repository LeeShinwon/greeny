import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:greeny/auth.dart';
import 'package:greeny/firebase_options.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: '422477c03efca08d62fe591d46710a79');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '그린이',
      theme: ThemeData(fontFamily: 'NanumGothicFont'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko', 'KR'), // Spanish, no country code
      ],
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/three_leaves.png'),
        nextScreen: const Authenticaton(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff319E31),
        duration: 2000,
      ),

      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
