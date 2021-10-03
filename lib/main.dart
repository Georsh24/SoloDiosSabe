import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/inject_dependencies.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:provider/provider.dart';
import 'app/my_app.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  // final dir = Directory(getTemporaryDirectory());
  // dir.deleteSync(recursive: true);
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(MyApp());
}
