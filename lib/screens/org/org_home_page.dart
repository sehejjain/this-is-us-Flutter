import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/services/user_repository.dart';

class OrgLandingScreen extends StatefulWidget {
  final FirebaseUser user;

  OrgLandingScreen({this.user});

  @override
  _OrgLandingScreenState createState() => _OrgLandingScreenState();
}

class _OrgLandingScreenState extends State<OrgLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Home'),
            FlatButton(
              //Temp Button. Remove when Drawer has been implemented.
              child: Text('Sign Out'),
              onPressed: () {
                Provider.of<UserRepository>(context, listen: false).signOut();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Org Home'),
          ),
        ),
      ),
    );
  }
}
