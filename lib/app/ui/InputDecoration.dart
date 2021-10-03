import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InputDecorations {
  static InputDecoration authInputDecorations({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('007c00'),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: HexColor('00ff00'),
          width: 2,
        )),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: HexColor('007c00'))
            : null);
  }
}
