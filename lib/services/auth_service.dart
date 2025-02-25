import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  AuthenticationService(
      this._firebaseAuth, this._analytics, this._sharedPreferences);

  final FirebaseAuth? _firebaseAuth;
  final FirebaseAnalytics? _analytics;
  final SharedPreferences? _sharedPreferences;

  // Stream user Authentication State
  Stream<User?>? get authStateChanges => _firebaseAuth?.authStateChanges();

  User? get currentUser => _firebaseAuth?.currentUser;

  Future<User?> signInAnonymously() async {
    try {
      final credentials = await _firebaseAuth?.signInAnonymously();
      _analytics?.logEvent(name: 'user signed in anonymously');
      return credentials?.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? userCredential =
          await _firebaseAuth?.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _analytics?.logEvent(
          name:
              'user signed in with email and password : ${userCredential?.user?.email}');

      return userCredential?.user;
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: Text(e.message.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(
                      _sharedPreferences?.getString('context') as BuildContext)
                  .pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }
  }

  // Sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? userCredential =
          await _firebaseAuth?.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _analytics?.logEvent(
          name:
              'user signed up with email and password : ${userCredential?.user?.email}');

      return userCredential?.user;
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: Text(e.message.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(
                      _sharedPreferences?.getString('context') as BuildContext)
                  .pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }
  }

  // Sign out
  Future? signOut() async {
    await _firebaseAuth?.signOut();
    _analytics?.logEvent(name: 'user signed out');
    _sharedPreferences?.clear();
    return null;
  }

  // Sign in with key
  Future signInWithKey(String? key) async {
    try {
      final userCredential = await _firebaseAuth?.signInWithCustomToken(key!);
      _analytics?.logEvent(name: 'user signed in with key');
      return userCredential?.user;
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: Text(e.message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(
                      _sharedPreferences?.getString('context') as BuildContext)
                  .pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }
    return null;
  }
}
