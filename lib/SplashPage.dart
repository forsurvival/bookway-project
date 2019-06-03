import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
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

  void navigationtonextpage() {
    Navigator.pushNamed(context, '/login');
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 5);
    return Timer(_duration, navigationtonextpage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Image.asset('images/logo.png'),
              Center(
                child: Text('By @ForSurvival'),
              )
            ],
          )),
    );
  }
}
