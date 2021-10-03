import 'package:flutter/cupertino.dart';

import 'package:flutter_stickers_internet/app/domain/responses/sign_up_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/progres_dialog.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "email alredy in use ";
          break;
        case SignUpError.weakPassword:
          content = "weak password";
          break;
        case SignUpError.networkRequestFailed:
          content = "Network Request Failed";
          break;
        case SignUpError.tooManyRequest:
          content = "Too Many Request";
          break;
        case SignUpError.unknow:

        default:
          content = "unknow error";
          break;
      }

      Dialogs.alert(context, title: "Error", content: content);
    } else {
      router.pushNamedAndRemoveUntil(Routes.HOME);
    }
  } else {
    Dialogs.alert(
      context,
      title: "Error",
      content: "invailid fiels",
    );
  }
}
