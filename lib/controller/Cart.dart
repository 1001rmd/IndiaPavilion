import '../model/OrderItem.dart';
import 'dart:async';
import 'dart:developer' as developer;

class Cart{
  
  static final double _TAX_RATE = 0.06;
  List<OrderItem> _items;
  double price;
  double tax;
  double total;



  Cart() {
    _cartEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartAction event){

  }

  double getPrice(){
    return price;
  }

  void addItem(OrderItem item){
    
    _items.add(item);
    _calculatePrice();
    printCart();
  }

  void _calculatePrice(){

    price = 0;
    _items.forEach((OrderItem item){
      price += item.price;
    });

    tax = price * _TAX_RATE;
    total = price + tax;
  }

  void removeItem(OrderItem item){
    
    _items.remove(item);
    _calculatePrice();
  }

  void clearCart(){
    _items = new List<OrderItem>();
  }
  

  void placeOrder(){
    //TODO write cart to database
  }

  void dispose(){
    _itemListController.close();
    _cartEventController.close();
  }

  void printCart(){
    _items.forEach((i){
      developer.log(i.name);
    });
  }


}

abstract class CartAction {}

class AddToCart extends CartAction {
  OrderItem item;
  AddToCart(OrderItem item){
    this.item = item;
  }
}

class RemoveFromCart extends CartAction{}

class ClearCart extends CartAction {}