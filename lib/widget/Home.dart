import 'package:flutter/material.dart';
import 'package:india_pavilion/controller/Auth.dart';
import 'package:india_pavilion/controller/Menu.dart';
import 'package:india_pavilion/model/MenuItem.dart';
import 'IPAppBar.dart';
import 'CartBar.dart';
import 'OrderOption.dart';
import 'HomeSlideshow.dart';


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
        body: new MenuDisplay(),
        //The footer displays cart information
        bottomNavigationBar: CartBar()

    );
  }

}


//This widget contains only the main portion of the screen
class MenuDisplay extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _MenuDisplayState();

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

                new HomeSlideshow(),

                new Container(
                    child: new FutureBuilder(
                        future: Menu.getMenu().getCategories(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Loading Menu');

                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return buildCategoryList(snapshot.data);
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

  Widget buildCategoryList(List<String> dataList) {
    List<Widget> widgetList = new List();

    dataList.forEach((category) {
      widgetList.add(
          new Container(
            child: new FlatButton(
              child: Text(category, style: new TextStyle(fontSize: 20.0)),
              onPressed: () => changeState(category),
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
             future: Menu.getMenu().getItems(category),
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
          buildItemCard(item)
      );
    });

    return new Column(children: widgetList);

  }


  Widget buildItemCard(MenuItem item){

    return Container(
      decoration: BoxDecoration(border: Border(
          top: BorderSide(width: 1.0, color: Color(0xFFDDDDDD)),
          bottom: BorderSide(width: 1.0, color: Color(0xFFDDDDDD))
      )),
      child: ListTile(
            enabled: true,
            onTap: () => showItemDialog(item),
            contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 7),
            title: Text(item.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold
              ),),
            subtitle:Text(item.description,
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color:Colors.grey
              ),),
            trailing: Text(("\$" + item.price.toStringAsFixed(2)),
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),)
        )
    );


  }

  showItemDialog(MenuItem item){
    showDialog(
      context: context,
      builder: (BuildContext context) => OrderOption(item)
    );
  }


}

