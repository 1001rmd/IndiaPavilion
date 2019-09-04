import "package:cloud_firestore/cloud_firestore.dart";
import "../model/MenuItem.dart";
import 'dart:developer' as developer;

class Database {


    static List<MenuItem> getMenu() {
      List<MenuItem> theList = new List();

      Firestore.instance.collection('menu').getDocuments()
          .then((docs) =>
          docs.documents.forEach((doc) =>
              theList.add(new MenuItem(doc.data))
          )
      );

      developer.log(theList.length.toString());
      return theList;
    }

}