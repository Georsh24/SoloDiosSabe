import 'package:firebase_auth/firebase_auth.dart';

class SingUpResponse {
  final SignUpError? error;
  final User? user;

  SingUpResponse(this.error, this.user);
}

parseStringToSignUpError(String text) {
  switch (text) {
    case "too-many-request":
      return SignUpError.tooManyRequest;
    case "email-already-in-use":
      return SignUpError.emailAlreadyInUse;
    case "weak-password":
      return SignUpError.weakPassword;
    case "network-requesd-failed":
      return SignUpError.networkRequestFailed;
    default:
      return SignUpError.unknow;
  }
}

enum SignUpError {
  tooManyRequest,
  emailAlreadyInUse,
  weakPassword,
  unknow,
  networkRequestFailed,
}
