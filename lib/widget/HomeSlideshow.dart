import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlideshow extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(
        child: CarouselSlider(
          items: photos,
          aspectRatio: 2.0,
          //height: (MediaQuery.of(context).size.width / 16) * 9 ,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: Duration(seconds: 10),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0))
        ),

    );

  }

  final List<Widget> photos = [
    Image.asset('lib/assets/images/ip1.jpg'),
    //Image.asset('lib/assets/images/ip2.jpg'),
    Image.asset('lib/assets/images/ip3.jpg'),
    Image.asset('lib/assets/images/ip4.jpg'),

  ];

}