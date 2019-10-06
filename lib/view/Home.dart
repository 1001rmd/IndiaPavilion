import 'package:flutter/material.dart';
import '../controller/Auth.dart';
import '../controller/Database.dart';
import 'IPAppBar.dart';
import '../model/Menu.dart';
import '../model/Category.dart';
import '../model/MenuItem.dart';
import 'package:carousel_slider/carousel_slider.dart';

//This class is the entirety of the home page
class HomePage extends StatelessWidget {
  HomePage({this.auth, this.loggedOut});

  final Auth auth;
  final VoidCallback loggedOut;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new IPAppBar(context),
        drawer: new IPDrawer(loggedOut),

        //The body is a widget that changes based on if a category is selected
        body: new MenuDisplay()
    );
  }

}


//This widget contains only the main portion of the screen
class MenuDisplay extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MenuDisplayState();
  }

}


//This state determines which version of menu to show
class _MenuDisplayState extends State<MenuDisplay> {

  String category = '';

  @override
  Widget build(BuildContext context) {
    if (category == '') {
      return fullMenu();
    }
    else {
      return categoryMenu();
    }
  }

  void changeState(String category) {
    setState(() {
      this.category = category;
    });
  }


  //This state shows the categories of the menu
  Widget fullMenu() {
    return new Container(

        child: new SingleChildScrollView(

          child: new Column(
              children: <Widget>[

                /*new CarouselSlider(
                  items: buildPhotoList(),
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,),*/

                new Container(
                    child: new FutureBuilder(
                        future: Database.getMenu(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Menu> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Loading Menu');

                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return buildCategoryList(snapshot.data.getCategories());
                              }
                              break;

                            default:
                              return Text('Loading Menu');
                          }
                        }
                    )
                ),
              ]
          ),
        )
    );
  }

  Widget buildCategoryList(List<Category> dataList) {
    List<Widget> widgetList = new List();

    dataList.forEach((category) {
      widgetList.add(
          new Container(
            child: new FlatButton(
              child: Text(category.getName(), style: new TextStyle(fontSize: 20.0)),
              onPressed: () => changeState(category.getName()),
                focusColor: Color(0xFFDDDDDD)
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(border: Border.all(color: Color(0xFFDDDDDD))),
            //padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
            height: 60.0
          )
      );
    });

    return new Column(children: widgetList);
  }

  //This state shows the items in a specific category
  Widget categoryMenu() {

    return new SingleChildScrollView(
         child: new FutureBuilder(
             future: Database.getCategory(category),
             builder: (BuildContext context,
                 AsyncSnapshot<List<MenuItem>> snapshot) {
               switch (snapshot.connectionState) {
                 case ConnectionState.waiting:
                   return Text('Loading Menu');

                 case ConnectionState.done:
                   if (snapshot.hasError) {
                     return Text('Error: ${snapshot.error}');
                   } else {
                     return buildItemList(snapshot.data);
                   }
                   break;

                 default:
                   return Text('Loading Menu');
               }
             }
         )
     );

  }

  Widget buildItemList(List<MenuItem> dataList){

    List<Widget> widgetList = new List();

    //Back Button
    widgetList.add(
        new Container(
            child: new FlatButton(
                child: Text('Back', style: new TextStyle(fontSize: 20.0)),
                onPressed: () => changeState(''),
                focusColor: Color(0xFFDDDDDD)
            ),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFDDDDDD),
            //padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
            height: 60.0
        )
    );

    //Items
    dataList.forEach((item) {
      widgetList.add(
          new Container(
              child: new FlatButton(
                  child: Text(item.name, style: new TextStyle(fontSize: 20.0)),
                  onPressed: () => {},
                  focusColor: Color(0xFFDDDDDD)
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(color: Color(0xFFDDDDDD))),
              //padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
              height: 60.0
          )
      );
    });

    return new Column(children: widgetList);

  }

}

