import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thisisus/services/size_config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('object');
    var horizVal = displaySafeWidthBlocks(context);
    var vertVal = displaySafeHeightBlocks(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100 * vertVal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20 * vertVal,
              ),
              Container(
                width: 80 * horizVal,
                height: 20 * vertVal,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF000000),
                  child: Center(
                    child: Text(
                      "This is Us",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15 * vertVal,
                width: 90 * vertVal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
              SizedBox(
                height: 10 * vertVal,
              ),
              Container(
                height: 30 * vertVal,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'getStarted');
                            },
                            child: Center(
                              child: Text(
                                '-->Get Started<--',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5 * vertVal,
                    ),
                    FlatButton(
                      child: Text('\\VolLoc'),
                      onPressed: () {
                        Navigator.pushNamed(context, 'createVolLoc');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
