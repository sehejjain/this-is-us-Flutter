import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/components/ind_location_card.dart';
import 'package:thisisus/components/individual_drawer.dart';
import 'package:thisisus/models/LocationModel.dart';

class AppliedScreen extends StatefulWidget {
  final FirebaseUser user;

  AppliedScreen({this.user});

  @override
  _AppliedScreenState createState() => _AppliedScreenState();
}

class _AppliedScreenState extends State<AppliedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Locations'),
      ),
      drawer: AppDrawer(
        enabled: 'applied',
        loggedInUser: widget.user,
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
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              CollectionReference applicants =
                  ds.reference.collection('Applicants');
              return StreamBuilder(
                stream: applicants.snapshots(),
                builder: (context, snapshot2) {
                  if (!snapshot2.hasData)
                    return SafeArea(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  //print(snapshot2.data.documents);
                  for (var x in snapshot2.data.documents) {
                    if (x.data["userID"] == widget.user.uid) {
                      var vol = VolLoc.fromJson(ds.data);

                      return IndLocationCard(
                        loc: vol,
                        user: widget.user,
                      );
                    }
                  }
                  return Text('');
                },
              );
            },
          );
        },
      ),
    );
  }
}
