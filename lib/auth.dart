import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/ui/main/bottomnavigationbar.dart';
import 'package:greeny/ui/registration/login/login_view.dart';


class Authenticaton extends StatelessWidget {
  const Authenticaton({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginView();
        }
        else{
          //return ProfileView();
          return bottomNavigationBar();
        }
      }
    );
  }
}
