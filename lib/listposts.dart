import 'package:bookway/about.dart';
import 'package:bookway/login.dart';
import 'package:flutter/material.dart';
import 'package:bookway/webview.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String pos;
String usrnm = userfield.text;

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;

  ListViewPosts({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BookWay'),
          actions: <Widget>[],
          elevation: 2,
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
            elevation: 2,
            child: ListView(
              children: <Widget>[
                Image.asset('images/logo.png'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Welcome:' + ' ' + usrnm + ' '),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  color: Colors.teal,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(_gotoaboutpage());
                        },
                        child: Text('About Us')),
                  ],
                ),
                Divider(
                  height: 2,
                  color: Colors.teal,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.close),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(_gotologinpage());
                        },
                        child: Text('Log Out')),
                  ],
                ),
                Divider(
                  height: 2,
                  color: Colors.teal,
                ),
              ],
            )),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: ListView.builder(
                itemCount: posts.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(20),
                        onPressed: () {
                          Navigator.of(context).push(_gotowebview());
                          pos = posts[position].bu;
                        },
                        child: Card(
                          child: Text(
                            posts[position].bn,
                            style: TextStyle(fontSize: 40, color: Colors.teal),
                          ),
                          margin: EdgeInsets.all(20),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 5,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class _gotowebview extends MaterialPageRoute<Null> {
  _gotowebview()
      : super(builder: (BuildContext context) {
          return webv();
        });
}

Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/jb58f');

  return compute(parsePosts, response.body);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewPosts(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Post {
  final String bn;
  final String bu;

  Post({this.bn, this.bu});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      bn: json['bookname'] as String,
      bu: json['bookurl'] as String,
    );
  }
}

class _gotoaboutpage extends MaterialPageRoute<Null> {
  _gotoaboutpage()
      : super(builder: (BuildContext context) {
          return about();
        });
}

class _gotologinpage extends MaterialPageRoute<Null> {
  _gotologinpage()
      : super(builder: (BuildContext context) {
          return login();
        });
}
