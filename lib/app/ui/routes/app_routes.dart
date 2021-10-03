// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stickers_internet/app/screens/HomeScreen.dart';
import 'package:flutter_stickers_internet/app/screens/SplashScreen.dart';
import 'package:flutter_stickers_internet/app/ui/pages/login/login_page.dart';
import 'package:flutter_stickers_internet/app/ui/pages/register/register_page.dart';
import 'package:flutter_stickers_internet/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:flutter_stickers_internet/app/ui/pages/splash/splash_page.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.HOME: (_) => HomeScreen(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
      Routes.SPLASH1: (_) => SplashScreen()
    };
