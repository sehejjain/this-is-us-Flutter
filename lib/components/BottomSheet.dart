import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/models/LocationModel.dart';

class VolLocBottomSheet extends StatefulWidget {
  final VolLoc loc;
  final FirebaseUser loggedInUser;

  VolLocBottomSheet({Key key, @required this.loc, @required this.loggedInUser})
      : super(key: key);

  @override
  _VolLocBottomSheetState createState() => _VolLocBottomSheetState();
}

class _VolLocBottomSheetState extends State<VolLocBottomSheet> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
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
            SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              child: Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              controller: _btnController,
              onPressed: () async {
                try {
                  print(widget.loc.id);
                  print(widget.loggedInUser.email);
                  print('asfaa${widget.loggedInUser.uid}');
                  CollectionReference savedRef =
                      Firestore.instance.collection('SavedLocs');
                  await savedRef
                      .document(widget.loggedInUser.uid)
                      .collection('SavedUserLocs')
                      .add({"date": DateTime.now(), "locID": widget.loc.id});
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
