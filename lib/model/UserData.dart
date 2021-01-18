import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{

  String phoneNumber;
  String name;
  String email;
  String userId;


  UserData(DocumentSnapshot rawUser){
    phoneNumber = rawUser.data['phone'];
    name = rawUser.data['name'];
    email = rawUser.data['email'];
    userId = rawUser.documentID;
  }

}