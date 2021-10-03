import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_stickers_internet/app/ui/pages/register/utils/send_register_form.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:flutter_stickers_internet/app/utils/email_validator.dart';
import 'package:flutter_stickers_internet/app/utils/name_validator.dart';
import 'package:flutter_stickers_internet/app/widgets/CardContainer.dart';
import 'package:flutter_stickers_internet/app/widgets/auth_background.dart';
import 'package:hexcolor/hexcolor.dart';
import 'controller/register_controller.dart';
import 'controller/register_state.dart';
import 'package:flutter_meedu/router.dart' as router;

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
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
                          'Sign Up',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _RegisterForm(),
                      ],
                    ),
                  ),
                  SizedBox(),
                  TextButton(
                    child: Text(
                      'You have account?',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(
                        StadiumBorder(),
                      ),
                    ),
                    onPressed: () {
                      router.pushReplacementNamed(Routes.LOGIN);
                      // router.pushNamedAndRemoveUntil(Routes.LOGIN);
                    },
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Container(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomInputField(
                  label: "Name",
                  onChanged: controller.onNameChanged,
                  validator: (text) {
                    // ignore: avoid_print
                    print("text $text");

                    return isValidName(text!) ? null : "Invalid Namne";
                  },
                  prefixIcon: Icons.face_outlined,
                ),
                const SizedBox(height: 15),
                CustomInputField(
                  label: "Last Name",
                  onChanged: controller.onLastNameChanged,
                  validator: (text) {
                    // ignore: avoid_print
                    print("text $text");

                    return isValidName(text!) ? null : "Invalid Last Namne";
                  },
                  prefixIcon: Icons.face_outlined,
                ),
                const SizedBox(height: 15),
                CustomInputField(
                  label: "E-mail",
                  inputType: TextInputType.emailAddress,
                  onChanged: controller.onEmailChanged,
                  validator: (text) {
                    // ignore: avoid_print
                    print("text $text");

                    return isValidEmail(text!) ? null : "Invalid Email";
                  },
                  prefixIcon: Icons.alternate_email_sharp,
                ),
                const SizedBox(height: 15),
                CustomInputField(
                  isPassword: true,
                  label: "Password",
                  onChanged: controller.onPasswordChanged,
                  validator: (text) {
                    if (text!.trim().length >= 6) {
                      return null;
                    }
                    return "Invalid Password";
                  },
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 15),
                Consumer(builder: (_, watch, __) {
                  watch(registerProvider.select((state) => state.password));
                  return CustomInputField(
                    isPassword: true,
                    label: "Verification Password",
                    onChanged: controller.onVPasswordhanged,
                    validator: (text) {
                      if (controller.state.password != text) {
                        return "Password Don't Match";
                      }
                      if (text!.trim().length >= 6) {
                        return null;
                      }
                    },
                    prefixIcon: Icons.lock_outline,
                  );
                }),
                const SizedBox(height: 30),
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
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    onPressed: () => sendRegisterForm(context),
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
