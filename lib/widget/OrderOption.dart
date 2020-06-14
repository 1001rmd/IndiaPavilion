import 'package:flutter/material.dart';
import 'package:india_pavilion/controller/StateContainer.dart';
import 'package:india_pavilion/model/MenuItem.dart';
import 'package:india_pavilion/model/OrderItem.dart';


class OrderOption extends StatefulWidget {

  final MenuItem mItem;

  const OrderOption(this.mItem);

  @override
  State<StatefulWidget> createState() => new _ItemState();
}

class _ItemState extends State<OrderOption> {

  //State
  OrderItem oItem;

  //Styles & Dropdown list
  static Color _textColor = Color(0xFF000000);
  TextStyle _textStyle = TextStyle(
      fontFamily: 'sans-serif',
      fontSize: 24,
      color: _textColor,
  );
  TextStyle _labels = TextStyle(
      fontFamily:  'sans-serif',
      fontSize: 18,
      color: _textColor,
      decoration: TextDecoration.underline,
      decorationColor: _textColor,
      decorationStyle: TextDecorationStyle.solid
  );
  List<DropdownMenuItem<String>> spiceLvls = [
    DropdownMenuItem(
        child: Text('Mild'),
        value: 'Mild'
    ),
    DropdownMenuItem(
        child: Text('Medium'),
        value: 'Medium'
    ),
    DropdownMenuItem(
        child: Text('Hot'),
        value: 'Hot'
    ),
  ];

  @override
  void initState(){
    super.initState();
    oItem = new OrderItem();
    oItem.quantity = 1;
    oItem.price = widget.mItem.price;
    oItem.name = widget.mItem.name;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: SizedBox(
        height: _getHeight(),
        width: 300.0,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*Container(
                width: double.infinity,
                //TODO: Fix right padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),*/
              SizedBox(
                height: 35.0,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(oItem.name, style: _textStyle),
                    SizedBox(height: 25.0),
                    Column(
                        children: <Widget>[
                          Text('Quantity', style: _labels),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                child: Icon(Icons.remove, color: _textColor),
                                onPressed: _decrementQuantity,
                              ),
                              Text(oItem.quantity.toString(), style: _textStyle),
                              FlatButton(
                                child: Icon(Icons.add, color: _textColor),
                                onPressed: _incrementQuantity,
                              )
                            ],
                          ),
                          _spiceLvl()
                        ]
                    )
                  ],
                )
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0) ),
                  color: Theme.of(context).accentColor
                ),
                child: FlatButton(
                  onPressed: _addToCart,
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  )
                )
              )
            ],
          )
        ),
      )
    );
  }


  double _getHeight(){
    if(widget.mItem.spiceLvl){
      return 350.0;
    }else{
      return 250.0;
    }
  }

  Widget _spiceLvl(){
    if(widget.mItem.spiceLvl){
      return Column(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text('Spice Level', style: _labels,),
          Theme(
            data: ThemeData(canvasColor: Theme.of(context).accentColor, hintColor: Colors.white),
            child: DropdownButton(
                value: oItem.spiceLvl,
                hint: Text('Choose one', style: TextStyle(color: _textColor),),
                items: spiceLvls,
                onChanged: (value) => _updateSpice(value),
                style: TextStyle(
                  color: _textColor,
                )
            )
          ),
        ],
      );
    }else{
      return SizedBox(height: 0);
    }
  }

  void _incrementQuantity() {
    if(oItem.quantity < 10){
      setState(() {
        oItem.quantity++;
      });
      _updatePrice();
    }
  }

  void _decrementQuantity() {
    if(oItem.quantity > 1){
      setState(() {
        oItem.quantity--;
      });
      _updatePrice();
    }
  }

  void _updateSpice(value){
    setState(() {
      oItem.spiceLvl = value;
    });
  }

  void _updatePrice() {
    oItem.price = widget.mItem.price * oItem.quantity;
  }

  void _addToCart(){
    if(widget.mItem.spiceLvl && oItem.spiceLvl == null){
      oItem.spiceLvl = "Mild";
    }

    StateContainer.of(context).addCartItem(oItem);
    Navigator.pop(context);
  }

}