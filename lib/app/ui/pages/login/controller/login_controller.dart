import 'package:flutter/widgets.dart' show FormState, GlobalKey;

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_in_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessionController;
  String _email = '', _password = '';
  final _authRepository = Get.i.find<AuthentiticationRepository>();
  final GlobalKey<FormState> formkey = GlobalKey();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final response =
        await _authRepository.signInWithEmailAndPassword(_email, _password);
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }
}
