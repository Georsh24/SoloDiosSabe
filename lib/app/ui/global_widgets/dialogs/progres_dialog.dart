import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  static show(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => WillPopScope(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
        onWillPop: () async => false,
      ),
    );
  }
}
