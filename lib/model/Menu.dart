import 'MenuItem.dart';
import 'package:flutter/material.dart';

class Menu {

  List<MenuItem> theMenu;

  Menu(List<MenuItem> list){
    theMenu = list;
  }

  List<MenuItem> getMenuItems(){
    return theMenu;
  }

}