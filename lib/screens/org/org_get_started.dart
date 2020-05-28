import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/user_repository.dart';

class OrgSignUpScreen extends StatefulWidget {
  @override
  _OrgSignUpScreenState createState() => _OrgSignUpScreenState();
}

//TODO: Implement Google and Facebook Sign In
class _OrgSignUpScreenState extends State<OrgSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Organisation Sign Up'),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'mainLogo',
              child: SizedBox(
                height: 150,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'This is Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'orgEmailReg');
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Continue with Email',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: GestureDetector(
                onTap: (){
                  userRepo.signInWithGoogle();
                  userRepo.setOrg();
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
