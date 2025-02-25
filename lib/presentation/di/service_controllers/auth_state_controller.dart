import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth_service.dart';

class AuthStateController extends StateController<User?> {
  AuthStateController(this._controller) : super(_controller?.currentUser) {
    _controller?.authStateChanges?.listen((User? user) {
      state = user;
    });
  }

  @override
  User? get state => FirebaseAuth.instance.currentUser;

  final AuthenticationService? _controller;

  Future<User?> signInAnonymously() async =>
      state = await _controller?.signInAnonymously();

  Future<User?> signInWithEmailAndPassword(
          String email, String password) async =>
      state = await _controller?.signInWithEmailAndPassword(email, password);

  Future<User?> signUpWithEmailAndPassword(
          String email, String password) async =>
      state = await _controller?.signUpWithEmailAndPassword(email, password);

  Future<User?> signInWithKey(String? key) async =>
      state = await _controller?.signInWithKey(key);

  Future<User?> signOut() async => state = await _controller?.signOut();
}
