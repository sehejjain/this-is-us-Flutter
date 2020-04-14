import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/models/user_type_model.dart';

import '../../constants.dart';
import 'BottomSheet.dart';

class OrgEmailRegScreen extends StatefulWidget {
  @override
  _OrgEmailRegScreenState createState() => _OrgEmailRegScreenState();
}

class _OrgEmailRegScreenState extends State<OrgEmailRegScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  Future<String> getUID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organisatin Sign Up'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        title: TextField(
                          onChanged: (value) {
                            email = value;
                          },
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
                      height: 8.0,
                    ),
                    Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                        title: TextField(
                          onChanged: (value) {
                            password = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontSize: 20.0,
                            fontFamily: 'Source Sans Pro',
                          ),
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your Password'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                                    child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: AddTaskScreen(),
                                )));
                      },
                      child: Text('sheet'),
                    ),
                    RoundedLoadingButton(
                      color: Colors.black87,
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                      controller: _btnController,
                      onPressed: () async {
                        try {
                          FirebaseUser user = (await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password))
                              .user;
                          FirebaseUser loggedInUser = (await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password))
                              .user;
                          if (user != null) {
                            //Go On
                            UserType usertype = UserType(1);
                            Map<String, dynamic> userTypeData =
                                usertype.toJson();
                            final CollectionReference userTypeRef =
                                Firestore.instance.collection('UserTypes');
                            await userTypeRef
                                .document(user.uid)
                                .setData(userTypeData);
                          }
                          _btnController.success();
                          _settingModalBottomSheet(context);
                        } catch (e) {
                          print(e);
                          _btnController.reset();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already a Member? ',
                            ),
                            TextSpan(
                              text: 'Click here to Login',
                              style: TextStyle(color: Colors.pink),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Navigator.pushNamed(context, 'login'),
                            )
                          ],
                        ),
                      ),
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

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
                onTap: () => {}),
            new ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () => {},
            ),
          ],
        ),
      );
    },
  );
}
