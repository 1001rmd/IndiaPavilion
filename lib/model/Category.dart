import '../model/MenuItem.dart';
import '../controller/Database.dart';

class Category {

  String name;
  List<MenuItem> itemList;

  Category(String name){
    this.name = name;
    buildList();
  }

  void buildList() async{
    itemList =  await Database.getCategory(name);
  }

  String getName(){
    return name;
  }

  List<MenuItem> getItems(){
    return itemList;
  }

}