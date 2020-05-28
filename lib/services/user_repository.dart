import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thisisus/models/user_type_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  int _userType;
  Status _status = Status.Uninitialized;


  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
    _googleSignIn = _googleSignIn ?? GoogleSignIn();
  }

  Status get status => _status;

  FirebaseUser get user => _user;

  int get userType => _userType;

  Future<AuthResult> signIn({String email, String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var x = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((onValue) {
        getUserType().then((onValue) {
          print(_userType);
        });
      });

      return x;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }
  Future<AuthResult> signInWithGoogle() async {
    _status = Status.Authenticating;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var x = await _auth.signInWithCredential(credential).then((onValue) {
      try{
      getUserType().then((onValue) {
        print(_userType);
      });}catch(e){
        print(e);
        print('User does not exist');
      }
    });
    print(_auth.currentUser());
    notifyListeners();
    return x;
  }

  // ignore: missing_return
  Future<int> getUserType() async {
    if (_status == Status.Authenticated) {
      await Firestore.instance
          .collection('UserTypes')
          .document(_user.uid)
          .get()
          .then((onValue) {
        _userType = onValue.data["type"];

        notifyListeners();
        return onValue.data["type"];
      });
    }
  }

  Future<AuthResult> createUser({String email, String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }


  void setInd() async {
    if (_user != null) {
      _userType = 0;
      UserType usertype = UserType(0);
      Map<String, dynamic> userTypeData = usertype.toJson();
      final CollectionReference userTypeRef =
      Firestore.instance.collection('UserTypes');
      await userTypeRef.document(_user.uid).setData(userTypeData);
    }
  }

  void setOrg() async {
    if (_user != null) {
      _userType = 1;
      UserType usertype = UserType(1);
      Map<String, dynamic> userTypeData = usertype.toJson();
      final CollectionReference userTypeRef =
      Firestore.instance.collection('UserTypes');
      await userTypeRef.document(_user.uid).setData(userTypeData);
    }
  }

  Future signOut() async {
    _googleSignIn.signOut();
    _auth.signOut();
    _status = Status.Unauthenticated;
    _userType = -1;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      _userType = -1;
    } else {
      _user = firebaseUser;
      getUserType();
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
