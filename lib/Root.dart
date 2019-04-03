import 'package:flutter/material.dart';
import 'Login.dart';
import 'Auth.dart';
import 'Home.dart';

class Root extends StatefulWidget{

  final Auth auth = new Auth();

  @override
  State<StatefulWidget> createState() => new _RootState();

}

class _RootState extends State<Root>{

  AuthStatus authStatus = AuthStatus.loggedOut;

  initState(){
    super.initState();
    widget.auth.currentUser().then((userID){
      setState(() {
        authStatus = userID == null ? AuthStatus.loggedOut : AuthStatus.singedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    switch(authStatus){
      case AuthStatus.loggedOut:
        return new LoginPage(
            auth: widget.auth,
            signedIn: _signedIn
        );
      case AuthStatus.singedIn:
        return new HomePage(
          auth: widget.auth,
          loggedOut: _loggedOut
        );
    }
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.singedIn;
    });
  }

  void _loggedOut(){
    setState((){
      authStatus = AuthStatus.loggedOut;
    });
  }

}

enum AuthStatus{
  singedIn,
  loggedOut
}