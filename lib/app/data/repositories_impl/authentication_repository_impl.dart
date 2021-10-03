import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_stickers_internet/app/domain/responses/reset_passord_response.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_in_response.dart';

class AuthenticationRepositoryImpl implements AuthentiticationRepository {
  final FirebaseAuth _auth;
  User? _user;

  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(this._auth) {
    // ignore: avoid_print
    print(" Salio");
    _init();
  }

  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen(
      (User? user) {
        if (!_completer.isCompleted) {
          _completer.complete();
        }
        _user = user;
      },
    );
  }

  @override
  Future<void> singOut() {
    return _auth.signOut();
  }

  @override
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user!;
      return SignInResponse(null, user);
    } on FirebaseAuthException catch (e) {
      return SignInResponse(stringToSignInError(e.code), null);
    }
  }

  @override
  Future<ResetPasswordResponse> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ResetPasswordResponse.ok;
    } on FirebaseAuthException catch (e) {
      return stringToResetPasswordRespone(e.code);
    }
  }
}
