import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/controller/search/wa_search.dart';
import 'package:flutter_stickers_internet/app/model/sticker.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/model/wa_model.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker/wa_all_sticker.dart';
import 'package:flutter_stickers_internet/app/view/category/wa_category.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      Uri.parse(ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.SLIDER),
      headers: {"Accept": "application/json"},
    );
    setState(() {
      Map slider = jsonDecode(response.body);
      WaModel waModel = WaModel.fromJson(slider);
      for (Map<String, dynamic> maps in waModel.stickerpack) {
        List<Sticker> listSliderSticker = [];
        for (Map<String, dynamic> stickerSlider in maps['stickers']) {
          listSliderSticker.add(Sticker(
              imagefile: stickerSlider['image_file'],
              emojis: stickerSlider['emojis']));
        }
        listOfSliderSticker.add(StickerPack(
            identifier: maps['identifier'],
            name: maps['name'],
            publisher: maps['publisher'],
            trayimagefile: maps['tray_image_file'],
            publisheremail: maps['publisher_email'],
            publisherwebsite: maps['publisher_website'],
            privacypolicywebsite: maps['privacy_policy_website'],
            licenseagreementwebsite: maps['license_agreement_website'],
            color: maps['color'],
            stickers: listSliderSticker));
      }
      loadingSlider = false;
    });
  }

  Future getDataFromJson() async {
    var response = await http.get(
      Uri.parse(ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.HOME),
      // Uri.parse(
      //     "https://gist.githubusercontent.com/Georsh24/3344ad16660b8e274573d1e6b8350449/raw/bb85bed91b75ced919bcd1ae0282903331169d11/price.json"),
      headers: {"Accept": "application/json"},
    );
    setState(() {
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
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    loadingSlider = true;
    downloading = true;
    id = -1;
    getDataFromJson();
    getSlider();
    compratext = false;
    getidcompra = '';

    // widget.scrollController = ScrollController()
    //   ..addListener(() {
    //     setState(() {});
    //   });
    //Favorite();
    // getCompras();
  }

  @override
  void dispose() {
    //widget.scrollController.dispose();
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
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.15,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.chevron_left_outlined,
          //     color: Colors.grey.shade400,
          //     size: size.width * 0.1,
          //   ),
          //   onPressed: () {
          //     router.pop();
          //   },
          // ),
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
          child: Center(
            child: SingleChildScrollView(
              child: loadingSlider
                  ? Container(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            backgroundColor: Colors.red,
                          )),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: size.height * 0.195,
                          width: size.width * 1,
                          child: Container(
                            child: CarouselSlider.builder(
                              itemCount: listOfSliderSticker.length,
                              options: CarouselOptions(
                                height: size.height * 0.17,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                              ),
                              itemBuilder: (context, index, realIndex) {
                                return GestureDetector(
                                  child: Container(
                                    width: size.width * 1,
                                    //padding: EdgeInsets.all(0.10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      // color: listOfSliderSticker[index].color ==
                                      //         ""
                                      //     ? getColorFromHex(
                                      //         GlobalColors().colorWhite)
                                      //     : getColorFromHex(
                                      //         listOfSliderSticker[index].color),
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
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadowSlider
                                              ? Colors.grey.shade900
                                              : Colors.grey.shade500,
                                          blurRadius: 4.0,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl:
                                                '${listOfSliderSticker[index].trayimageFile}',
                                            width: size.width * 0.2),
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${listOfSliderSticker[index].name}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: size.width * 0.04,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                  '${listOfSliderSticker[index].publisher}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${listOfSliderSticker[index].sticker.length}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                            Text('Stickers',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5.0.w,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    pushPageNoAnim(
                                      context,
                                      WaStickerDetail(
                                        pack: listOfSliderSticker[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: SizedBox(
                            height: size.height * 0.21,
                            child: WaCategory(),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Latest stickers',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'See all',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      pushPageNoAnim(context, WaAllSticker());
                                    },
                                  ),
                                ],
                              ),
                              ListView.builder(
                                itemCount: listOfStickerPack.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 6),
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          listOfStickerPack[
                                                                  index]
                                                              .trayimagefile,
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        boxShadow: [
                                                          BoxShadow()
                                                        ]),
                                                    height: 9.0.h,
                                                    width: 9.0.h,
                                                  ),
                                                  onTap: () {
                                                    pushPageNoAnim(
                                                      context,
                                                      WaStickerDetail(
                                                        pack: listOfStickerPack[
                                                            index],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                GestureDetector(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        listOfStickerPack[index]
                                                            .name,
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Text(
                                                        listOfStickerPack[index]
                                                            .publisher,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .color,
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    pushPageNoAnim(
                                                        context,
                                                        WaStickerDetail(
                                                            pack:
                                                                listOfStickerPack[
                                                                    index]));
                                                  },
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: size.height * 0.08,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Center(
                                                      child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Icon(
                                                      //   Icons
                                                      //       .attach_money_outlined,
                                                      //   size:
                                                      //       size.width * 0.041,
                                                      // ),
                                                      Text(
                                                        r"$" +
                                                            " " +
                                                            listOfStickerPack[
                                                                    index]
                                                                .cost,
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.04,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        i <
                                                            listOfStickerPack[
                                                                    index]
                                                                .sticker
                                                                .length;
                                                        i++)
                                                      if (i < 6)
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Container(
                                                              child:
                                                                  Image.network(
                                                                listOfStickerPack[
                                                                        index]
                                                                    .sticker[i]
                                                                    .imagefile,
                                                                height:
                                                                    widthHeightSticker()
                                                                        .h,
                                                                width:
                                                                    widthHeightSticker()
                                                                        .w,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                                ),
                                                              ),
                                                              height:
                                                                  widthHeightContainer()
                                                                      .h,
                                                              width:
                                                                  widthHeightContainer()
                                                                      .h,
                                                            ),
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  getCompras();
                                                  pushPageNoAnim(
                                                    context,
                                                    WaStickerDetail(
                                                      pack: listOfStickerPack[
                                                          index],
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
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          isExtended: true,
          child: WaSearch(),
          onPressed: () {
            WaSearch();
          },
        ),
      ),
    );
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








// import 'dart:io';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../models/stickerPacks.dart';
// import '../models/stickers.dart';
// import '../models/model.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'StickerDetails.dart';
// import 'package:dio/dio.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static const MethodChannel stickerMethodChannel = const MethodChannel(
//       'com.viztushar.flutter.flutter_stickers_internet/sharedata');
//   //url del jsnon
//   final String url =
//       'https://gist.githubusercontent.com/Georsh24/9653a587c3836ea8ef35d4470df6a861/raw/56427b20a21e06fd26e1068e695d293172082337/stickers_p.json';
//   //'http://10.0.2.2:8000/api/tasks';

//   //StickerPacks stickerPack = StickerPacks();
//   List<StickerPacks> st = [];
//   bool isLoading = false, isDownloading = true;
//   int iD = -1;
//   List<String> downloadList = [];
//   List<String> stickerImageList = [];
//   @override
//   void initState() {
//     super.initState();
//     isLoading = true;
//     isDownloading = true;
//     iD = -1;
//     this.getJsonData();
//     getCompras();
//   }

//   Future getJsonData() async {
//     var response = await http.get(
//       Uri.parse(url),
//       headers: {"Accept": "application/json"},
//     );
//     setState(
//       () {
//         Map datas = jsonDecode(response.body);
//         Model m = Model.formJson(datas);
//         for (Map<String, dynamic> json in m.stickerPac) {
//           List<Stickers> s = [];
//           for (Map<String, dynamic> stickers in json['stickers']) {
//             s.add(Stickers(
//                 imagefile: stickers['image_file'], emojis: stickers['emojis']));
//           }
//           print(json['publisher_email'] +
//               " " +
//               json['publisher_website'] +
//               " " +
//               json['privacy_policy_website'] +
//               " " +
//               json['license_agreement_website'] +
//               " ");
//           st.add(StickerPacks(
//               identifier: json['identifier'],
//               name: json['name'],
//               publisher: json['publisher'],
//               trayimagefile: json['tray_image_file'],
//               publisheremail: json['publisher_email'],
//               publisherwebsite: json['publisher_website'],
//               privacypolicywebsite: json['privacy_policy_website'],
//               licenseagreementwebsite: json['license_agreement_website'],
//               stickers: s));
//         }
//         isLoading = false;
//       },
//     );
//   }

//   navigateToDetailsScreen(id, context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) {
//           return MyStickerDetails(
//             stickerPacks: st[id],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
// //delcaracion al cambiar el brignes a dark cambia el logo en logoimge
//     final logoimg = Theme.of(context).brightness == Brightness.dark
//         ? 'assets/logoblack.png'
//         : 'assets/logowhite.png';
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: size.height * 0.15,
//         automaticallyImplyLeading: false,
//         // leading: IconButton(
//         //   icon: Icon(
//         //     Icons.chevron_left_outlined,
//         //     color: Colors.grey.shade400,
//         //     size: size.width * 0.1,
//         //   ),
//         //   onPressed: () {
//         //     router.pop();
//         //   },
//         // ),
//         centerTitle: true,
//         title: Image.asset(
//           '$logoimg',
//           fit: BoxFit.contain,
//           height: size.height * 0.09,
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.topRight,
//               stops: [
//                 0.1,
//                 0.80,
//               ],
//               colors: [
//                 HexColor('00ff00'),
//                 HexColor('05d0ae'),
//               ],
//             ),
//             border: Border(
//               bottom: BorderSide(
//                 width: 3,
//                 color: Colors.grey,
//                 style: BorderStyle.none,
//               ),
//             ),
//           ),
//         ),
//         elevation: 4,
//       ),
//       body: Container(
//         child: Center(
//           child: isLoading
//               ? CircularProgressIndicator()
//               : ListView.builder(
//                   itemCount: st.length,
//                   itemBuilder: (context, i) {
//                     return Card(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 1,
//                           vertical: 7,
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             navigateToDetailsScreen(i, context);
//                           },
//                           child: Row(
//                             children: [
//                               Container(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(200),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.white,
//                                             blurRadius: 5,
//                                             spreadRadius: -8),
//                                       ],
//                                       image: DecorationImage(
//                                         image:
//                                             NetworkImage(st[i].trayimagefile),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   height: 100,
//                                   width: size.width * 0.20,
//                                   margin: EdgeInsets.only(right: 5, left: 7)),
//                               Flexible(
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             height: 25,
//                                             child: Text(
//                                               st[i].name,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                               ),
//                                               overflow: TextOverflow.clip,
//                                               maxLines: 1,
//                                               softWrap: true,
//                                             ),
//                                             margin: EdgeInsets.only(
//                                               right: 10,
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             child: Text('*'),
//                                             margin: EdgeInsets.only(
//                                               right: 10,
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             child: Text(
//                                               st[i].publisher,
//                                               overflow: TextOverflow.clip,
//                                               maxLines: 1,
//                                               softWrap: true,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Text(
//                                         'Este es el texto de prueba jhbedwu euhduwih dbewduwebdebf hedueiu iudhedhu iuehded uihufwefb uihefu hjedwr hwhfb  ',
//                                         overflow: TextOverflow.clip,
//                                         maxLines: 3,
//                                         softWrap: true,
//                                       ),
//                                       width: size.width * 0.55,
//                                       margin: EdgeInsets.only(
//                                         right: 5,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   Container(
//                                     child: IconButton(
//                                       iconSize: size.width * 0.1,
//                                       icon: Icon(
//                                         Icons.favorite_border_outlined,
//                                       ),
//                                       onPressed: () {},
//                                     ),
//                                     height: 60,
//                                     width: size.width * 0.18,
//                                   ),
//                                   Container(
//                                     child: Text(
//                                       st[i].publisherEmail,
//                                       style: TextStyle(
//                                         fontSize: 9,
//                                       ),
//                                       overflow: TextOverflow.clip,
//                                       maxLines: 3,
//                                       softWrap: true,
//                                     ),
//                                     width: size.width * 0.1,
//                                     margin: EdgeInsets.only(right: 5),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         height: 100,
//                         width: double.infinity,
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }

// // si ya funciona no le mueva a partir de aqui se hace la descarga y añaade sticker to whatssap algun problema ir mainactivity.kt
//   Future<void> addToWhatsapp(StickerPacks s) async {
//     try {
//       stickerMethodChannel.invokeMapMethod("addStickerPackToWhatsApp",
//           {"identifier": s.identiFier, "name": s.name});
//     } on PlatformException catch (e) {
//       print(e.details);
//     }
//   }

//   Future<void> downloadSticker(StickerPacks s) async {
//     stickerImageList.clear();
//     if (!downloadList.contains(s.identiFier)) {
//       await Permission.storage.request();
//       Dio dio = Dio();
//       var dirToSave = await getApplicationDocumentsDirectory();
//       var path = await Directory(dirToSave.path +
//               "/" +
//               "stickers_asset" +
//               "/" +
//               s.identiFier +
//               "/")
//           .create(recursive: true);
//       var trypath = await Directory(dirToSave.path +
//               "/" +
//               "stickers_asset" +
//               "/" +
//               s.identiFier +
//               "/try/")
//           .create(recursive: true);
//       print(path.path + "\n" + trypath.path);

//       String tryFilePath = trypath.path + basename(s.trayImageFile);
//       print(tryFilePath);
//       await dio.download(s.trayImageFile, tryFilePath,
//           onReceiveProgress: (rec, total) {
//         print((rec / total) * 100);
//         print("try image downloaded");
//       });

//       for (int i = 0; i < s.sticker.length; i++) {
//         String imageFilePath = path.path + basename(s.sticker[i].imageFile);
//         stickerImageList.add(basename(s.sticker[i].imageFile));
//         await dio.download(s.sticker[i].imageFile, imageFilePath,
//             onReceiveProgress: (rec, total) {
//           print((rec / total) * 100);
//         });
//       }

//       try {
//         stickerMethodChannel.invokeMapMethod("addTOJson", {
//           "identiFier": s.identiFier,
//           "name": s.name,
//           "publisher": s.publisher,
//           "trayimagefile": basename(s.trayImageFile),
//           "publisheremail": s.publisherEmail,
//           "publisherwebsite": s.publisherWebsite,
//           "privacypolicywebsite": s.privacyPolicyWebsite,
//           "licenseagreementwebsite": s.licenseAgreementWebsite,
//           "sticker_image": stickerImageList,
//         });
//       } on PlatformException catch (e) {
//         print(e.details);
//       }
//       setState(() {
//         isDownloading = true;
//         if (!downloadList.contains(s.identiFier)) {
//           downloadList.add(s.identiFier);
//         }
//       });
//     } else {
//       print("not");
//     }
//   }

//   Future<void> showDialogs(context) {
//     AlertDialog s = AlertDialog(
//       content: Row(
//         children: <Widget>[
//           CircularProgressIndicator(),
//           SizedBox(
//             width: 10,
//           ),
//           Text("Downloading..."),
//         ],
//       ),
//     );
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return s;
//       },
//     );
//   }
// }
