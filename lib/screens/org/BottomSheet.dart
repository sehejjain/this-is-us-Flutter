import 'dart:ui';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;

    return Container(
      color: Color(0xff757575),
      child: Container(
        height: 800,
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
              'Complete your profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ArgonButton(
                    height: 50,
                    width: 350,
                    borderRadius: 5.0,
                    color: Colors.black,
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    loader: Container(
                      padding: EdgeInsets.all(10),
                      child: SpinKitRotatingCircle(
                        color: Colors.white,
                        // size: loaderWidth ,
                      ),
                    ),
                    onTap: (startLoading, stopLoading, btnState) {
                      startLoading();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
