import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/sticker.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/model/wa_model.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker/wa_all_sticker.dart';
import 'package:flutter_stickers_internet/app/view/category/wa_category.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {

  ScrollController scrollController;

  Dashboard({required this.scrollController});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool loadingSlider = true;
  bool loading = true;
  bool downloading = true;
  List<StickerPack> listOfSliderSticker = [];
  List<StickerPack> listOfStickerPack = [];
  List<String> downloadList = [];
  List<String> imageList = [];
  int id = -1;
  late Dio dioDownload;

  Future getSlider() async {
    var response = await http.get(
      Uri.parse(ApiConstant.BASE_URL+ApiConstant.JSON+ApiConstant.SLIDER),
      headers: {"Accept" : "application/json"},);
    setState(() {
      Map slider = jsonDecode(response.body);
      WaModel waModel = WaModel.fromJson(slider);
      for(Map<String, dynamic> maps in waModel.stickerpack){
        List<Sticker> listSliderSticker = [];
        for(Map<String, dynamic> stickerSlider in maps['stickers']){
          listSliderSticker.add(Sticker(imagefile: stickerSlider['image_file'], emojis: stickerSlider['emojis']));
        }
        listOfSliderSticker.add(StickerPack(identifier: maps['identifier'], name: maps['name'], publisher: maps['publisher'], trayimagefile: maps['tray_image_file'],
            publisheremail: maps['publisher_email'], publisherwebsite: maps['publisher_website'], privacypolicywebsite: maps['privacy_policy_website'],
            licenseagreementwebsite: maps['license_agreement_website'], color: maps['color'], stickers: listSliderSticker));
      } loadingSlider = false;
    });
  }
  
  Future getDataFromJson() async{
    var response = await http.get(
      Uri.parse(ApiConstant.BASE_URL+ApiConstant.JSON+ApiConstant.HOME),
      headers: {"Accept": "application/json"},
    );
    setState(() {
      Map jd = jsonDecode(response.body);
      WaModel waModel = WaModel.fromJson(jd);
      for(Map<String, dynamic> maps in waModel.stickerpack){
        List<Sticker> listOfStickers = [];
        for(Map<String, dynamic> stickers in maps['stickers']){
          listOfStickers.add(Sticker(imagefile: stickers['image_file'], emojis: stickers['emojis']));
        }
        listOfStickerPack.add(StickerPack(
            identifier: maps['identifier'], name: maps['name'], publisher: maps['publisher'], trayimagefile: maps['tray_image_file'],
            publisheremail: maps['publisher_email'], publisherwebsite: maps['publisher_website'], privacypolicywebsite: maps['privacy_policy_website'],
            licenseagreementwebsite: maps['license_agreement_website'], color: maps['color'], stickers: listOfStickers
        ));
      } loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    loadingSlider = true;
    downloading = true;
    id = -1;
    getDataFromJson();
    getSlider();
    widget.scrollController = ScrollController()..addListener(() {setState(() {

    });});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: loading ? Container(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    backgroundColor: Colors.red,)),)
                : Column(
              children: [
                // SizedBox(
                //   height: 23.0.h,
                //   child: Swiper(
                //       itemCount: listOfSliderSticker.length,
                //       itemHeight: 10.0.h,
                //       itemBuilder: (BuildContext context, int index){
                //         return GestureDetector(
                //           child: Padding(
                //             padding: const EdgeInsets.all(10.0),
                //             child: Container(
                //               margin: EdgeInsets.all(0.2),
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                //                 color: listOfSliderSticker[index].color == "" ? getColorFromHex(GlobalColors().colorWhite):
                //                 getColorFromHex(listOfSliderSticker[index].color),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: listOfSliderSticker[index].color == "" ? getColorFromHex(GlobalColors().colorWhite):
                //                     getColorFromHex(listOfSliderSticker[index].color),
                //                     blurRadius: 1.0,
                //                     spreadRadius: 0.2,
                //                   )
                //                 ],
                //               ),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                    CachedNetworkImage(
                //                      imageUrl: '${listOfSliderSticker[index].trayimageFile}',
                //                      width: 40.0.w,
                //                    ),
                //                   Center(
                //                     child: Column(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text('${listOfSliderSticker[index].name}', style: TextStyle(fontWeight: FontWeight.w500,
                //                             fontSize: 17,
                //                             color: getColorFromHex(GlobalColors().colorText)),
                //                         ),
                //                         Text('${listOfSliderSticker[index].publisher}', style: TextStyle(fontWeight: FontWeight.w500,
                //                             fontSize: 17,
                //                             color: getColorFromHex(GlobalColors().colorText)),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 7,),
                //                   Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Text('${listOfSliderSticker[index].sticker.length}', style: TextStyle(fontWeight: FontWeight.w500,
                //                           fontSize: 33,
                //                           color: getColorFromHex(GlobalColors().colorText)),
                //                       ),
                //                       Text('Stickers', style: TextStyle(fontWeight: FontWeight.w500,
                //                           fontSize: 12,
                //                           color: getColorFromHex(GlobalColors().colorText)),
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(width: 4.0.w,)
                //                  ],
                //               ),
                //             ),
                //           ),
                //           onTap: (){
                //             pushPage(context, WaStickerDetail(pack: listOfSliderSticker[index],));
                //           },
                //         );
                //       }
                //   ),
                // ),
                SizedBox(height: 25.0.h, child: WaCategory()),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Latest stickers',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: getColorFromHex(GlobalColors().colorText)),),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('See all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: getColorFromHex(GlobalColors().colorText)),),
                            ),
                            onTap: (){
                              pushPage(context, WaAllSticker());
                            },
                          ),
                        ],
                      ),
                      ListView.builder(
                          itemCount: listOfStickerPack.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
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
                                                  listOfStickerPack[index].trayimagefile,
                                                  height: 80,
                                                  width: 80,),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: listOfStickerPack[index].color == "" ? getColorFromHex(GlobalColors().colorWhite) :
                                                getColorFromHex(listOfStickerPack[index].color),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: listOfStickerPack[index].color == "" ? getColorFromHex(GlobalColors().colorWhite) :
                                                    getColorFromHex(listOfStickerPack[index].color),
                                                    blurRadius: 1.0,
                                                    spreadRadius: 0.3,
                                                  )
                                                ]
                                            ),
                                            height: 9.0.h,
                                            width: 9.0.h,
                                          ),
                                          onTap: (){
                                            pushPage(context, WaStickerDetail(pack: listOfStickerPack[index],));
                                          },
                                        ),
                                        SizedBox(width: 8,),
                                        GestureDetector(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listOfStickerPack[index].publisher, style: TextStyle(
                                                  color: Colors.black, fontSize: 18
                                              ),),
                                              Text(listOfStickerPack[index].name, style: TextStyle(
                                                  color: Colors.grey, fontSize: 15
                                              ),)
                                            ],
                                          ),
                                          onTap: (){
                                            pushPage(context, WaStickerDetail(pack: listOfStickerPack[index],));
                                          },
                                        ),
                                        Spacer(),
                                        Stack(
                                          children: [
                                            if(!downloadList.contains(listOfStickerPack[index].identiFier))...[
                                              id == index && !downloading ? Center(
                                                child: Container(
                                                  child: CircularProgressIndicator(strokeWidth: 1,),height: 2.0.h, width: 4.0.w,),
                                              ) :
                                              GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: getColorFromHex(GlobalColors().waColor),
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: getColorFromHex(GlobalColors().waColor),
                                                          spreadRadius: 0.4,
                                                        )
                                                      ]
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text('Download', style: TextStyle(
                                                        color: getColorFromHex(GlobalColors().colorWhite), fontSize: 12
                                                    ),),
                                                  ),
                                                ),
                                                onTap: (){
                                                  setState(() {
                                                    id = index;
                                                    downloading = false;
                                                    downloadStickers(listOfStickerPack[index]);
                                                  });
                                                },
                                              ),
                                            ],
                                            if(downloadList.contains(listOfStickerPack[index].identiFier))...[
                                              GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: getColorFromHex(GlobalColors().waColor),
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: getColorFromHex(GlobalColors().waColor),
                                                          spreadRadius: 0.4,
                                                        )
                                                      ]
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text('Add to Whats app', style: TextStyle(
                                                        color: getColorFromHex(GlobalColors().colorWhite), fontSize: 12
                                                    ),),
                                                  ),
                                                ),
                                                onTap: (){
                                                  setState(() {
                                                    id = index;
                                                    addStickersToWa(listOfStickerPack[index]);
                                                  });
                                                },
                                              ),
                                            ]
                                          ],
                                        ),
                                        SizedBox(width: 6,)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    ),
                                    SizedBox(height: 8,),
                                    Hero(
                                      tag: listOfStickerPack[index],
                                      child: GestureDetector(
                                        child: Row(
                                          children: [
                                            for(int i = 0; i < listOfStickerPack[index].sticker.length; i++) if(i < 6) Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Container(
                                                  child: Image.network(
                                                    listOfStickerPack[index].sticker[i].imagefile,
                                                    height: widthHeightSticker().h,
                                                    width: widthHeightSticker().w,),
                                                  decoration: BoxDecoration(
                                                      color: getColorFromHex(GlobalColors().bgSticker),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: widthHeightContainer().h,
                                                  width: widthHeightContainer().h,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          pushPage(context, WaStickerDetail(pack: listOfStickerPack[index],));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addStickersToWa(StickerPack pack) async{
    try{
      ApiConstant.methodChannel.invokeMapMethod("addStickerPackToWhatsApp", {
        "identifier": pack.identiFier, "name": pack.name
      });
    }on PlatformException catch(error){
      print(error.message);
    }
  }

  Future<void> downloadStickers(StickerPack pack) async{
    imageList.clear();
    if(!downloadList.contains(pack.identiFier)){
      await Permission.storage.request();
      dioDownload = new Dio();
      var saveToDirectory = await getApplicationDocumentsDirectory();
      var paths = await Directory(saveToDirectory.path + "/" + "stickers_asset" + "/" + pack.identiFier + "/").create(recursive: true);
      var trayImgPath = await Directory(saveToDirectory.path + "/" + "stickers_asset" + "/" + pack.identiFier + "/try/" ).create(recursive: true);
      String tray = trayImgPath.path+basename(pack.trayimageFile);

      await dioDownload.download(pack.trayimageFile, tray, onReceiveProgress: (receive, totals){
        int percentage = ((receive / totals) * 100).floor();
        print("dio download: $percentage");
      });

      for(int i = 0; i<pack.sticker.length; i++){
        String pathFile = paths.path + basename(pack.sticker[i].imageFile);
        imageList.add(basename(pack.sticker[i].imageFile));
        await dioDownload.download(pack.sticker[i].imageFile, pathFile, onReceiveProgress: (receive, totals){
          int percentage = ((receive / totals) * 100).floor();
          print("dio second: $percentage");
        });
      }
      try{
        ApiConstant.methodChannel.invokeMapMethod("addTOJson",{
          "identiFier": pack.identiFier,
          "name": pack.names,
          "publisher": pack.publisher,
          "trayimagefile": basename(pack.trayimageFile),
          "publisheremail": pack.publisherEmail,
          "publisherwebsite": pack.publisherWebsite,
          "privacypolicywebsite": pack.privacyPolicyWebsite,
          "licenseagreementwebsite": pack.licenseAgreementWebsite,
          "sticker_image": imageList,});
      }on PlatformException catch(error){
        print(error.message);
      }

      setState(() {
        downloading = true;
        if(!downloadList.contains(pack.identiFier)){
          downloadList.add(pack.identiFier);
        }
      });
    }
  }
}