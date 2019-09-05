import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/MenuItem.dart';
import '../model/Menu.dart';
import 'dart:developer' as developer;

class Database {


    static Future<Menu> getMenu() async{
      List<MenuItem> theList = new List();

      Firestore.instance.collection('menu').getDocuments()
          .then((docs) =>
          docs.documents.forEach((doc) =>
              theList.add(new MenuItem(doc.data))
          )


      );

      developer.log(theList.length.toString());
      return new Menu(theList);
    }

}