import 'package:flutter/material.dart';
import 'package:india_pavilion/Auth.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.loggedOut});
  final Auth auth;
  final VoidCallback loggedOut;


  @override
  Widget build(BuildContext context){

    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.only(top: 50.0),
        child: new Column(
            children: <Widget>[
              new Text("TODO Home Page"),
              new RaisedButton(
                  onPressed: _logOut,
                  child: new Text("Log Out")
              )
            ]
        )
      )
    );

  }

  void _logOut() async{
    try{
      await auth.logOut();
      loggedOut();
    }catch(e){
      print(e);
    }

  }
}