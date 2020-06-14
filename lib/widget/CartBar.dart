import 'package:flutter/material.dart';
import 'package:india_pavilion/controller/StateContainer.dart';
import 'package:india_pavilion/widget/CartView.dart';

class CartBar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _CartBarState();


  final TextStyle style = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );

}

class _CartBarState extends State<CartBar>{


  @override
  Widget build(BuildContext context) {

    bool cartHasItems = StateContainer.of(context).getCart().hasItems();

    if(cartHasItems) {

      return GestureDetector(
          onTap: () => this.openCart(),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .accentColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total: " + StateContainer
                    .of(context)
                    .getCart()
                    .price
                    .toStringAsFixed(2), style: widget.style),
                Icon(Icons.shopping_cart, color: Colors.white, size: 35,)
              ],
            )
        )
      );

    }else{

      return Container(height: 0.0);

    }
  }

  void openCart(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartView()),
    );
  }

}