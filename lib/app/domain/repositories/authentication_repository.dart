import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stickers_internet/app/domain/responses/reset_passord_response.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_in_response.dart';

abstract class AuthentiticationRepository {
  Future<User?> get user;
  Future<void> singOut();
  Future<SignInResponse> signInWithEmailAndPassword(
      String email, String password);
  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
