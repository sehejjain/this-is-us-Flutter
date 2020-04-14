import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  var userType;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
//        Timer.run(() {
//          Navigator.pushNamed(context, 'getStarted');
//        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  Future<int> getUserType() async {
    var document = Firestore.instance
        .collection("UserTypes")
        .document(await getUID())
        .get();
    return await document.then((doc) {
      print(doc.data['type']);
      return doc.data['type'];
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    userType = getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                top: 125,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 450,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Hero(
                                tag: 'mainLogo',
                                child: Material(
                                  child: SizedBox(
                                    height: 275,
                                    width: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16,
                                        left: 16,
                                        right: 16,
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        color: Colors.black,
                                        child: Center(
                                          child: Text(
                                            'This is Us',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(
                                height: 80,
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      'Matching You to Your Cause',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'signUp');
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text('VolLoc'),
                      onPressed: () {
                        Navigator.pushNamed(context, 'createVolLoc');
                      },
                    ),
                    FlatButton(
                      child: Text('Home'),
                      onPressed: () {
                        Navigator.pushNamed(context, 'userHome');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
