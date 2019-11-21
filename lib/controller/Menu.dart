import '../model/MenuItem.dart';
import 'Database.dart';

class Menu{

  //TODO: may need to clear menu data
  //I'm hoping the data with clear automatically on app start


  static Menu _menu;
  static List<String> categoryCache;
  static Map<String, List<MenuItem>> itemCache;

  //Static Menu Class
  static Menu getMenu(){

    if(_menu==null) {
      _menu = new Menu();
      itemCache = new Map();
    }

    return _menu;
  }


  //Gets the categories from the database then caches them
  Future<List<String>> getCategories() async{

    if(categoryCache==null) {
      categoryCache = await Database.getCategories();
    }

    return categoryCache;

  }

  //Gets the items in a specific category and the caches them
  Future<List<MenuItem>> getItems(String category) async{

    if(itemCache.containsKey(category)){
      return itemCache[category];
    }
    else{
      itemCache[category] = await Database.getItems(category);
      return itemCache[category];
    }

  }

}