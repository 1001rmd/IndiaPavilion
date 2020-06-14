import 'package:flutter/material.dart';
import 'package:india_pavilion/controller/StateContainer.dart';
import 'package:india_pavilion/model/OrderItem.dart';
import 'dart:developer' as dev;


class CartView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new CartViewState();

}

class CartViewState extends State<CartView>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            _cartItems(),
          ],
        )
      ),
      bottomNavigationBar: _checkOut(),
    );
  }

  Column _cartItems(){
    List<OrderItem> stateItems = StateContainer.of(context).getCart().getItems();
    double price = StateContainer.of(context).getCart().getPrice();
    double tax = StateContainer.of(context).getCart().getTax();
    double total = StateContainer.of(context).getCart().getTotal();
    TextStyle mainStyle = TextStyle(
      fontSize: 18,
    );

    if(stateItems.length > 0){
      List<Widget> items = new List();

      stateItems.forEach((oItem) {
        items.add(_buildItemCard(oItem));
      });

      // Price
      items.add(ListTile(
        contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .5, 5, 16, 10),
        title: Text("Price:", style: mainStyle),
        trailing: Text("\$" + price.toStringAsFixed(2), style: mainStyle),
      ));
      // Tax
      items.add(ListTile(
        contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .5, 5, 16, 10),
        title: Text("Tax:", style: mainStyle),
        trailing: Text("\$" + tax.toStringAsFixed(2), style: mainStyle),
      ));
      //Total
      items.add(ListTile(
        contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .5, 5, 16, 10),
        title: Text("Total:", style: mainStyle),
        trailing: Text("\$" + total.toStringAsFixed(2), style: mainStyle),
      ));

      return Column(children: items);

    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Text("Your Cart is Empty",
              style: TextStyle(
                  fontSize: 24
              ),
            ),
          )
        ],
      );
    }

  }

  Container _buildItemCard(OrderItem item){

    TextStyle mainStyle = TextStyle(
      fontSize: 18,
    );
    TextStyle subStyle = TextStyle(
      fontSize: 14,
    );
    TextStyle actionStyle = TextStyle(
      fontSize: 14,
      decorationStyle: TextDecorationStyle.solid,
    );


    String spice = item.spiceLvl != null ? item.spiceLvl : "";
    String itemTitle = item.spiceLvl != null ? item.name + " - " + spice : item.name;
    itemTitle += " - x" + item.quantity.toString();

    return Container(
        child: ListTile(
          title: Text(itemTitle, style: mainStyle),
          subtitle: GestureDetector(
            child: Text("Remove", style: actionStyle),
            onTap: () => _removeItem(item),
          ),
          trailing: Text("\$" +item.price.toStringAsFixed(2), style: mainStyle,),
        )
    );
  }

  void _removeItem(OrderItem item){
    StateContainer.of(context).removeCartItem(item);
  }

  Widget _checkOut(){
    double total = StateContainer.of(context).getCart().getTotal();

    return GestureDetector(
        onTap: () => this._moveToPayment(),
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
                Text("Proceed to Payment", style: TextStyle(
                  color: Colors.white, fontSize: 24,)),
                Text("\$" + total.toStringAsFixed(2), style: TextStyle(
                  color: Colors.white, fontSize: 24,)),
              ],
            )
        )
    );
  }

  void _moveToPayment(){

  }

}