import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/account_repository.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  User? get user => _user;

  final _auth = Get.i.find<AuthentiticationRepository>();

  final AccountRepository _account = Get.i.find();

  void setUser(User user) {
    _user = user;
    notify();
  }

  Future<User?> updateDisplayName(String value) async {
    final user = await _account.updateDisplayName(value);
    if (user != null) {
      _user = user;
      notify();
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.singOut();
    _user = null;
  }

  @override
  void dispose() {
    print("sesion controller dispose");
    super.dispose();
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);
