import 'package:flutter/material.dart';
import '../controller/Auth.dart';
import '../controller/Database.dart';
import 'IPAppBar.dart';
import '../model/Menu.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.loggedOut});
  final Auth auth;
  final VoidCallback loggedOut;


  @override
  Widget build(BuildContext context) {

    //Pictures for carousel
    List<Widget> photos = [
      Image.asset('lib/assets/images/ip1.jpg'),
      Image.asset('lib/assets/images/ip2.jpg'),
      Image.asset('lib/assets/images/ip3.jpg'),
      Image.asset('lib/assets/images/ip4.jpg'),
    ];

    //Builds the Home Page
    return new Scaffold(
      appBar: new IPAppBar(context),
      drawer: new IPDrawer(loggedOut),
      body: new Container(
        padding: EdgeInsets.only(top: 50.0),
        //child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new CarouselSlider(items: photos,
                height: 220,
                //width: 300,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                //autoPlayCurve: Curve.fastOutSlowIn,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                enlargeCenterPage: true,
                //onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,),
                getMenu() //Menu
            ]
          ),
        ),
      //)
    );

  }

  //Queries the database abd builds the menu
  Container getMenu(){

    return new Container(
        child: new FutureBuilder(
          future: Database.getMenu(),
          builder: (BuildContext context, AsyncSnapshot<Menu> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading Menu');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return new Column(
                  children: snapshot.data.getMenuItems()
                );
              default:
                return Text('Loading Menu');
            }
          }
        )
    );
  }



}