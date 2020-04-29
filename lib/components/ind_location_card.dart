import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thisisus/models/LocationModel.dart';

import 'HomeBottomSheet.dart';
import 'SavedBottomSheet.dart';

class IndLocationCard extends StatelessWidget {
  final FirebaseUser user;
  final VolLoc loc;
  final String bottomSheet;

  IndLocationCard({this.loc, this.user, this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) =>
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery
                            .of(context)
                            .viewInsets
                            .bottom),
                    child: bottomSheet == 'home'
                        ? HomeVolLocBottomSheet(
                      loc: loc,
                      loggedInUser: user,
                    )
                        : SavedVolLocBottomSheet(
                      loc: loc,
                      loggedInUser: user,
                    ),
                  ),
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
                                loc.name,
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
                                'afasfas',
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
                        'pretty soon. Apply as soon as possible.\n ${loc.desc}',
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
                                .format(loc.dateStart),
                          ),
                          TextSpan(text: ' to '),
                          TextSpan(
                            text: DateFormat('EEE, MMM d, ' 'yyyy').format(
                              loc.dateEnd,
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
