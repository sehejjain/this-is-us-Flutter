import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/screens/home_screen.dart';
import 'package:thisisus/screens/individual/emailLogin.dart';
import 'package:thisisus/screens/individual/email_reg.dart';
import 'package:thisisus/screens/individual/get_started.dart';
import 'package:thisisus/screens/individual/indivisual_home.dart';
import 'package:thisisus/screens/individual/saved_locs.dart';
import 'package:thisisus/screens/landing_screen.dart';
import 'package:thisisus/screens/org/create_vol_loc.dart';
import 'package:thisisus/screens/org/org_email_reg.dart';
import 'package:thisisus/screens/org/org_get_started.dart';
import 'package:thisisus/screens/splash_screen.dart';
import 'package:thisisus/services/user_repository.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Consumer(
          // ignore: missing_return
          builder: (context, UserRepository user, _) {
            switch (user.status) {
              case Status.Uninitialized:
                return SplashScreen();
              case Status.Unauthenticated:
                return HomePage();
              case Status.Authenticating:
                return Scaffold(
                  body: SplashScreen(),
                );
              case Status.Authenticated:
                {
                  return LandingPage();
                }
              default:
                //return HomePage();
                return HomePage();
            }
          },
        ),
        routes: {
          'getStarted': (context) => GetStartedPage(),
          'emailSignUp': (context) => EmailRegScreen(),
          'login': (context) => EmailLoginScreen(),
          'createVolLoc': (context) => CreateVolLoc(),
          'orgLogin': (context) => OrgSignUpScreen(),
          'orgEmailReg': (context) => OrgEmailRegScreen(),
          'userHome': (context) => IndHomeScreen(),
          'savedLocs': (context) => SavedLocsScreen(),
        },
      ),
    );
  }
}
