import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/screens/individual/indivisual_home.dart';
import 'package:thisisus/screens/org/org_home_page.dart';
import 'package:thisisus/screens/splash_screen.dart';
import 'package:thisisus/services/user_repository.dart';

class LandingPage extends StatefulWidget {
  final FirebaseUser user;

  LandingPage({this.user});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // Fixed
    super.initState();
    Provider.of<UserRepository>(context, listen: false).getUserType();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserRepository>(context, listen: false).userType == 0) {
      return IndHomeScreen(
        user: Provider.of<UserRepository>(context, listen: false).user,
      );
    } else if (Provider.of<UserRepository>(context, listen: false).userType ==
        1) {
      return OrgHomeScreen(
        user: Provider.of<UserRepository>(context, listen: false).user,
      );
    }
    setState(() {});
    return SplashScreen();
  }
}
