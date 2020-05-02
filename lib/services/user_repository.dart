import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:thisisus/models/user_type_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  int _userType;
  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
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
        getUserType();
        print(_userType);
      });

      return x;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  void getUserType() async {
    if (_status == Status.Authenticated) {
      await Firestore.instance
          .collection('UserTypes')
          .document(_user.uid)
          .get()
          .then((onValue) {
        _userType = onValue.data["type"];
        notifyListeners();
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
