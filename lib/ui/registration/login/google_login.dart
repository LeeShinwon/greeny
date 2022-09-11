import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greeny/ui/registration/login/social_login.dart';

import '../../../data/repository/login.dart';

class GoogleLogin implements SocialLogin{
  CollectionReference database = FirebaseFirestore.instance.collection('user');
  late QuerySnapshot querySnapshot;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<bool> login() async {
    try{
      final UserCredential userCredential =
      await signInWithGoogle();

      User? user = userCredential.user;

      var loginfirestoredatabase = LoginRepository();
      loginfirestoredatabase.createGoogleUser(user);

      return true;
    }
    catch(e){
      return false;
    }

  }

  @override
  Future<bool> logout() async {
    try{
      FirebaseAuth.instance.signOut();
      return true;
    }catch(error){
      return false;
    }
  }

}