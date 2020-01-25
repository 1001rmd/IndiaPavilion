
class MenuItem{

  String name;
  String category;
  String description;
  double price;
  bool spiceLvl;
  bool favorite;

  MenuItem(Map<String, dynamic> data){

    name = data["name"];
    category = data["category"];
    description = data["description"];
    price = data["price"];
    spiceLvl = data["spicelvl"];
    favorite = data["favorite"];

  }


}