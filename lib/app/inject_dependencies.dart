import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_stickers_internet/app/data/repositories_impl/account_repository_impl.dart';
import 'package:flutter_stickers_internet/app/data/repositories_impl/preferences_repository_impl.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/account_repository.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories_impl/authentication_repository_impl.dart';
import 'data/repositories_impl/sing_up_repository_impl.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/sign_up_repository.dart';

Future<void> injectDependencies() async {
  // ignore: unused_local_variable
  final preferences = await SharedPreferences.getInstance();
  Get.i.lazyPut<AuthentiticationRepository>(
    () => AuthenticationRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
  Get.i.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
  Get.i.lazyPut<AccountRepository>(
    () => AccountRepositoryImpl(
      FirebaseAuth.instance,
    ),
  );
  Get.i.lazyPut<PreferencesRepository>(
    () => PreferencesRepositoryImpl(
      preferences,
    ),
  );
}
