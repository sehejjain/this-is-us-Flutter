import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/models/LocationModel.dart';

class OrgVolLocBottomSheet extends StatefulWidget {
  final VolLoc loc;
  final FirebaseUser loggedInUser;

  OrgVolLocBottomSheet(
      {Key key, @required this.loc, @required this.loggedInUser})
      : super(key: key);

  @override
  _OrgVolLocBottomSheetState createState() => _OrgVolLocBottomSheetState();
}

class _OrgVolLocBottomSheetState extends State<OrgVolLocBottomSheet> {
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
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              controller: _btnController,
              onPressed: () async {
                try {
                  print(widget.loc.id);
                  print(widget.loggedInUser.email);
                  print('asfaa${widget.loggedInUser.uid}');
                  var savedRef = Firestore.instance.collection('VolLocs');
//Not Working
                  //TODO: Fix
                  print(widget.loc.id);
                  print(savedRef);
                  await Firestore.instance
                      .runTransaction((Transaction myTransaction) async {
                    await myTransaction.delete(Firestore.instance
                        .collection('VolLocs')
                        .document(widget.loc.id));
                  });
                  _btnController.success();
                  Navigator.pop(context);
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
