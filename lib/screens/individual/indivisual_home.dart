import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/components/LocationCard.dart';
import 'package:thisisus/models/LocationModel.dart';

class IndLandingScreen extends StatefulWidget {
  @override
  _IndLandingScreenState createState() => _IndLandingScreenState();
}

class _IndLandingScreenState extends State<IndLandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Implement Drawer
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Home'),
            FlatButton(
              //Temp Button. Remove when Drawer has been implemented.
              child: Text('Sign Out'),
              onPressed: () {
                _auth.signOut();
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("VolLocs").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var location = VolLoc(
                  creator: ds.data["creator"],
                  name: ds.data["name"],
                  contactPhone: ds.data["contact_phone"],
                  contactEmail: ds.data["contact_email"],
                  dateStart: DateTime.parse(
                      (ds.data["dateStart"]).toDate().toString()),
                  dateEnd:
                  DateTime.parse((ds.data["dateEnd"]).toDate().toString()),
                  location: ds.data["location"],
                  desc: ds.data["desc"],
                  id: ds.documentID,
                  dateCreated: DateTime.parse(
                      (ds.data["dateCreated"]).toDate().toString()),
                );
                return LocationCard(location);
              },
            );
          }
        },
      ),
    );
  }
}
