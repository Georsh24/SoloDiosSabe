import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/bottom_bar/wa_bottom_bar.dart';


class WaSplash extends StatefulWidget {
  @override
  _EbookSplashState createState() => _EbookSplashState();
}

class _EbookSplashState extends State<WaSplash> {

  startTimeout() {
    return new Timer(Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    pushPageReplacement(context, WaBottomBar());
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.lightBlueAccent
                    ],
                  )
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/wa_sticker.png",
                    height: 250,
                    width: 250,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
