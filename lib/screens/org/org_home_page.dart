import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/components/org_drawer.dart';
import 'package:thisisus/components/org_location_card.dart';
import 'package:thisisus/models/LocationModel.dart';
import 'package:thisisus/services/user_repository.dart';

class OrgHomeScreen extends StatefulWidget {
  final FirebaseUser user;

  OrgHomeScreen({this.user});

  @override
  _OrgHomeScreenState createState() => _OrgHomeScreenState();
}

class _OrgHomeScreenState extends State<OrgHomeScreen> {
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        loggedInUser: widget.user,
        enabled: 'Home',
      ),
      appBar: AppBar(
        title: Text('My Locations'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('VolLocs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text('No Opportunities created yet'),
              );
            }
            for (var document in snapshot.data.documents) {
              var loc = VolLoc.fromJson(document.data);

              if (loc.creator == widget.user.uid) {
                widgets.add(
                  OrgLocationCard(
                    loc: loc,
                    user: widget.user,
                    bottomSheet: 'home',
                  ),
                );
              }
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var loc = VolLoc.fromJson(ds.data);
                loc.id = ds.documentID;
                if (snapshot.data.documents[index].data['creator'] ==
                    widget.user.uid) {
                  return OrgLocationCard(
                    loc: loc,
                    user: widget.user,
                    bottomSheet: 'home',
                  );
                } else
                  //empty container, doesn't work otherwise
                  return Container();
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }
}
