import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:developer' as dev;

class Auth{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async{
    dev.log(email);
    FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    return user.uid;

  }

  Future<String> create(String email, String password) async{

    FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;

  }

  Future<String> currentUser() async{

    FirebaseUser user = await _auth.currentUser();
    if(user != null){
      return user.uid;
    }else{
      return null;
    }

  }

  Future<void> logOut() async{
   return _auth.signOut();
  }

}