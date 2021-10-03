import 'package:flutter/widgets.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_stickers_internet/app/domain/inputs/sign_up.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_up_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/ui/pages/register/controller/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();
  final _signUpRepository = Get.i.find<SignUpRepository>();

  Future<SingUpResponse> submit() async {
    final response = await _signUpRepository.register(
      SignUpData(state.name, state.lastname, state.email, state.password),
    );
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onLastNameChanged(String text) {
    state = state.copyWith(lastname: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordhanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
