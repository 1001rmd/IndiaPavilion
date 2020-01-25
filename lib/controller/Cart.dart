import '../model/OrderItem.dart';
import 'dart:developer' as developer;

class Cart{
  
  static final Cart _instance =  Cart._create();
  
  static final double _TAX_RATE = 0.06;
  static List<OrderItem> items;
  static double price;
  static double tax;
  static double total;

  factory Cart() {
    return _instance;
  }
  
  Cart._create(){
    items = new List<OrderItem>();
    price = 0;
    tax = 0;
    total = 0;
  }
  
  void addItem(OrderItem item){
    
    items.add(item);
    _calculatePrice();
    printCart();
  }

  void _calculatePrice(){

    price = 0;
    items.forEach((OrderItem item){
      price += item.price;
    });

    tax = price * _TAX_RATE;
    total = price + tax;
  }

  void removeItem(OrderItem item){
    
    items.remove(item);
    _calculatePrice();
  }

  void clearCart(){
    items = new List<OrderItem>();
  }
  

  void placeOrder(){
    //TODO write cart to database
  }

  void printCart(){
    items.forEach((i){
      developer.log(i.name);
    });
  }


}