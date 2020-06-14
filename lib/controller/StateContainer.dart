import 'package:flutter/widgets.dart';
import 'package:india_pavilion/model/Cart.dart';
import 'package:india_pavilion/model/OrderItem.dart';

class StateContainer extends StatefulWidget{

  final Widget child;

  StateContainer(this.child);

  @override
  State<StatefulWidget> createState() => new GlobalState();


  static GlobalState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedContainer>().state;
  }

}

class GlobalState extends State<StateContainer>{

  Cart cart;

  @override
  Widget build(BuildContext context) {
    return InheritedContainer(
      this,
      widget.child
    );
  }


  void addCartItem(OrderItem item){
    setState(() {
      _checkCart();
      this.cart.addItem(item);
    });
  }

  void removeCartItem(OrderItem item){
    setState(() {
      _checkCart();
      this.cart.removeItem(item);
    });
  }

  Cart getCart(){
    _checkCart();
    return this.cart;
  }

  void _checkCart(){
    if(this.cart == null){
      this.cart = new Cart();
    }
  }

}

class InheritedContainer extends InheritedWidget{

  final GlobalState state;

  InheritedContainer(this.state, Widget child): super(child: child);

  @override
  bool updateShouldNotify(InheritedContainer oldWidget) {
    return oldWidget.state.getCart().equals(this.state.getCart());
  }

}