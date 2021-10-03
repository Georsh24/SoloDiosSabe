import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/screens/StickerDetails.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_detail.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart' as pathbasename;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/flutter_meedu.dart' as medu;

import 'package:sizer/sizer.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
String getuid = '';
String getidcompra = '';
String comprado = "init";

class WaStickerDetail extends StatefulWidget {
  StickerPack pack;

  WaStickerDetail({required this.pack});

  @override
  _WaStickerDetailState createState() => _WaStickerDetailState();
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
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Provider.of<WaDetail>(context, listen: false)
          .checkFav(int.parse(widget.pack.identifier));
    });
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
    final size = MediaQuery.of(context).size;
    return Consumer<WaDetail>(builder: (context, details, _) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: getColorFromHex(GlobalColors().colorWhite),
        // appBar: AppBar(
        //   backgroundColor: getColorFromHex(GlobalColors().colorWhite),
        //   elevation: 0.0,
        //   title: Text(widget.pack.name, style: TextStyle(color: getColorFromHex(GlobalColors().colorText)),),
        //   leading: IconButton(
        //     onPressed: (){
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.arrow_back_ios, color: getColorFromHex(GlobalColors().activeIconBottom),),),
        // ),
        appBar: AppBar(
          toolbarHeight: size.height * 0.10,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 30),
              child: GestureDetector(
                  onTap: () async {
                    if (details.favorite) {
                      details.removeFavorite(int.parse(widget.pack.identifier));
                    } else {
                      details.addFavorite(
                          int.parse(widget.pack.identifier), widget.pack);
                    }
                    // router.pop();
                    loadigFav(context);
                  },
                  child: Icon(
                    details.favorite ? Icons.favorite : Icons.favorite,
                    color: details.favorite ? Colors.red : Colors.black38,
                    size: size.width * 0.050,
                  )),
            )
          ],
          leading: IconButton(
            padding: EdgeInsets.all(30),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: size.width * 0.05,
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
                  HexColor('00ff00'),
                  HexColor('05d0ae'),
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
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                medu.Consumer(builder: (_, watch, __){
                  final user = watch(sessionProvider).user!;

                getuid = user.uid;
                getidcompra = widget.pack.identiFier;
                return SizedBox.shrink();
                }),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: widget.pack.color == ""
                                    ? getColorFromHex(GlobalColors().searchBar)
                                    : getColorFromHex(widget.pack.color),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
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
                                    Image.network(
                                      widget.pack.trayimageFile,
                                      height: 17.0.h,
                                      width: 30.0.w,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.pack.name,
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                color: getColorFromHex(
                                                    GlobalColors().colorText)),
                                          ),
                                          Text(
                                            widget.pack.publisher,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                color: getColorFromHex(
                                                    GlobalColors()
                                                        .searchIconColor)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "${widget.pack.stickers.length}",
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontStyle: FontStyle.normal,
                                              decoration: TextDecoration.none,
                                              color: getColorFromHex(
                                                  GlobalColors().colorText)),
                                        ),
                                        Text(
                                          "Stickers",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              decoration: TextDecoration.none,
                                              color: getColorFromHex(
                                                  GlobalColors()
                                                      .searchIconColor)),
                                        ),
                                      ],
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
                                    color: getColorFromHex(
                                        GlobalColors().bgSticker),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Image.network(
                                  widget.pack.stickers[i].imageFile,
                                  height: widthHeightSticker().h,
                                  width: widthHeightSticker().w,
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 12.0.h,
                      )
                    ],
                  ),
                ),
                //  Stack(
                //                           children: [
                //                             if(!downloadList.contains(widget.pack.identiFier))...[
                //                               !downloading ? Center(
                //                                 child: Container(
                //                                   child: CircularProgressIndicator(strokeWidth: 1,),height: 2.0.h, width: 4.0.w,),
                //                               ) :
                //                               GestureDetector(
                //                                 child: Container(
                //                                   decoration: BoxDecoration(
                //                                       color: getColorFromHex(GlobalColors().waColor),
                //                                       borderRadius: BorderRadius.all(Radius.circular(8)),
                //                                       boxShadow: [
                //                                         BoxShadow(
                //                                           color: getColorFromHex(GlobalColors().waColor),
                //                                           spreadRadius: 0.4,
                //                                         )
                //                                       ]
                //                                   ),
                //                                   child: Padding(
                //                                     padding: const EdgeInsets.all(5.0),
                //                                     child: Text('Download', style: TextStyle(
                //                                         color: getColorFromHex(GlobalColors().colorWhite), fontSize: 12
                //                                     ),),
                //                                   ),
                //                                 ),
                //                                 onTap: (){
                //                                   setState(() {
                //                                     downloading = false;
                //                                     downloadStickers(widget.pack, context);
                //                                   });
                //                                 },
                //                               ),
                //                             ],
                //                             if(downloadList.contains(widget.pack.identiFier))...[
                //                               GestureDetector(
                //                                 child: Container(
                //                                   decoration: BoxDecoration(
                //                                       color: getColorFromHex(GlobalColors().waColor),
                //                                       borderRadius: BorderRadius.all(Radius.circular(8)),
                //                                       boxShadow: [
                //                                         BoxShadow(
                //                                           color: getColorFromHex(GlobalColors().waColor),
                //                                           spreadRadius: 0.4,
                //                                         )
                //                                       ]
                //                                   ),
                //                                   child: Padding(
                //                                     padding: const EdgeInsets.all(5.0),
                //                                     child: Text('Add to Whats app', style: TextStyle(
                //                                         color: getColorFromHex(GlobalColors().colorWhite), fontSize: 12
                //                                     ),),
                //                                   ),
                //                                 ),
                //                                 onTap: (){
                //                                   setState(() {
                //                                     addStickersToWa(widget.pack);
                //                                   });
                //                                 },
                //                               ),
                //                             ]
                //                           ],
                //                         ),
                Positioned(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.05,
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
                          HexColor('00ff00'),
                          HexColor('05d0ae'),
                        ])),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Lo Quiero',
                        style: TextStyle(
                            color: getColorFromHex(GlobalColors().colorWhite),
                            fontSize: 25),
                      ),
                      onPressed: (){
                         if (getCompras() == "comprado"){
                    if (!downloadList.contains(widget.pack.identiFier)) {
                      downloading = false;
                      downloadStickers(widget.pack, context);
                    } else {
                      addStickersToWa(widget.pack);
                    }
                    }
                    else{
                      print("valor if");
                      print(comprado);
                      comprar(context);
                  }
                      },
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // _loadBanner(){
  //   _bannerAd
  //   ..load()
  //       ..show(anchorType: AnchorType.bottom, anchorOffset: 6.0.h, horizontalCenterOffset: 0);
  // }

  // _share() async{
  //   PackageInfo pi = await PackageInfo.fromPlatform();
  //   Share.text(pi.appName, "Title: ${widget.pack.name}" '\n'
  //       "Publisher: ${widget.pack.publisher}" '\n'
  //       "Download full app in this link https://play.google.com/store/apps/details?id=${pi.packageName}" '\n'
  //       "version: ${pi.version}" '\n'
  //       "build number: ${pi.buildNumber} ",
  //       'text/plain');
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
  firestore
      .collection("Compras")
      .add({"Usuario": getuid, "StickerCompra": getidcompra}).then((value) {
    print(value.id);
  });
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
          print(result.data());
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
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hola'),
          actions: [
            MaterialButton(
                child: Text('comprar'),
                onPressed: () {
                  addUserr();
                })
          ],
        );
      });
}

void descargar(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hola'),
          actions: [MaterialButton(child: Text('Descargar'), onPressed: () {})],
        );
      });
}

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




