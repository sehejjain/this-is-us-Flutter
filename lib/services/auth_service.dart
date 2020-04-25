import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChange =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future<String> createIndUserWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser currentUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

    return currentUser.uid;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  signOut() {
    _firebaseAuth.signOut();
  }
//and
}
