import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/category.dart';
import 'package:flutter_stickers_internet/app/model/wa_model_cat.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker_by_cat/wa_sticker_bycat.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:http/http.dart' as http;

class WaAllCategory extends StatefulWidget {
  @override
  _WaAllCategoryState createState() => _WaAllCategoryState();
}

class _WaAllCategoryState extends State<WaAllCategory> {
  List<Category> listOfCategory = [];
  bool isLoading = true;

  // InterstitialAd _interstitialAd;

  Future<void> getAllCategory() async {
    var response = await http.get(
        Uri.parse(
            ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.CATEGORY),
        headers: {'Accept': 'application/json'});
    setState(() {
      Map<String, dynamic> map = jsonDecode(response.body);
      WaModelCat waModelCat = WaModelCat.fromJson(map);

      for (Map<String, dynamic> cate in waModelCat.category) {
        listOfCategory.add(Category(
            cat_id: cate['cat_id'],
            photo_cat: cate['photo_cat'],
            name: cate['name'],
            status: cate['status'],
            color: cate['color']));
      }
    });
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getAllCategory();
    // _interstitialAd = InterstitialAd(
    //   adUnitId: AdManager.interstitialAdUnitId,
    // );
    // _interstitialAd
    //   ..load()
    //   ..show(
    //       anchorType: AnchorType.bottom,
    //       anchorOffset: 0.0,
    //       horizontalCenterOffset: 0.0);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // _interstitialAd?.dispose();
  // }

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
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 8.5 / 9.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 2.0),
                  itemCount: listOfCategory.length,
                  itemBuilder: (ctx, i) {
                    return Hero(
                      tag: listOfCategory[i],
                      child: GestureDetector(
                        // child: Column(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Column(

                              children: [
                                Container(
                                  
                                  width: size.width * 0.27,
                                  height: size.height * 0.13,
                                  margin: EdgeInsets.all(0.2),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: listOfCategory[i].color == ""
                                        ? getColorFromHex(
                                            GlobalColors().bgSticker)
                                        : getColorFromHex(
                                            listOfCategory[i].color),
                                    boxShadow: [
                                      BoxShadow(
                                        color: listOfCategory[i].color == ""
                                            ? getColorFromHex(
                                                GlobalColors().colorWhite)
                                            : getColorFromHex(
                                                listOfCategory[i].color),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.2,
                                      )
                                    ],
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: listOfCategory[i].photo_cat,
                                  
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.2,
                                  child: Center(                                
                                    child: Text(                   
                                    '${listOfCategory[i].name}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                           //ebookTheme.themeMode().ratingBar,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        onTap: () {
                          pushPage(
                              context,
                              WaAllStickerByCat(
                                id: listOfCategory[i].cat_id,
                              ));
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
