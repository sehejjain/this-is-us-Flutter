import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/components/ind_location_card.dart';
import 'package:thisisus/components/individual_drawer.dart';
import 'package:thisisus/models/LocationModel.dart';

class IndHomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const IndHomeScreen({Key key, this.user}) : super(key: key);

  @override
  _IndHomeScreenState createState() => _IndHomeScreenState();
}

class _IndHomeScreenState extends State<IndHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        loggedInUser: widget.user,
        enabled: 'Home',
      ),
      appBar: AppBar(
        title: Text('Home'),
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
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var vol = VolLoc.fromJson(ds.data);
                vol.id = ds.documentID;
                return IndLocationCard(
                  loc: vol,
                  user: widget.user,
                  bottomSheet: 'home',
                );
              },
            );
          }
        },
      ),
    );
  }
}
