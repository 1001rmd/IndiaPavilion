import 'OrderItem.dart';
import 'dart:developer' as dev;

class Cart{
  
  static final double _TAX_RATE = 0.06;
  List<OrderItem> _items;
  double price;
  double tax;
  double total;



  Cart() {
    _items = new List<OrderItem>();
    _calculatePrice();
  }

  int getItemCount(){
    return _items.length;
  }

  double getPrice(){
    return price;
  }

  double getTax() {
    return tax;
  }

  double getTotal() {
    return total;
  }

  List<OrderItem> getItems(){
    return _items;
  }

  void addItem(OrderItem item){
    
    _items.add(item);
    _calculatePrice();

  }

  void _calculatePrice(){

    price = 0;
    if(_items.length > 0) {
      _items.forEach((OrderItem item) {
        price += item.price;
      });
    }

    tax = price * _TAX_RATE;
    total = price + tax;

  }

  void removeItem(OrderItem item){
    _items.remove(item).toString();
    _calculatePrice();

  }

  void clearCart(){

    _items = new List<OrderItem>();
    _calculatePrice();

  }
  

  void placeOrder(){
    //TODO write cart to database
  }

  bool hasItems(){
    return _items.length > 0;
  }

  bool equals(Cart other){
    return _items == other._items;
  }

  //TODO remove this for production
  void printCart(){
    dev.log(this.price.toString());
    _items.forEach((i){
      dev.log(i.name);
    });

  }


}