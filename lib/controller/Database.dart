import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/MenuItem.dart';
import '../model/Menu.dart';
import 'dart:developer' as developer;

class Database {

    //Queries Firebase to get the menu
    static Future<Menu> getMenu() async{
      List<MenuItem> theList = new List();

       QuerySnapshot qs = await Firestore.instance.collection('menu').getDocuments();
       qs.documents.forEach((doc){
         theList.add(new MenuItem(doc.data));
         developer.log(theList.length.toString());
       });
       return new Menu(theList);
    }

}