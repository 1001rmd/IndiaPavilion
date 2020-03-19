import 'package:flutter/material.dart';
import 'package:india_pavilion/controller/Cart.dart';

class CartHeader extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _CartHeaderState();

}

class _CartHeaderState extends State<CartHeader>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Total: " + Cart().getPrice().toString()),
          Icon(Icons.shopping_cart)
        ],
      )
    );
  }

}