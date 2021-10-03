import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_stickers_internet/app/domain/responses/reset_passord_response.dart';

class ResetPasswordController extends SimpleNotifier {
  String _email = '';
  String get email => _email;

  final _authenticationRepository = Get.i.find<AuthentiticationRepository>();
  void onEmailChange(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse> submit() {
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}
