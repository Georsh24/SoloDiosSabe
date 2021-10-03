import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final estiloTexto = TextStyle(fontSize: 20.0, color: Colors.white);

final liquidPages = [
  Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
          0.1,
          0.60,
        ],
            colors: [
          HexColor('00ff00'),
          HexColor('05d0ae'),
        ])),
    child: Stack(
      children: [
        Positioned(
          child: ClipPath(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logowhite.png',
                  width: 500,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
  Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
          0.1,
          0.60,
        ],
            colors: [
          HexColor('99d98c'),
          HexColor('4361ee'),
        ])),
    child: Stack(
      children: [
        Positioned(
          child: ClipPath(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logowhite.png',
                  width: 500,
                ),
              ],
            ),
          ),
        ),
        MaterialButton(child: Text('Comecemos'), onPressed: () {})
      ],
    ),
  ),
];
