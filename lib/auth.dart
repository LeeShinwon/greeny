import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny/ui/main/bottomnavigationbar.dart';
import 'package:greeny/ui/registration/login/login_view.dart';
import 'package:greeny/ui/registration/mygreeny/mygreeny_view.dart';
import 'package:greeny/ui/registration/profile/profile_view.dart';

import 'camera.dart';

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
          return bottomNavigationBar();
        }
      }
    );
  }
}
