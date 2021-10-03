import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  final _authRepository = Get.i.find<AuthentiticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    _init();
  }

  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.HOME;
      _sessionController.setUser(user);
    } else {
      _routeName = user != null ? Routes.HOME : Routes.SPLASH1;
    }

    notify();
    if (user != null) {
      // ignore: avoid_print
      print("logqueado");
    } else {
      // ignore: avoid_print
      print("no logueado");
    }
  }
}
