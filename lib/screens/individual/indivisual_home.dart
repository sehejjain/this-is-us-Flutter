import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thisisus/components/LocationCard.dart';
import 'package:thisisus/models/LocationModel.dart';
import 'package:thisisus/services/vollocs.dart';

class IndLandingScreen extends StatefulWidget {
  @override
  _IndLandingScreenState createState() => _IndLandingScreenState();
}

class _IndLandingScreenState extends State<IndLandingScreen> {
  VolLocBrain brain = VolLocBrain();
  GeoPoint currLoc;

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    } catch (e) {
      print(e);
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.lowest);
      currLoc = GeoPoint(position.latitude, position.longitude);
    }
  }

  List<VolLoc> list;

  @override
  void initState() {
    super.initState();
    //brain.getLocations();
    list = brain.getListLoc();
  }

  List<Widget> getWidgets() {
    List<Widget> cards = [];
    for (var loc in list) {
      cards.add(LocationCard(loc));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: getWidgets(),
      ),
    );
  }
}
