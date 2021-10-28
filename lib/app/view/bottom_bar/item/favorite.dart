import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_detail.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite_notif.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as basenamepath;

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var notif = WaFavoriteNotif();
  List<String> downloadList = [];
  List<String> imageList = [];
  int id = -1;
  bool downloading = true;
  Dio? dioDownload;

  @override
  void initState() {
    super.initState();
    id = -1;
    downloading = true;
    getWaFavorite();
  }

  getWaFavorite() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<WaFavoriteNotif>(context, listen: false)
            .getEbooksFavorites();
        Provider.of<WaDetail>(context, listen: false)
            .checkFav(notif.list.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaFavoriteNotif>(builder: (context, waFavoriteNotif, _) {
      print("sukro ${waFavoriteNotif.list.length}");
      return Container(
        child: ListView.builder(
            itemCount: waFavoriteNotif.list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              StickerPack waFavorite =
                  StickerPack.fromJson(waFavoriteNotif.list[index]);
              return ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
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
                                    waFavorite.trayimagefile,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: waFavorite.color == ""
                                      ? getColorFromHex(
                                          GlobalColors().colorWhite)
                                      : getColorFromHex(waFavorite.color),
                                  boxShadow: [
                                    BoxShadow(
                                      color: waFavorite.color == ""
                                          ? getColorFromHex(
                                              GlobalColors().colorWhite)
                                          : getColorFromHex(waFavorite.color),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.3,
                                    )
                                  ]),
                              height: 9.0.h,
                              width: 9.0.h,
                            ),
                            onTap: () {
                              pushPageNoAnim(
                                  context,
                                  WaStickerDetail(
                                    pack: waFavorite,
                                  ));
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
                                  waFavorite.publisher,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                Text(
                                  waFavorite.name,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                )
                              ],
                            ),
                            onTap: () {
                              pushPageNoAnim(
                                  context,
                                  WaStickerDetail(
                                    pack: waFavorite,
                                  ));
                            },
                          ),
                          Spacer(),
                          Stack(
                            children: [
                              if (!downloadList
                                  .contains(waFavorite.identiFier)) ...[
                                id == index && !downloading
                                    ? Center(
                                        child: Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ),
                                          height: 2.0.h,
                                          width: 4.0.w,
                                        ),
                                      )
                                    : GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: getColorFromHex(
                                                  GlobalColors().waColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: getColorFromHex(
                                                      GlobalColors().waColor),
                                                  spreadRadius: 0.4,
                                                )
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Download',
                                              style: TextStyle(
                                                  color: getColorFromHex(
                                                      GlobalColors()
                                                          .colorWhite),
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            id = index;
                                            downloading = false;
                                            downloadStickers(waFavorite);
                                          });
                                        },
                                      ),
                              ],
                              if (downloadList
                                  .contains(waFavorite.identiFier)) ...[
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: getColorFromHex(
                                            GlobalColors().waColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: getColorFromHex(
                                                GlobalColors().waColor),
                                            spreadRadius: 0.4,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Add to Whats app',
                                        style: TextStyle(
                                            color: getColorFromHex(
                                                GlobalColors().colorWhite),
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      id = index;
                                      addStickersToWa(waFavorite);
                                    });
                                  },
                                ),
                              ]
                            ],
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
                        tag: waFavorite,
                        child: GestureDetector(
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < waFavorite.sticker.length;
                                  i++)
                                if (i < 6)
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Container(
                                        child: Image.network(
                                          waFavorite.sticker[i].imagefile,
                                          height: widthHeightSticker().h,
                                          width: widthHeightSticker().w,
                                        ),
                                        decoration: BoxDecoration(
                                            color: getColorFromHex(
                                                GlobalColors().bgSticker),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
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
                                  pack: waFavorite,
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    });
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
      String tray =
          trayImgPath.path + basenamepath.basename(pack.trayimageFile);

      await dioDownload!.download(pack.trayimageFile, tray,
          onReceiveProgress: (receive, totals) {
        int percentage = ((receive / totals) * 100).floor();
        print("dio download: $percentage");
      });

      for (int i = 0; i < pack.sticker.length; i++) {
        String pathFile =
            paths.path + basenamepath.basename(pack.sticker[i].imageFile);
        imageList.add(basenamepath.basename(pack.sticker[i].imageFile));
        await dioDownload!.download(pack.sticker[i].imageFile, pathFile,
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
          "trayimagefile": basenamepath.basename(pack.trayimageFile),
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
