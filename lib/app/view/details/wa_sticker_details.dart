import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/screens/HomeScreen.dart';
import 'package:flutter_stickers_internet/app/screens/PerfilPage.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_detail.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart' as pathbasename;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/flutter_meedu.dart' as medu;
import 'package:pay/pay.dart';
import 'package:sizer/sizer.dart';
// import 'package:whatsapp_stickers/exceptions.dart';
// import 'package:whatsapp_stickers/whatsapp_stickers.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
String getuid = '';
String price = '1';
String getidcompra = '';
String comprado = "init";
String packagename = "none";
String publisher = "No Publisher";
String mainImage = ' ';
int numstickers = 0;
bool googleresult = false;
String dollar = "USD";

// ignore: must_be_immutable
class WaStickerDetail extends StatefulWidget {
  StickerPack pack;

  WaStickerDetail({required this.pack});

  @override
  _WaStickerDetailState createState() => _WaStickerDetailState();
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    googleresult = true;
    router.push(HomeScreen());
    //router.pushReplacement(WaStickerDetail(pack: pack));
    debugPrint(pack.toString());
    // Send the resulting Google Pay token to your server / PSP
  }
}

class _WaStickerDetailState extends State<WaStickerDetail> {
  List<String> imageList = [];
  List<String> downloadList = [];
  bool downloading = true;
  late Dio dio;
  late Dio dioDownload;
  bool isFav = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   Provider.of<WaDetail>(context, listen: false)
    //       .checkFav(int.parse(widget.pack.identifier));
    // },);
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        getCompras();
        getComprasadd();
      },
    );

    // _bannerAd = BannerAd(
    //     adUnitId: AdManager.bannerAdUnitId,
    //     size: AdSize.banner
    // );
    // _loadBanner();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
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
    final size = MediaQuery.of(context).size;
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;
    return Consumer<WaDetail>(
      builder: (context, details, _) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            toolbarHeight: size.height * 0.10,
            automaticallyImplyLeading: false,
            // actions: [
            //   Container(
            //     padding: EdgeInsets.only(right: 30),
            //     child: GestureDetector(
            //         onTap: () async {
            //           if (details.favorite) {
            //             details.removeFavorite(int.parse(widget.pack.identifier), widget.pack);
            //           } else {
            //             details.addFavorite(
            //                 int.parse(widget.pack.identifier),widget.pack);
            //           }
            //           // router.pop();r
            //           loadigFav(context);
            //         },
            //         child: Icon(
            //           details.favorite ? Icons.favorite : Icons.favorite,
            //           color: details.favorite ? Colors.red : Colors.black38,
            //           size: size.width * 0.050,
            //         )),
            //   )
            // ],
            leading: IconButton(
              padding: EdgeInsets.only(left: 10),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: size.width * 0.08,
              ),
              onPressed: () {
                router.pop();
              },
            ),
            centerTitle: true,
            title: Image.asset(
              '$logoimg',
              fit: BoxFit.contain,
              height: size.height * 0.09,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  stops: [
                    0.1,
                    0.80,
                  ],
                  colors: [
                    HexColor('$colorshex1'),
                    HexColor('$colorshex2'),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: Colors.grey,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            elevation: 4,
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  medu.Consumer(builder: (_, watch, __) {
                    final user = watch(sessionProvider).user!;
                    getuid = user.uid;
                    getidcompra = widget.pack.identiFier;
                    packagename = widget.pack.name;
                    price = widget.pack.cost;
                    publisher = widget.pack.publisher;
                    mainImage = widget.pack.trayimagefile;
                    numstickers = widget.pack.stickers.length;
                    return SizedBox.shrink();
                  }),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: shadowSlider
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade500,
                                    blurRadius: 4.0,
                                    spreadRadius: 2,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              height: 20.0.h,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Hero(
                              tag: widget.pack,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: size.width * 0.22,
                                        height: size.height * 0.17,
                                        child: Image.network(
                                          widget.pack.trayimageFile,
                                          height: 15.0.h,
                                          width: 28.0.w,
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.22,
                                        height: size.height * 0.17,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                widget.pack.name,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: size.width * 0.04,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              widget.pack.publisher,
                                              style: TextStyle(
                                                fontSize: size.width * 0.0450,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.22,
                                        height: size.height * 0.17,
                                        // color: Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Stickers",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                            Text(
                                              "${widget.pack.stickers.length}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.0450,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.17,
                                        width: size.width * 0.22,
                                        //color: Colors.grey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Price',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.attach_money_outlined,
                                                    size: size.width * 0.06,
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 0.15,
                                                  child: Text(
                                                    "${widget.pack.cost}",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          size.width * 0.045,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Container(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    childAspectRatio: 8.0 / 9.0,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0),
                            itemCount: widget.pack.stickers.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Image.network(
                                  widget.pack.stickers[i].imageFile,
                                  height: widthHeightSticker().h,
                                  width: widthHeightSticker().w,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12.0.h,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
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
                      child: MaterialButton(
                        elevation: 5,
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: getColorFromHex(GlobalColors().colorWhite),
                              fontSize: 25),
                        ),
                        onPressed: () {
                          if (getCompras() == "comprado") {
                            if (!downloadList
                                .contains(widget.pack.identiFier)) {
                              downloading = false;
                              downloadStickers(widget.pack, context);
                            } else {
                              addStickersToWa(widget.pack);
                            }
                          } else {
                            print("valor if");
                            print(comprado);
                            comprar(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // _loadBanner(){
  //   _bannerAd
  //   ..load()
  //       ..show(anchorType: AnchorType.bottom, anchorOffset: 6.0.h, horizontalCenterOffset: 0);
  // }

  Future<void> addStickersToWa(StickerPack pack) async {
    try {
      ApiConstant.methodChannel.invokeMapMethod("addStickerPackToWhatsApp",
          {"identifier": pack.identiFier, "name": pack.name});
    } on PlatformException catch (error) {
      print(error.message);
    }
  }

  Future<void> downloadStickers(StickerPack pack, ctx) async {
    //   var applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
    //   var stickersDirectory = Directory('${applicationDocumentsDirectory.path}/stickers');
    //   await stickersDirectory.create(recursive: true);
    //   final dio = Dio();
    //   final downloads = <Future>[];
    //  pack.stickers.forEach((stickers) {
    //     downloads.add(
    //       dio.download(Im)age.network(src)
    //     )
    //  });

    showProgressDownload(ctx);
    imageList.clear();
    if (!downloadList.contains(pack.identiFier)) {
      await Permission.storage.request();
      dioDownload = new Dio();
      var saveToDirectory = await getApplicationDocumentsDirectory();
      var paths = await Directory(saveToDirectory.path +
              "/" +
              "stickers_asset" +
              "/" +
              pack.identiFier +
              "/")
          .create(recursive: true);
      var trayImgPath = await Directory(saveToDirectory.path +
              "/" +
              "stickers_asset" +
              "/" +
              pack.identiFier +
              "/try/")
          .create(recursive: true);
      String tray =
          trayImgPath.path + pathbasename.basename(pack.trayimageFile);

      await dioDownload.download(pack.trayimageFile, tray,
          onReceiveProgress: (receive, totals) {
        int percentage = ((receive / totals) * 100).floor();
        print("dio download: $percentage");
      });

      for (int i = 0; i < pack.sticker.length; i++) {
        String pathFile =
            paths.path + pathbasename.basename(pack.sticker[i].imageFile);
        imageList.add(pathbasename.basename(pack.sticker[i].imageFile));
        await dioDownload.download(pack.sticker[i].imageFile, pathFile,
            onReceiveProgress: (receive, totals) {
          int percentage = ((receive / totals) * 100).floor();
          print("dio second: $percentage");
        });
      }
      try {
        ApiConstant.methodChannel.invokeMapMethod("addTOJson", {
          "identiFier": pack.identiFier,
          "name": pack.names,
          "publisher": pack.publisher,
          "trayimagefile": pathbasename.basename(pack.trayimageFile),
          "publisheremail": pack.publisherEmail,
          "publisherwebsite": pack.publisherWebsite,
          "privacypolicywebsite": pack.privacyPolicyWebsite,
          "licenseagreementwebsite": pack.licenseAgreementWebsite,
          "sticker_image": imageList,
        });
      } on PlatformException catch (error) {
        print(error.message);
      }

      // var stickerpacks = WhatsappStickers(

      //   identifier: pack.identiFier,
      //   name: pack.name,
      //   publisher: pack.publisher,
      //   trayImageFileName: (pack.trayimagefile),
      //   publisherWebsite: pack.publisherwebsite,
      //   privacyPolicyWebsite: pack.privacypolicywebsite,

      // );
      //  List<String> emojis = ['😡', '😤'];

      //   pack.stickers.forEach((sticker) {
      //     stickerpacks.addSticker(WhatsappStickerImage.fromFile(sticker.imagefile), emojis);
      //    });
      // try{

      //   await stickerpacks.sendToWhatsApp();

      //     }on WhatsappStickersException catch (e){
      //       print(e.cause);
      //     }

      setState(() {
        downloading = true;
        if (!downloadList.contains(pack.identiFier)) {
          downloadList.add(pack.identiFier);
        }
      });
      Navigator.of(ctx).pop();
    }
  }

  Future<void> showProgressDownload(context) {
    CupertinoAlertDialog s = CupertinoAlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text("Downloading..."),
        ],
      ),
    );

    AlertDialog a = AlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text("Downloading..."),
        ],
      ),
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        if (Platform.isAndroid)
          return a;
        else
          return s;
      },
    );
  }
}

void addUserr() {
  firestore.collection("Compras").add(
    {
      "Usuario": getuid,
      "StickerCompra": getidcompra,
      "PackName": packagename,
      "Stickers": '$numstickers',
      "Cost": price,
    },
  ).then(
    (value) {
      print(value.id);
    },
  );
}

void addTransactions() {
  firestore.collection("Compras").add(
    {"Usuario": getuid, "StickerCompra": getidcompra},
  ).then(
    (value) {
      print(value.id);
    },
  );
}

String getCompras() {
  firestore
      .collection("Compras")
      .where('Usuario', isEqualTo: getuid)
      .where('StickerCompra', isEqualTo: getidcompra)
      .get()
      .then(
    (querySnapshot) {
      comprado = "comprar";
      querySnapshot.docs.forEach(
        (result) {
          comprado = "comprado";
          print(
            result.data(),
          );
        },
      );
      print(getidcompra);
      print("Comprado:");
      print(comprado);
    },
  );

  return comprado;
}

void comprar(BuildContext context) {
  final size = MediaQuery.of(context).size;
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: price,
      status: PaymentItemStatus.final_price,
    )
  ];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: contents(context),
        actions: [
          Container(
            child: MaterialButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: size.width * 0.045, fontWeight: FontWeight.w800),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              width: size.width * 0.5,
              height: 50,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              onPaymentResult: (data) {
                print("Pagado");
                addUserr();
                router.pop();
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      );
    },
  );
}

contents(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.30,
    child: Container(
      child: Center(
        child: Column(
          children: [
            Image.network(mainImage),
            SizedBox(
              height: size.height * 0.0001,
            ),
            Text(packagename),
            Divider(
              thickness: 1.5,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: 99,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Stickers'),
                        SizedBox(height: size.height * 0.01),
                        Text('Cost'),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.3,
                    height: 99,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$numstickers'),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(r"$" + " " + price),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// void descargar(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text('Hola'),
//           actions: [MaterialButton(child: Text('Descargar'), onPressed: () {})],
//         );
//       });
// }

void loadigFav(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(" shdghgd"),
            ],
          ),
        );
      });
}

void onApplePayResult(paymentResult) {
  // Send the resulting Apple Pay token to your server / PSP
}
