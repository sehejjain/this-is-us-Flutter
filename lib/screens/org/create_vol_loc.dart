import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:thisisus/components/text_card.dart';
import 'package:thisisus/models/LocationModel.dart';

class CreateVolLoc extends StatefulWidget {
  @override
  _CreateVolLocState createState() => _CreateVolLocState();
}

class _CreateVolLocState extends State<CreateVolLoc> {
  Future<LocationResult> showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyCYFdGWM2mkC3B45CGn3YDXDl979cMt81c")));
    // Handle the result in your way
    return result;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
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

  String name;
  String email;
  String phone;
  LocationResult location;
  DateTime start;
  DateTime end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is Us'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Create a Volunteering Location',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            TextCard(
                hintText: 'Name',
                icon: FontAwesomeIcons.arrowRight,
                onChange: (value) {
                  name = value;
                }),
            TextCard(
                hintText: 'Email',
                icon: Icons.email,
                keyboard: TextInputType.emailAddress,
                onChange: (value) {
                  email = value;
                }),
            TextCard(
                hintText: 'Phone',
                icon: FontAwesomeIcons.phone,
                keyboard: TextInputType.number,
                onChange: (value) {
                  phone = value;
                }),
            TextCard(
                hintText: 'Date',
                icon: FontAwesomeIcons.arrowRight,
                onChange: (value) {
                  name = value;
                }),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.locationArrow),
                    title: Text(
                      location == null
                          ? '    Pick a Location'
                          : '    Somewhere'
                              ' in ${location.name}',
                      style: TextStyle(
                          fontSize: 20,
                          color: location == null ? Colors.grey : Colors.black),
                    ),
                  ),
                  onPressed: () async {
                    setState(() async {
                      location = await showPlacePicker();
                    });
                  },
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      ).then((date) {
                        setState(() {
                          start = date;
                        });
                      });
                    });
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.hourglassStart),
                    title: Text(
                      start == null
                          ? '    Start Date: Show DateTime Picker'
                          : new DateFormat('    EEE, MMM d, ' 'yyyy')
                              .format(start),
                    ),
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        initialDate: DateTime.now(),
                      ).then((date) {
                        setState(() {
                          end = date;
                        });
                      });
                    });
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.hourglassEnd),
                    title: Text(
                      end == null
                          ? '    End Date: Show DateTime Picker'
                          : new DateFormat('    EEE, MMM d, ' 'yyyy')
                              .format(end),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 20,
        ),
        child: Container(
          width: 75,
          height: 75,
          child: FittedBox(
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                setState(() {
                  VolLoc vol = VolLoc(
                      creator: loggedInUser.uid,
                      name: name,
                      contactEmail: email,
                      contactPhone: phone,
                      location: GeoPoint(
                          location.latLng.latitude, location.latLng.longitude),
                      desc: 'none yet',
                      dateCreated: DateTime.now(),
                      dateEnd: end,
                      dateStart: start);
                  CollectionReference dbLocs =
                      Firestore.instance.collection('VolLocs');
                  Firestore.instance.runTransaction((Transaction tx) async {
                    await dbLocs.add(vol.toJson());

                    final snackBar =
                        SnackBar(content: Text('Yay! A SnackBar!'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    Navigator.pushNamed(context, 'getStarted');
                  });
                });
              },
              child: Icon(FontAwesomeIcons.check),
              backgroundColor: Colors.black,
              autofocus: true,
            ),
          ),
        ),
      ),
    );
  }
}
