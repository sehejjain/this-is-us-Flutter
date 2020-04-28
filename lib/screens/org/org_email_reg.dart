import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/services/user_repository.dart';

import '../../constants.dart';

class OrgEmailRegScreen extends StatefulWidget {
  @override
  _OrgEmailRegScreenState createState() => _OrgEmailRegScreenState();
}

class _OrgEmailRegScreenState extends State<OrgEmailRegScreen> {
  String email;
  String password;
  RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
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
                    RoundedLoadingButton(
                      color: Colors.black87,
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                      controller: _btnController,
                      onPressed: () async {
                        try {
                          FirebaseUser user = (await userRepo.createUser(
                              email: email, password: password))
                              .user;
                          if (user != null) {
                            //Go On
                            userRepo.setOrg();
                          }
                          _btnController.success();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
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
