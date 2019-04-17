import 'package:flutter/material.dart';
import 'package:india_pavilion/Auth.dart';
import 'IPAppBar.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.loggedOut});
  final Auth auth;
  final VoidCallback loggedOut;


  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new IPAppBar(context),
      body: new Container(
        padding: EdgeInsets.only(top: 50.0),
        child: new Column(
            children: <Widget>[
              new Text("TODO Home Page"),
            ]
        )
      ),
      drawer: new IPDrawer(loggedOut)
    );

  }




}