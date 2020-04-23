import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/components/LocationCard.dart';
import 'package:thisisus/models/LocationModel.dart';

class IndLandingScreen extends StatefulWidget {
  @override
  _IndLandingScreenState createState() => _IndLandingScreenState();
}

class _IndLandingScreenState extends State<IndLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
