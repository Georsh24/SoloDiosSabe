import 'package:firebase_auth/firebase_auth.dart';

class SignInResponse {
  final SignInError? error;
  final User? user;

  SignInResponse(this.error, this.user);
}

enum SignInError {
  tooManyRequest,
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknow,
}

SignInError stringToSignInError(String code) {
  switch (code) {
    case "too-many-request":
      return SignInError.tooManyRequest;
    case "user-disabled":
      return SignInError.userDisabled;
    case "user-no-found":
      return SignInError.userNotFound;
    case "network-requesd-failed":
      return SignInError.networkRequestFailed;
    case "wrong-password":
      return SignInError.wrongPassword;
    default:
      return SignInError.unknow;
  }
}
