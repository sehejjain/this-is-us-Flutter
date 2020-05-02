import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thisisus/screens/home_screen.dart';
import 'package:thisisus/screens/individual/indivisual_home.dart';
import 'package:thisisus/screens/org/org_home_page.dart';
import 'package:thisisus/services/user_repository.dart';

class LandingPage extends StatelessWidget {
  final FirebaseUser user;

  LandingPage({this.user});

//TODO: NOT WORKING FIX NOWWWWWWW
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading...'),
      ),
      body: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            FirebaseUser user = snapshot.data;
            if (user == null) {
              return HomePage();
            }
            return Consumer<UserRepository>(
              builder: (context, user, _) {
                print(user.userType);
                print(user.user.uid);
                if (user.userType == 0) {
                  return IndHomeScreen();
                }
                if (user.userType == 1) return OrgHomeScreen();

                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
