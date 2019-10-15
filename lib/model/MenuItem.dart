import 'package:flutter/material.dart';


class MenuItem extends StatelessWidget{

  String name;
  String category;
  String description;
  double price;
  bool spiceLvl;
  bool favorite;

  MenuItem(Map<String, dynamic> data){

    name = data["name"];
    category = data["category"];
    description = data["description"];
    price = data["price"];
    spiceLvl = data["spiceLvl"];
    favorite = data["favorite"];


  }

  @override
  Widget build(BuildContext context) {
    //return new Text(name);
    //return new Column( children:<Widget>[new Text(name),new Text(price.toString())]);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage('lib/assets/images/samosa.jpg'),
                fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0),)
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5.0,),
                  Text(description,style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),),
                  SizedBox(height: 10.0),
                  new Text(price.toString(),style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                      color:Colors.grey
                  ),)


                ],
              ),
            )
          ],
        )
      ],
    );

  }

}