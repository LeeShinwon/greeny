import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:greeny/ui/registration/registration_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/three_leaves.png'),
        nextScreen: const RegistrationView(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff319E31),
        duration: 2000,
      ),

      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
