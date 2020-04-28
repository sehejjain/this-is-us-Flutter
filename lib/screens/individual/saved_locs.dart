import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/components/LocationCard.dart';
import 'package:thisisus/components/drawer.dart';
import 'package:thisisus/models/LocationModel.dart';

class SavedLocsScreen extends StatefulWidget {
  final FirebaseUser user;

  SavedLocsScreen({this.user});

  @override
  _SavedLocsScreenState createState() => _SavedLocsScreenState();
}

class _SavedLocsScreenState extends State<SavedLocsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Locations'),
      ),
      drawer: AppDrawer(
        loggedInUser: widget.user,
        enabled: 'saved',
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("SavedLocs")
            .document(widget.user.uid)
            .collection('SavedUserLocs')
            .snapshots(),
        builder: (context, snapshot1) {
          if (!snapshot1.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            print(snapshot1.data.documents.length);
            if (snapshot1.data.documents.length == 0)
              return Container(
                child: Center(
                  child: Text('You\'ve not added anything yet'),
                ),
              );
            return Container(
              height: 1000,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot1.data.documents.length,
                itemBuilder: (context, index) {
                  print(snapshot1.data.documents.length);
                  return StreamBuilder(
                    stream: Firestore.instance
                        .collection('VolLocs')
                        .document(
                            (snapshot1.data.documents[index]).data["locID"])
                        .snapshots(),
                    builder: (context, snapshot2) {
                      if (!snapshot2.hasData) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        DocumentSnapshot ds = snapshot2.data;
                        var location = VolLoc(
                          creator: ds.data["creator"],
                          name: ds.data["name"],
                          contactPhone: ds.data["contact_phone"],
                          contactEmail: ds.data["contact_email"],
                          dateStart: DateTime.parse(
                              (ds.data["dateStart"]).toDate().toString()),
                          dateEnd: DateTime.parse(
                              (ds.data["dateEnd"]).toDate().toString()),
                          location: ds.data["location"],
                          desc: ds.data["desc"],
                          id: ds.documentID,
                          dateCreated: DateTime.parse(
                              (ds.data["dateCreated"]).toDate().toString()),
                        );

                        return LocationCard(
                          loc: location,
                          user: widget.user,
                          bottomSheet: 'saved',
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
