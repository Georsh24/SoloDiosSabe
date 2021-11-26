import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_meedu/router.dart' as router;

// ignore: must_be_immutable
class PaySucces extends StatefulWidget {
  StickerPack pack;
  PaySucces({required this.pack});

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
    Future.delayed(
      Duration(seconds: 3),
      () {
        // router.pop(
        //   getCompras(),
        // );
        //router.pushReplacement(WaStickerDetail(pack: widget.pack));
        comprado = "comprar";
        print('variable despues de success');
        print(comprado);
      },
    );

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
    // final colorshex1 =
    //     Theme.of(context).brightness == Brightness.dark ? '3A3E98' : '00ff00';
    // final colorshex2 =
    //     Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    // final shadowSlider = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/pay.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('assets/success2.gif'),
              ),
              Text(
                widget.pack.identiFier,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold),
              ),
              MaterialButton(onPressed: () {
                router
                    .pushReplacement(WaStickerDetail(pack: widget.pack))
                    .then((value) {
                  setState(() {
                    compratext = false;
                    print('compratext de pay');
                    print(compratext);
                  });
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
