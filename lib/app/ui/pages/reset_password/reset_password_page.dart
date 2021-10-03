import 'package:flutter/material.dart';

import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_stickers_internet/app/domain/responses/reset_passord_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/progres_dialog.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:flutter_stickers_internet/app/utils/email_validator.dart';
import 'package:flutter_stickers_internet/app/widgets/CardContainer.dart';
import 'package:flutter_stickers_internet/app/widgets/auth_background.dart';
import 'package:hexcolor/hexcolor.dart';

import 'controller/reset_password_controller.dart';
import 'package:flutter_meedu/router.dart' as router;

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) {
        return Scaffold(
          body: AuthBackround(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  CardContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _ResetForm(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      child: const Text(
                        "You have account?",
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.indigo.withOpacity(0.1)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                      onPressed: () =>
                          router.pushReplacementNamed(Routes.LOGIN)),
                  TextButton(
                      child: const Text(
                        "Create a account",
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.indigo.withOpacity(0.1)),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                      onPressed: () =>
                          router.pushReplacementNamed(Routes.REGISTER)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ResetForm extends StatelessWidget {
  const _ResetForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) {
        return Container(
          child: Form(
              child: Column(
            children: [
              CustomInputField(
                label: "Email",
                onChanged: controller.onEmailChange,
                inputType: TextInputType.emailAddress,
                prefixIcon: Icons.alternate_email_sharp,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    stops: [
                      0.1,
                      0.80,
                    ],
                    colors: [
                      HexColor('00ff00'),
                      HexColor('05d0ae'),
                    ],
                  ),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  onPressed: () => _submit(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: const Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          )),
        );
      },
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(context, title: "Good", content: "Email Send");
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Network RequestFailed";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "User Disabled";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "User Not Found";
            break;
          case ResetPasswordResponse.tooManyRequest:
            errorMessage = "Too Many Request";
            break;
          case ResetPasswordResponse.unknown:
          default:
            errorMessage = "unknown error";
            break;
        }
        Dialogs.alert(context, title: "Error", content: errorMessage);
      }
    } else {
      Dialogs.alert(context, content: "invalid email");
    }
  }
}
