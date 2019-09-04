import 'package:flutter/material.dart';
import '../controller/Auth.dart';
import '../controller/Database.dart';
import 'IPAppBar.dart';
import '../model/MenuItem.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.loggedOut});
  final Auth auth;
  final VoidCallback loggedOut;


  @override
  Widget build(BuildContext context) {

    List<MenuItem>  menu = Database.getMenu();

    List<Widget> photos = [
      Image.asset('lib/assets/images/ip1.jpg'),
      Image.asset('lib/assets/images/ip2.jpg'),
      Image.asset('lib/assets/images/ip3.jpg'),
      Image.asset('lib/assets/images/ip4.jpg'),

    ];

    return new Scaffold(
      appBar: new IPAppBar(context),
      drawer: new IPDrawer(loggedOut),
      body: new Container(
        padding: EdgeInsets.only(top: 50.0),
        child: new Column(
            children: <Widget>[
              new CarouselSlider(items: photos,
                height: 220,
                // width:300.0,
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
                scrollDirection: Axis.horizontal,)
            ]
        ),
      ),
    );


  }




}