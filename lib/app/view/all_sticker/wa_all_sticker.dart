import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/sticker.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/model/wa_model.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_meedu/router.dart' as router;

class WaAllSticker extends StatefulWidget {
  @override
  _WaAllStickerState createState() => _WaAllStickerState();
}

class _WaAllStickerState extends State<WaAllSticker>
    with TickerProviderStateMixin {
  bool loading = true;
  bool downloading = true;
  List<StickerPack> listOfStickerPack = [];
  List<String> downloadList = [];
  List<String> imageList = [];
  int id = -1;
  late Dio dioDownload;
  // late PageController _pageController;
  late ScrollController _scrollController;
  bool buttonBottomTop = false;
  // InterstitialAd _interstitialAd;

  Future getDataFromJson() async {
    var response = await http.get(
      Uri.parse(ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.HOME),
      headers: {"Accept": "application/json"},
    );
    setState(
      () {
        Map jd = jsonDecode(response.body);
        WaModel waModel = WaModel.fromJson(jd);
        for (Map<String, dynamic> maps in waModel.stickerpack) {
          List<Sticker> listOfStickers = [];
          for (Map<String, dynamic> stickers in maps['stickers']) {
            listOfStickers.add(Sticker(
                imagefile: stickers['image_file'], emojis: stickers['emojis']));
          }
          listOfStickerPack.add(StickerPack(
              identifier: maps['identifier'],
              name: maps['name'],
              publisher: maps['publisher'],
              trayimagefile: maps['tray_image_file'],
              publisheremail: maps['publisher_email'],
              publisherwebsite: maps['publisher_website'],
              privacypolicywebsite: maps['privacy_policy_website'],
              licenseagreementwebsite: maps['license_agreement_website'],
              color: maps['color'],
              cost: maps['cost'],
              stickers: listOfStickers));
        }
        loading = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    downloading = true;
    id = -1;
    // _interstitialAd = InterstitialAd(
    //   adUnitId: AdManager.interstitialAdUnitId
    // );
    // _interstitialAd..load()..show(
    //   anchorType: AnchorType.bottom,
    //   anchorOffset: 0.0,
    //   horizontalCenterOffset: 0.0
    // );
    getDataFromJson();
    _scrollController = ScrollController()
      ..addListener(
        () {
          setState(
            () {
              if (_scrollController.offset >= 350) {
                buttonBottomTop = true;
              } else {
                buttonBottomTop = false;
              }
            },
          );
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    // _interstitialAd?.dispose();
  }

  void backToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 2000), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final logoimg = Theme.of(context).brightness == Brightness.dark
        ? 'assets/logoblack.png'
        : 'assets/logowhite.png';
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;
    final colorshex1 =
        Theme.of(context).brightness == Brightness.dark ? '3A3E98' : '00ff00';
    final colorshex2 =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    final size = MediaQuery.of(context).size;
    return Material(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.10,
        automaticallyImplyLeading: false,
        // actions: [
        //   Container(
        //     padding: EdgeInsets.only(right: 30),
        //     child: GestureDetector(
        //         onTap: () async {
        //           if (details.favorite) {
        //             details.removeFavorite(int.parse(widget.pack.identifier));
        //           } else {
        //             details.addFavorite(int.parse(widget.pack.identifier));
        //           }
        //           // router.pop();
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
      floatingActionButton: Container(
        width: 50.0,
        height: 50.0,
        child: Center(
          child: FittedBox(
            child: buttonBottomTop == false
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      backToTop();
                    },
                    child: Icon(Icons.arrow_upward),
                  ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.only(top: 10),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ListView.builder(
            itemCount: listOfStickerPack.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: shadowSlider
                              ? Colors.grey.shade900
                              : Colors.grey.shade500,
                          // color: listOfSliderSticker[index]
                          //             .color ==
                          //         ""
                          //     ? getColorFromHex(
                          //         GlobalColors().colorWhite)
                          //     : getColorFromHex(
                          //         listOfSliderSticker[index]
                          //             .color),
                          blurRadius: 1.0,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      listOfStickerPack[index].trayimagefile,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [BoxShadow()]),
                                height: 9.0.h,
                                width: 9.0.h,
                              ),
                              onTap: () {
                                pushPageNoAnim(
                                  context,
                                  WaStickerDetail(
                                    pack: listOfStickerPack[index],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listOfStickerPack[index].name,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    listOfStickerPack[index].publisher,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              onTap: () {
                                pushPageNoAnim(
                                    context,
                                    WaStickerDetail(
                                        pack: listOfStickerPack[index]));
                              },
                            ),
                            Spacer(),
                            Container(
                              width: size.height * 0.08,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(right: 10),
                              child: Center(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(
                                  //   Icons
                                  //       .attach_money_outlined,
                                  //   size:
                                  //       size.width * 0.041,
                                  // ),
                                  Text(
                                    r"$" + " " + listOfStickerPack[index].cost,
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 6,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Hero(
                          tag: listOfStickerPack[index],
                          child: GestureDetector(
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < listOfStickerPack[index].sticker.length;
                                    i++)
                                  if (i < 6)
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          child: Image.network(
                                            listOfStickerPack[index]
                                                .sticker[i]
                                                .imagefile,
                                            height: widthHeightSticker().h,
                                            width: widthHeightSticker().w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          height: widthHeightContainer().h,
                                          width: widthHeightContainer().h,
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                            onTap: () {
                              pushPageNoAnim(
                                context,
                                WaStickerDetail(
                                  pack: listOfStickerPack[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ));
  }

  Future<void> addStickersToWa(StickerPack pack) async {
    try {
      ApiConstant.methodChannel.invokeMapMethod("addStickerPackToWhatsApp",
          {"identifier": pack.identiFier, "name": pack.name});
    } on PlatformException catch (error) {
      print(error.message);
    }
  }

  Future<void> downloadStickers(StickerPack pack) async {
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
      String tray = trayImgPath.path + basename(pack.trayimageFile);

      await dioDownload.download(pack.trayimageFile, tray,
          onReceiveProgress: (receive, totals) {
        int percentage = ((receive / totals) * 100).floor();
        print("dio download: $percentage");
      });

      for (int i = 0; i < pack.sticker.length; i++) {
        String pathFile = paths.path + basename(pack.sticker[i].imageFile);
        imageList.add(basename(pack.sticker[i].imageFile));
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
          "trayimagefile": basename(pack.trayimageFile),
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
    }
  }
}
