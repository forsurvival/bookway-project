import 'package:bookway/login.dart';
import 'package:flutter/material.dart';
import 'login.dart';

final _usernamefieldtosave = TextEditingController();
final _passwordfieldtosave = TextEditingController();

bool reg() {
  String usr = _usernamefieldtosave.text;
  String pas = _passwordfieldtosave.text;
  if (userfield.text == usr &&
      passfield.text == pas &&
      userfield.text != "" &&
      passfield.text != "") {
    return true;
  }
}

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Cancel?'),
                content: new Text('Do You Want Cancel Register?'),
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
                        Navigator.of(context).push(_gotologin());
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
    final usernamefieldtosave = TextField(
      controller: _usernamefieldtosave,
      decoration: InputDecoration(
          hintText: "UserName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
    final passwordfieldtosave = TextField(
      controller: _passwordfieldtosave,
      decoration: InputDecoration(
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
    final registertosave = Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.teal,
        child: MaterialButton(
          onPressed: () {
            reg();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Done Now You Are Registred!!!'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).push(_gotologin());
                          },
                        )
                      ],
                    ));
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
                          usernamefieldtosave,
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          passwordfieldtosave,
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          registertosave,
                        ],
                      ))))),
    );
  }
}

class _gotologin extends MaterialPageRoute<Null> {
  _gotologin()
      : super(builder: (BuildContext context) {
          return login();
        });
}
