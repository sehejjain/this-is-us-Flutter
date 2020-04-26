import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;

  FirebaseUser get user => _user;

  Future<AuthResult> signIn({String email, String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<AuthResult> createUser({String email, String password}) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
