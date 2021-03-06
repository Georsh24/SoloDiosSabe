import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/sticker.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/model/wa_model.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/details/wa_sticker_details.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/global_padding.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:http/http.dart' as http;

class WaSearch extends StatefulWidget {
  @override
  WaSearchBaseState createState() => WaSearchBaseState();
}

class WaSearchBaseState extends State<WaSearch> {
  StickerPack stickerPack = StickerPack(stickers: []);
  List<StickerPack> listOfStickerPack = [];
  List<String> downloadList = [];
  List<String> imageList = [];
  bool loading = true;

  Future getDataFromJson(String str) async {
    var response = await http.get(
      Uri.parse(
          ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.SEARCH + str),
      headers: {"Accept": "application/json"},
    );
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
  }

  @override
  void initState() {
    super.initState();
    getDataFromJson('');
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            child: Icon(Icons.search),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
        onTap: () {
          showSearch(context: context, delegate: WaSearchAction());
        },
      ),
    );
  }
}

class WaSearchAction extends SearchDelegate<String> {
  bool loading = true;

  Future getDataFromJson(String str) async {
    print(
        "sup sup ${ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.SEARCH + str}");
    var response = await http.get(
      Uri.parse(
          ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.SEARCH + str),
      headers: {"Accept": "application/json"},
    );

    loading = false;
    return response.body;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        // close(context, null);
        router.pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    // return FocusScope(child: Container());
    return query.isEmpty
        ? Center(
            child: Text(
              'No fount Sticker',
              style: TextStyle(
                  fontSize: 18,
                  color: getColorFromHex(GlobalColors().searchIconColor)),
            ),
          )
        : FutureBuilder(
            future: getDataFromJson(query),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                ));
              } else {
                Map jd = jsonDecode(snapshot.data.toString());
                WaModel waModel = WaModel.fromJson(jd);
                List<StickerPack> listOfStickerPack = [];
                for (Map<String, dynamic> maps in waModel.stickerpack) {
                  List<Sticker> listOfStickers = [];
                  for (Map<String, dynamic> stickers in maps['stickers']) {
                    listOfStickers.add(Sticker(
                        imagefile: stickers['image_file'],
                        emojis: stickers['emojis']));
                  }
                  listOfStickerPack.add(StickerPack(
                      identifier: maps['identifier'],
                      name: maps['name'],
                      publisher: maps['publisher'],
                      trayimagefile: maps['tray_image_file'],
                      publisheremail: maps['publisher_email'],
                      publisherwebsite: maps['publisher_website'],
                      privacypolicywebsite: maps['privacy_policy_website'],
                      licenseagreementwebsite:
                          maps['license_agreement_website'],
                      color: maps['color'],
                      cost: maps['cost'],
                      stickers: listOfStickers));
                }
                return ListView.builder(
                  itemCount: listOfStickerPack.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            listOfStickerPack[index]
                                                .trayimagefile,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(right: 10),
                                    child: Center(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              listOfStickerPack[index].cost,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              listOfStickerPack[index]
                                                  .sticker
                                                  .length;
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
                                                  height:
                                                      widthHeightSticker().h,
                                                  width: widthHeightSticker().w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                height:
                                                    widthHeightContainer().h,
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
                );
              }
            });
  }

//   @override
//   Widget buildResults(BuildContext context) {
// return
//   }
  @override
  Widget buildSuggestions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shadowSlider = Theme.of(context).brightness == Brightness.dark;
    return query.isEmpty
        ? Center(
            child: Text(
              'Enter your keywords',
              style: TextStyle(
                  fontSize: 18,
                  color: getColorFromHex(GlobalColors().searchIconColor)),
            ),
          )
        : FutureBuilder(
            future: getDataFromJson(query),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                ));
              } else {
                Map jd = jsonDecode(snapshot.data.toString());
                WaModel waModel = WaModel.fromJson(jd);
                List<StickerPack> listOfStickerPack = [];
                for (Map<String, dynamic> maps in waModel.stickerpack) {
                  List<Sticker> listOfStickers = [];
                  for (Map<String, dynamic> stickers in maps['stickers']) {
                    listOfStickers.add(Sticker(
                        imagefile: stickers['image_file'],
                        emojis: stickers['emojis']));
                  }
                  listOfStickerPack.add(StickerPack(
                      identifier: maps['identifier'],
                      name: maps['name'],
                      publisher: maps['publisher'],
                      trayimagefile: maps['tray_image_file'],
                      publisheremail: maps['publisher_email'],
                      publisherwebsite: maps['publisher_website'],
                      privacypolicywebsite: maps['privacy_policy_website'],
                      licenseagreementwebsite:
                          maps['license_agreement_website'],
                      color: maps['color'],
                      cost: maps['cost'],
                      stickers: listOfStickers));
                }
                return ListView.builder(
                  itemCount: listOfStickerPack.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            listOfStickerPack[index]
                                                .trayimagefile,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(right: 10),
                                    child: Center(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              listOfStickerPack[index].cost,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              listOfStickerPack[index]
                                                  .sticker
                                                  .length;
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
                                                  height:
                                                      widthHeightSticker().h,
                                                  width: widthHeightSticker().w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                height:
                                                    widthHeightContainer().h,
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
                );
              }
            });
  }
}

void busqueda(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hola'),
          actions: [MaterialButton(child: Text('Descargar'), onPressed: () {})],
        );
      });
}
