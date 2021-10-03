import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AuthBackround extends StatelessWidget {
  final Widget child;

  const AuthBackround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [_RedBox(), _HeaderIcon(), this.child],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Container(
            width: 170,
            height: 170,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/avatar.png'),
              ),
            )),
      ),
    );
  }
}

class _RedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _redBackground(),
      child: Stack(
        children: [
          Positioned(
            child: _Bubble(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Bubble(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _Bubble(),
            top: -50,
            right: -20,
          ),
          Positioned(
            child: _Bubble(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _Bubble(),
            bottom: 120,
            right: 20,
          )
        ],
      ),
    );
  }

  BoxDecoration _redBackground() {
    return BoxDecoration(
        gradient: LinearGradient(colors: [
      HexColor('00ff00'),
      HexColor('05d0ae'),
    ]));
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.35)),
    );
  }
}
