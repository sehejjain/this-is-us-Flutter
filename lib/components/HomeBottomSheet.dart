import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/models/LocationModel.dart';

class HomeVolLocBottomSheet extends StatefulWidget {
  final VolLoc loc;
  final FirebaseUser loggedInUser;
  final String orgName;

  HomeVolLocBottomSheet(
      {Key key, @required this.loc, @required this.loggedInUser, this.orgName})
      : super(key: key);

  @override
  _HomeVolLocBottomSheetState createState() => _HomeVolLocBottomSheetState();
}

class _HomeVolLocBottomSheetState extends State<HomeVolLocBottomSheet> {
  final RoundedLoadingButtonController _btnController1 =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController2 =
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
              widget.orgName,
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
              'Location: ${widget.loc.locString}',
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
              controller: _btnController1,
              onPressed: () async {
                try {
                  print(widget.loc.id);
                  CollectionReference savedRef = Firestore.instance
                      .collection('VolLocs')
                      .document(widget.loc.id)
                      .collection('Applicants');
                  await savedRef.document(widget.loggedInUser.uid).setData({
                    'userID': widget.loggedInUser.uid,
                    'date_applied': DateTime.now(),
                  });

                  _btnController1.success();
                  Future.delayed(Duration(milliseconds: 500)).then((onValue) {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  _btnController1.reset();
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              child: Text(
                'Add To Saved',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              controller: _btnController2,
              onPressed: () async {
                try {
                  CollectionReference savedRef =
                      Firestore.instance.collection('SavedLocs');
                  await savedRef
                      .document(widget.loggedInUser.uid)
                      .collection('SavedUserLocs')
                      .document(widget.loc.id)
                      .setData({
                    "date": DateTime.now(),
                    ""
                        "locID": widget.loc.id
                  });

                  _btnController2.success();
                  Future.delayed(Duration(milliseconds: 500)).then((onValue) {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  _btnController2.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
