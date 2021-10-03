import 'package:flutter/material.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_stickers_internet/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:flutter_stickers_internet/app/utils/email_validator.dart';
import 'package:flutter_stickers_internet/app/widgets/auth_background.dart';
import 'package:flutter_stickers_internet/app/widgets/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'controller/login_controller.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
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
                          height: 10,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _LoginForm(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(
                      'Create a account',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.indigo.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    onPressed: () => router.pushReplacementNamed(Routes.REGISTER)
                    
                  ),
                  TextButton(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.indigo.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    onPressed: () => router.pushReplacementNamed(Routes.RESET_PASSWORD),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Container(
          child: Form(
            key: controller.formkey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomInputField(
                  prefixIcon: Icons.alternate_email_sharp,
                  label: "Email",
                  onChanged: controller.onEmailChanged,
                  inputType: TextInputType.emailAddress,
                  validator: (text) {
                    if (isValidEmail(text!)) {
                      return null;
                    }
                    return "Invalid Email";
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                  prefixIcon: Icons.lock_outline,
                  label: "Password",
                  onChanged: controller.onPasswordChanged,
                  isPassword: true,
                  validator: (text) {
                    if (text!.trim().length >= 6) {
                      return null;
                    }
                    return "invalid Password";
                  },
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
                          ])),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    onPressed: () => sendLoginForm(context),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // TextButton(
                //   onPressed: () => router.pushNamed(Routes.RESET_PASSWORD),
                //   child: const Text("Forgot Password?"),
                // ),

                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
