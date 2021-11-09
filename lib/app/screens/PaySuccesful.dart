import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_meedu/router.dart' as router;

class PaySucces extends StatefulWidget {
  PaySucces({Key? key}) : super(key: key);

  @override
  _PaySuccesState createState() => _PaySuccesState();
}

class _PaySuccesState extends State<PaySucces> {
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   Provider.of<WaDetail>(context, listen: false)
    //       .checkFav(int.parse(widget.pack.identifier));
    // },);
    // Future.delayed(
    //   Duration(seconds: 3),
    //   () {
    //     router.pop();
    //   },
    // );

    // _bannerAd = BannerAd(
    //     adUnitId: AdManager.bannerAdUnitId,
    //     size: AdSize.banner
    // );
    // _loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    final logoimg = Theme.of(context).brightness == Brightness.dark
        ? 'assets/logoblack.png'
        : 'assets/logowhite.png';
    final colorshex1 =
        Theme.of(context).brightness == Brightness.dark ? '3A3E98' : '00ff00';
    final colorshex2 =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.1,
              0.80,
            ],
            colors: [
              HexColor('$colorshex1'),
              HexColor('$colorshex2'),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.task_alt_rounded,
                size: size.width * 0.5,
                color: Colors.white,
              ),
              Text(
                'Sucess',
                style:
                    TextStyle(color: Colors.white, fontSize: size.width * 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
