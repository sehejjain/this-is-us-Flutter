import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thisisus/constants.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
                          obscureText: true,
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
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            //Go On
                            //TODO Add functionality
                          }
                          _btnController.success();
                          //Delay to let button animation complete first.
                          // TODO: Find better code.
                          Future.delayed(const Duration(milliseconds: 0), () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          });
                        } catch (e) {
                          print(e);
                          _btnController.reset();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
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
