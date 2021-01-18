import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
import 'package:india_pavilion/controller/Database.dart';
import 'package:india_pavilion/model/UserData.dart';


class Account extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Account"), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal:  20.0),
          child:Column(
            children: <Widget>[
              UpdateAcctInfo(),
              UpdatePassword()
            ],
          )
        )
      )
    );
  }

}

/*
  This form is for updating the user's name and phone number
 */
class UpdateAcctInfo extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>  new UpdateAcctState();

}

class UpdateAcctState extends State<UpdateAcctInfo>{

  UserData _user;
  final infoKey = new GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    Database.getUserData().then((user) => setState(() => _user = user));
  }

  _updateAcctInfo() async{

    final form = infoKey.currentState;
    if(form.validate()){
      form.save();
      Database.updateUser(_user)
          .then((voidData) => Database.getUserData())
          .then((user) => setState(() => _user = user));
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: Text("Account updated"))
      );
    }
  }

  updateName(String name){
    setState(() {
      _user.name = name;
    });
  }

  updatePhone(String phone){
    setState(() {
      _user.phoneNumber = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return Text("Loading...");
    }
    else {
      return Form(
          key: infoKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container( //Name
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Name",
                          fillColor: const Color(0xFFFFFFFF),
                          filled: true
                      ),
                      initialValue: _user.name,
                      validator: (value) =>
                      value.isEmpty
                          ? "Name is empty"
                          : null,
                      onChanged: (value) => updateName(value)
                  )
              ),
              new Container( //Phone Number
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Phone Number",
                          fillColor: const Color(0xFFFFFFFF),
                          filled: true
                      ),
                      initialValue: _user.phoneNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Phone Number is empty";
                        } else if (!isNumeric(value)) {
                          return "Phone Number should contain only numbers";
                        } else if (value.length < 10) {
                          return "Phone Number should be 10 digits long";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => updatePhone(value)
                  )
              ),
              new ButtonTheme(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                  buttonColor: Theme
                      .of(context)
                      .accentColor,
                  child: new RaisedButton(
                    child: new Text("Update Info", style: new TextStyle(
                        color: Color(0xFFFFFFFF), fontSize: 30.0)),
                    onPressed: _updateAcctInfo,
                  )
              ),
            ],
          )
      );
    }
  }

}


/*
  This form is for updating the user's password
*/
class UpdatePassword extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>  new UpdatePassState();

}

class UpdatePassState extends State<UpdatePassword> {

  String _currentPass;
  String _newPass;
  String _confirmPass;
  final passKey = new GlobalKey<FormState>();

  _updatePass() {
    final form = passKey.currentState;
    if(form.validate()){
      form.save();
      Database.updatePassword(_currentPass, _newPass);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: Text("Account updated"))
      );
    }
  }

  updateCurrent(String currentPass) {
    setState(() {
      _currentPass = currentPass;
    });
  }

  updateNew(String newPass) {
    setState(() {
      _newPass = newPass;
    });
  }

  updateConfirm(String confirmPass) {
    setState(() {
      _confirmPass = confirmPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: passKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container( //Current
                padding: EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 0.0),
                child: new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Current Password",
                        fillColor: const Color(0xFFFFFFFF),
                        filled: true
                    ),
                    validator: (value) =>
                    value.length < 8
                        ? "Password must be at least 8 characters"
                        : null,
                    onSaved: (value) => updateCurrent(value),
                    obscureText: true,
                )
            ),
            new Container( //New
                padding: EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 0.0),
                child: new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "New Password",
                        fillColor: const Color(0xFFFFFFFF),
                        filled: true
                    ),
                    validator: (value) =>
                    value.length < 8
                        ? "Password must be at least 8 characters"
                        : null,
                    onSaved: (value) => updateNew(value),
                    obscureText: true,
                )
            ),
            new Container( //Confirm
                padding: EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 0.0),
                child: new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Confirm New Password",
                        fillColor: const Color(0xFFFFFFFF),
                        filled: true
                    ),
                    validator: (value) =>
                    value == _newPass
                        ? "Passwords do not match"
                        : null,
                    onSaved: (value) => updateConfirm(value),
                    obscureText: true,
                )
            ),
            new ButtonTheme(
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 0.0),
                buttonColor: Theme
                    .of(context)
                    .accentColor,
                child: new RaisedButton(
                  child: new Text("Update Password", style: new TextStyle(
                      color: Color(0xFFFFFFFF), fontSize: 30.0)),
                  onPressed: _updatePass,
                )
            ),
          ],
        )
    );
  }
}