import 'package:flutter/material.dart';
import 'package:thisisus/screens/get_started.dart';
import 'package:thisisus/screens/individual/emailLogin.dart';
import 'package:thisisus/screens/individual/email_reg.dart';
import 'package:thisisus/screens/individual/indivisual_home.dart';
import 'package:thisisus/screens/individual/sign_up.dart';
import 'package:thisisus/screens/org/create_vol_loc.dart';
import 'package:thisisus/screens/org/orgLogin.dart';
import 'package:thisisus/screens/org/org_email_reg.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(title: 'This Is Us'),
      routes: {
        'getStarted': (context) => GetStartedPage(),
        'signUp': (context) => SignUpScreen(),
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
