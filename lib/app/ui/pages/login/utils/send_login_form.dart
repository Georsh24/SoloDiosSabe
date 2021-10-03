import 'package:flutter/cupertino.dart';

import 'package:flutter_stickers_internet/app/domain/responses/sign_in_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/progres_dialog.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import '../login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      String errorMessage = "";
      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "Network Request Failed";
          break;
        case SignInError.userDisabled:
          errorMessage = "User Disabled";
          break;
        case SignInError.userNotFound:
          errorMessage = "User Not Found";
          break;
        case SignInError.wrongPassword:
          errorMessage = "Wrong Password";
          break;
        case SignInError.tooManyRequest:
          errorMessage = "Too Many Request";
          break;
        case SignInError.unknow:
        default:
          errorMessage = "unknow";
          break;
      }
      Dialogs.alert(context, title: "Error", content: errorMessage);
    } else {
      router.pushReplacementNamed(Routes.HOME);
    }
  }
}
