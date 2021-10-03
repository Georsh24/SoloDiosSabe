import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stickers_internet/app/domain/inputs/sign_up.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);

  @override
  Future<SingUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);

      //aqui se agregan los demas datos del usuario al usuario que se acaba de crear
      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.lastname}",
      );
      // UserCredential.user!.updatePhoneNumber(
      //   "{data.number}",
      // )
      return SingUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SingUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}
