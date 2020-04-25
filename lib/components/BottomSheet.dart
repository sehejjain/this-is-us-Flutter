import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/models/LocationModel.dart';

class VolLocBottomSheet extends StatefulWidget {
  final VolLoc loc;

  VolLocBottomSheet({Key key, @required this.loc}) : super(key: key);

  @override
  _VolLocBottomSheetState createState() => _VolLocBottomSheetState();
}

class _VolLocBottomSheetState extends State<VolLocBottomSheet> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

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
    if (loggedInUser == null) {
      print('wowowowow');
    }
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 700,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.loc.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Text(
              widget.loc.creator,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.pink),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'This is a sample Organisation\'s sample '
              'Volunteering Location that would be deleted on '
              'pretty soon. Apply as soon as possible.\n ${widget.loc.desc}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Location: ${widget.loc.location}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            RoundedLoadingButton(
              child: Text('Apply'),
              controller: _btnController,
              onPressed: () async {
                try {
                  print(widget.loc.id);
                  print('asfaa${loggedInUser.uid}');
                  CollectionReference savedRef =
                      Firestore.instance.collection('SavedLocs');
                  await savedRef
                      .document(loggedInUser.uid)
                      .collection('SavedUserLocs')
                      .document(widget.loc.id)
                      .setData({"date": DateTime.now()});
                  _btnController.success();
                } catch (e) {
                  _btnController.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
