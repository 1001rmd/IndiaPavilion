import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {

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
  String _passwordRetype;

  //Form information
  final formKey = new GlobalKey<FormState>();
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
  void login(){
    if(save()){
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print("success");
      }catch(e){
        print(e);
      }
    }
  }

  void createUser(){
    if(save()){
      if(_password.compareTo(_passwordRetype) != 0){
        print("Passwords do not match");
        //TODO Inform User of password mismatch
      }else {
        try {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password);
          //TODO Add Data to Users table
          toLogin();
        } catch (e) {
          print(e);
        }
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
    //TODO Redirect to Home page
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
        color: const Color(0xFF590987),
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
            color: const Color(0xFF590987),
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
                              onSaved: (value) => _name = value
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
                              validator: (value) => (value.length != 10) ? "Not a Phone Number" : null,
                              //TODO Validate Phone Number
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
                              validator: (value) => value.isEmpty ? "Email is empty" : null,
                              onSaved: (value) => _email = value
                          )
                      ),
                      new Container( //Password 1
                          padding:  EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "Password",
                                fillColor: const Color(0xFFFFFFFF),
                                filled: true
                            ),
                            validator: (value) => value.length < 6 ? "Password is empty" : null,
                            onSaved: (value) => _password = value,
                            obscureText: true,
                          )
                      ),
                      new Container( //Password 2
                          padding:  EdgeInsets.fromLTRB( 0.0, 20.0, 0.0, 40.0),
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                labelText: " Retype Password",
                                fillColor: const Color(0xFFFFFFFF),
                                filled: true
                            ),
                            validator: (value) => value.length < 6 ? "Passwords do not match" : null,
                            onSaved: (value) => _passwordRetype = value,
                            obscureText: true,
                          )
                      ),
                      new ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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