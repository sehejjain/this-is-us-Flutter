import 'package:flutter/material.dart';
import 'package:thisisus/screens/individual/emailLogin.dart';
import 'package:thisisus/screens/individual/email_reg.dart';
import 'package:thisisus/screens/individual/get_started.dart';
import 'package:thisisus/screens/individual/indivisual_home.dart';
import 'package:thisisus/screens/landing_page.dart';
import 'package:thisisus/screens/org/create_vol_loc.dart';
import 'package:thisisus/screens/org/org_email_reg.dart';
import 'package:thisisus/screens/org/org_get_started.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //TODO: Create a Splash Screen
  //TODO: Create Org Login Landing Page or Org Home

  final Widget home;

  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: LandingPage(),
      routes: {
        'getStarted': (context) => GetStartedPage(),
        'emailSignUp': (context) => EmailRegScreen(),
        'login': (context) => EmailLoginScreen(),
        'createVolLoc': (context) => CreateVolLoc(),
        'orgLogin': (context) => OrgSignUpScreen(),
        'orgEmailReg': (context) => OrgEmailRegScreen(),
        'userHome': (context) => IndLandingScreen(),
      },
    );
  }
}
