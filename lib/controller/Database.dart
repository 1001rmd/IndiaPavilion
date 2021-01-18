import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:india_pavilion/model/MenuItem.dart';
import 'package:india_pavilion/model/UserData.dart';
import 'dart:developer' as developer;

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

    static void createUser(String userID, String name, String email, String phone){
      Map user = new Map<String, dynamic>();
      user['name'] = name;
      user['email'] = email;
      user['phone'] = phone;
      Firestore.instance.collection('users').document(userID).setData(user);
    }

    static Future<UserData> getUserData() async{
      String userId = await FirebaseAuth.instance.currentUser().then( (user) => user.uid );
      DocumentSnapshot rawData = await Firestore.instance.collection('users').document(userId).get();
      developer.log(rawData.documentID);
      UserData user = UserData(rawData);
      return user;
    }

    static Future<void> updateUser(UserData data) async{
      Map user = new Map<String, dynamic>();
      user['name'] = data.name;
      user['email'] = data.email;
      user['phone'] = data.phoneNumber;
      Firestore.instance.collection('users').document(data.userId).updateData(user);
    }

    static Future<void> updatePassword(String currentPass, String newPass) async{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      AuthCredential creds = EmailAuthProvider.getCredential(email: user.email, password: currentPass);
      await user.reauthenticateWithCredential(creds);
      user.updatePassword(newPass);
    }

}