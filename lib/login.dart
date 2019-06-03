import 'package:bookway/listposts.dart';
import 'package:bookway/register.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'register.dart';

final passfield = TextEditingController();
final userfield = TextEditingController();

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit to App'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: FlatButton(child: Text('No')),
                  ),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final usernamefield = TextField(
      controller: userfield,
      decoration: InputDecoration(
          hintText: "UserName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
    final passwordfield = TextField(
      controller: passfield,
      decoration: InputDecoration(
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
    final loginButon = Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.teal,
        child: MaterialButton(
          onPressed: () {
            if (reg() == true) {
              Navigator.of(context).push(_gotohomepage());
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Not Found!!!'),
                        content: new Text('Plz Register!!!'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).push(_gotregisterpage());
                            },
                          )
                        ],
                      ));
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
          ),
          textColor: Colors.white,
        ));
    final registerButon = Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.teal,
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(_gotregisterpage());
          },
          child: Text(
            "Register",
            textAlign: TextAlign.center,
          ),
          textColor: Colors.white,
        ));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  usernamefield,
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  passwordfield,
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  loginButon,
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  registerButon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _gotohomepage extends MaterialPageRoute<Null> {
  _gotohomepage()
      : super(builder: (BuildContext context) {
          return HomePage();
        });
}

class _gotregisterpage extends MaterialPageRoute<Null> {
  _gotregisterpage()
      : super(builder: (BuildContext context) {
          return register();
        });
}
