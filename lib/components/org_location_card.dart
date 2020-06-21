import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thisisus/components/org_bottom_sheet.dart';
import 'package:thisisus/models/LocationModel.dart';

class OrgLocationCard extends StatefulWidget {
  final FirebaseUser user;
  final VolLoc loc;
  final String bottomSheet;

  OrgLocationCard({this.loc, this.user, this.bottomSheet});

  @override
  _OrgLocationCardState createState() => _OrgLocationCardState();
}

class _OrgLocationCardState extends State<OrgLocationCard> {
  String orgName = 'Loading';
  void getOrgName() async {
    Firestore.instance
        .collection('Orgs')
        .document(widget.user.uid)
        .get()
        .then((doc) {
      print(doc.data);
      setState(() {
        orgName = doc.data['name'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getOrgName();
  }

  @override
  Widget build(BuildContext context) {
    print(orgName);
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: OrgVolLocBottomSheet(
                    orgName: orgName,
                    loggedInUser: widget.user,
                    loc: widget.loc,
                  )),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.all(10),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.loc.name,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                orgName,
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'This is a sample Organisation\' sample '
                    'Volunteering Location that would be deleted on '
                    'pretty soon. Apply as soon as possible.\n ${widget.loc.desc}',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: DateFormat('EEE, MMM d, ' 'yyyy')
                                .format(widget.loc.dateStart),
                          ),
                          TextSpan(text: ' to '),
                          TextSpan(
                            text: DateFormat('EEE, MMM d, ' 'yyyy').format(
                              widget.loc.dateEnd,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
