import 'package:flutter_stickers_internet/app/domain/inputs/sign_up.dart';
import 'package:flutter_stickers_internet/app/domain/responses/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SingUpResponse> register(SignUpData data);
}
