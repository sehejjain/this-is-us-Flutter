import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/screens/org/create_vol_loc.dart';
import 'package:thisisus/services/user_repository.dart';

class AppDrawer extends StatefulWidget {
  final enabled;
  final FirebaseUser loggedInUser;

  AppDrawer({this.loggedInUser, this.enabled});

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
          ListTile(
            title: Text('Home'),
            enabled: widget.enabled != 'Home',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            title: Text('Create an opportunity'),
            enabled: widget.enabled != 'create',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateVolLoc(
                    user: widget.loggedInUser,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              Provider.of<UserRepository>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
