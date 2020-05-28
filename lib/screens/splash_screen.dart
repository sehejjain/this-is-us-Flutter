import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/services/size_config.dart';

import '../services/user_repository.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var horizontalVal = displaySafeWidthBlocks(context);
    var verticalVal = displaySafeHeightBlocks(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 80 * horizontalVal,
                  height: 30 * verticalVal,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "This is Us",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: verticalVal * 8,
                ),
                SizedBox(
                  width: 90 * verticalVal,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: Text(
                        'Matching You to Your Cause',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          OutlineButton(
            child: Text('Sign Out'),
            onPressed: (){
              Provider.of<UserRepository>(context, listen: false).signOut();
            },
          ),
          SizedBox(
            width: horizontalVal * 10,
            height: horizontalVal * 10,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
