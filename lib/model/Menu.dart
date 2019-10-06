import 'MenuItem.dart';
import 'Category.dart';
import 'package:flutter/material.dart';

class Menu {

  List<MenuItem> theMenu;
  List<Category> categories;

  //Old Constructor
  Menu(List<MenuItem> list){
    theMenu = list;
  }

  Menu.general(){
    categories = new List();
    categories.add(new Category('Appetizers'));
    categories.add(new Category('Soup'));
    categories.add(new Category('Tandoori'));
    categories.add(new Category('Seafood'));
    categories.add(new Category('Lamb'));
    categories.add(new Category('Chicken'));
    categories.add(new Category('Vegetarian'));
    categories.add(new Category('Rice Specialties'));
    categories.add(new Category('Indian Breads'));
    categories.add(new Category('Sides'));
    categories.add(new Category('Beverages'));
    categories.add(new Category('Dessert'));
  }

  List<MenuItem> getMenuItems(){
    return theMenu;
  }

  List<Category> getCategories(){
    return categories;
  }




}