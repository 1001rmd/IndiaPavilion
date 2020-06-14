import 'package:flutter/material.dart';

//

class IPAppBar extends AppBar {

    IPAppBar(BuildContext context): super(
        flexibleSpace: new Column(
          children: <Widget>[
            new Container(height: MediaQuery.of(context).padding.top + 10),
            new Text('Welcome to',
                style: new TextStyle(color: Colors.white, fontSize: 22)
            ),
            new Text('India Pavilion',
                style: new TextStyle(color: Colors.white, fontSize: 28)
            )
          ],
        ),
        bottom: new PreferredSize(child: new Container(), preferredSize: Size.fromHeight(25)),
        iconTheme: new IconThemeData(color : Colors.white, size: 0)
    );

}

class IPDrawer extends Drawer {

  IPDrawer(this._logOut);

  final VoidCallback _logOut;

  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;

    return new Drawer(
        child: new Container(
            color: Theme
                .of(context)
                .primaryColor,
            padding: EdgeInsets.only(
                top: _height * 0.15,
                bottom: _height * 0.30
            ),
            child: new Row(
              children: <Widget>[
                new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      new FlatButton(
                          onPressed: null,
                          child: new Text('Favorite Order',
                              style: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 28))),
                      new FlatButton(
                          onPressed: null,
                          child: new Text('Account',
                              style: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 28))),
                      new FlatButton(
                          onPressed: null,
                          child: new Text('About Us',
                              style: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 28))),
                      new FlatButton(
                          onPressed: _logOut,
                          child: new Text('Sign Out',
                              style: new TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 28)))
                    ]
                )
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ))
    );
  }
}

