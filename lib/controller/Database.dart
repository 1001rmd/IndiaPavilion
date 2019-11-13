import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/MenuItem.dart';

class Database {

    static Future<List<String>> getCategories() async{
      List<String> categories = new List();

      QuerySnapshot qs = await Firestore.instance.collection('menu').getDocuments();
      qs.documents.sort((a, b) {
        return a.data['Order'].compareTo(b.data['Order']);
      });
      qs.documents.forEach((doc){
        categories.add(doc.data['Name']);
      });
      
      return categories;
    }

    //Queries Firebase to get a category of Menu Items
    static Future<List<MenuItem>> getItems(String category) async{
      List<MenuItem> items = new List();

      QuerySnapshot qs = await Firestore.instance.collection('menu').document(category).collection('items').getDocuments();
      qs.documents.forEach((doc){
        items.add(new MenuItem(doc.data));
      });
      return items;
    }

}