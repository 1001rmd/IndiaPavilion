import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:validators/validators.dart';
import 'package:india_pavilion/controller/Auth.dart';
import 'package:india_pavilion/controller/Database.dart';


class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.signedIn});
  final Auth auth;
  final VoidCallback signedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  //User information
  String _email;
  String _password;
  String _name;
  String _phoneNumber;

  //Form information
  final formKey = new GlobalKey<FormState>();
  final passKey = new GlobalKey<FormFieldState>();
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: null,
        body: buildForm()
    );
  }

  //Validates and Saves the form
  bool save(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  //Attempts to log in with form data
  void login() async{

    String userID;

    if(save()){
      try {
        userID = await widget.auth.signIn(_email, _password);
      }catch(e){
        print(e);
      }

      if(userID != null) {
        widget.signedIn();
      }else{
        formKey.currentState.reset();
      }
    }
  }

  void createUser() async{
    if(save()){

      String userID;

      try {
        userID =  await widget.auth.create(_email, _password);
        Database.createUser(userID, _name, _email, _phoneNumber);
        toLogin();
      } catch (e) {
        print(e);
      }

      if(userID != null){
        login();
      }

    }
  }


  //Sets the form to register a new user
  void toRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  //Sets the form to log in an established user
  void toLogin(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.login;
    });
  }

  //Decides whether to build the login form or the register form
  Widget buildForm(){
    if(_formType == FormType.login){
      return loginForm();
    }else{
      return registerForm();
    }
  }

  //Builds the login form
  Container loginForm(){
    return
      new Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal:  20.0),
        color: Theme.of(context).primaryColor,
        child: new Form(
        key: formKey,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
              child: new TextFormField(
                  decoration: new InputDecoration(
                      labelText: "Email",
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true
                  ),
                  validator: (value) => value.isEmpty ? "Email is empty" : null,
                  onSaved: (value) => _email = value
              )
            ),
            new Container(
              padding:  EdgeInsets.fromLTRB( 0.0, 20.0, 0.0, 40.0),
              child: new TextFormField(
                decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: const Color(0xFFFFFFFF),
                    filled: true
                ),
                validator: (value) => value.isEmpty ? "Password is empty" : null,
                onSaved: (value) => _password = value,
                obscureText: true,
              )
            ),
            new ButtonTheme(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              buttonColor: Theme.of(context).accentColor,
              child: new RaisedButton(
                child: new Text("Login", style: new TextStyle(color: Color(0xFFFFFFFF), fontSize: 36.0)),
                onPressed: login,
              )
            ),
            new Container(
              child: new ButtonTheme(
                  child: new FlatButton(
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0, 0),
                      onPressed: toRegister,
                      child: new Text("Create an Account", style: new TextStyle(color: Color(0xFFFFFFFF), fontSize: 20.0))
                  )
              )
            )
          ]
        )
      )
    );
  }

  //Builds the register form
  SingleChildScrollView registerForm(){
    return
      new SingleChildScrollView(
        child: new Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal:  20.0),
            color: Theme.of(context).primaryColor,
            child: new Form(
                key: formKey,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new SizedBox(width: double.infinity, height: 60.0),

                      new Container( //Name
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                          child: new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Name",
                                  fillColor: const Color(0xFFFFFFFF),
                                  filled: true
                              ),
                              validator: (value) => value.isEmpty ? "Name is empty" : null,
                              onSaved: (value) => _name = trim(value)
                          )
                      ),

                      new Container( //Phone Number
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                          child: new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Phone Number",
                                  fillColor: const Color(0xFFFFFFFF),
                                  filled: true
                              ),
                              validator: (value) {
                                if(value.isEmpty){
                                  return "Phone Number is empty";
                                }else if(!isNumeric(value)){
                                  return "Phone Number should contain only numbers";
                                }else if(value.length < 10){
                                  return "Phone Number should be 10 digits long";
                                }else{
                                  return null;
                                }
                              },
                              onSaved: (value) => _phoneNumber = value
                          )
                      ),

                      new Container( //Email
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                          child: new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Email",
                                  fillColor: const Color(0xFFFFFFFF),
                                  filled: true
                              ),
                              validator: (value) {
                                if(value.isEmpty){return "Email is empty";}
                                bool good = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                                return good ? null : "Email is not valid";
                              },
                              onSaved: (value) => _email = trim(value)
                          )
                      ),

                      new Container( //Password 1
                          padding:  EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                          child: new TextFormField(
                            key: passKey,
                            decoration: new InputDecoration(
                                labelText: "Password",
                                fillColor: const Color(0xFFFFFFFF),
                                filled: true
                            ),
                            validator: (value) => value.length < 8 ? "Password must be at least 8 characters" : null,
                            onSaved: (value) => _password = value,
                            obscureText: true,
                          )
                      ),

                      new Container( //Password 2
                          padding:  EdgeInsets.fromLTRB( 0.0, 20.0, 0.0, 40.0),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "Retype Password",
                                fillColor: const Color(0xFFFFFFFF),
                                filled: true
                            ),
                            validator: (value) {
                              return equals(value, passKey.currentState.value) ? null : "Passwords do not match";
                            },
                            obscureText: true,
                          )
                      ),

                      new ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                          buttonColor: Theme.of(context).accentColor,
                          child: new RaisedButton(
                            child: new Text("Create Account", style: new TextStyle(color: Color(0xFFFFFFFF), fontSize: 30.0)),
                            onPressed: createUser,
                          )
                      ),

                      new Container(
                          child: new ButtonTheme(
                              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0, 40.0),
                              child: new FlatButton(
                                  onPressed: toLogin,
                                  child: new Text("Log In", style: new TextStyle(color: Color(0xFFFFFFFF), fontSize: 20.0))
                              )
                          )
                      )
                    ]
                )
            )
        )
      );
  }

}