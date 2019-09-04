import 'package:flutter/material.dart';


class MenuItem extends StatelessWidget{

  String name;
  String category;
  String description;
  double price;
  bool spiceLvl;
  bool favorite;

  MenuItem(Map<String, dynamic> data){

    name = data["Name"];
    category = data["Category"];
    description = data["Description"];
    price = data["Price"];
    spiceLvl = data["SpiceLvl"];
    favorite = data["Favorite"];

  }

  @override
  Widget build(BuildContext context) {
    return new Text(name);
  }

}