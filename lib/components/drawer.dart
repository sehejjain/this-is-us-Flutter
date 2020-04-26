import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final FirebaseUser loggedInUser;

  AppDrawer({this.loggedInUser});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text(
                    'This Is Us',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    widget.loggedInUser.email,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              decoration: new BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
