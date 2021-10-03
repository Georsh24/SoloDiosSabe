import 'dart:convert';

import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/category.dart';
import 'package:flutter_stickers_internet/app/model/wa_model_cat.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker_by_cat/wa_sticker_bycat.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    // _interstitialAd = InterstitialAd(
    //   adUnitId: AdManager.interstitialAdUnitId,
    // );
    // _interstitialAd
    //   ..load()
    //   ..show(
    //       anchorType: AnchorType.bottom,
    //       anchorOffset: 0.0,
    //       horizontalCenterOffset: 0.0);
    isLoading = true;
    getAllCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            backgroundColor: getColorFromHex(GlobalColors().colorWhite),
            appBar: AppBar(
              backgroundColor: getColorFromHex(GlobalColors().colorWhite),
              elevation: 0.0,
              title: Text(
                'All Category',
                style:
                    TextStyle(color: getColorFromHex(GlobalColors().colorText)),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: getColorFromHex(GlobalColors().activeIconBottom),
                ),
              ),
            ),
            body: Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 8.0 / 9.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemCount: listOfCategory.length,
                  itemBuilder: (ctx, i) {
                    return Hero(
                      tag: listOfCategory[i],
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: listOfCategory[i].color == ""
                                  ? getColorFromHex(GlobalColors().bgSticker)
                                  : getColorFromHex(listOfCategory[i].color),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${listOfCategory[i].name}',
                                  style: TextStyle(
                                      color: getColorFromHex(GlobalColors()
                                          .colorText), //ebookTheme.themeMode().ratingBar,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Center(
                                child: Image.network(
                                  listOfCategory[i].photo_cat,
                                  height: 25.0.h,
                                  width: 25.0.w,
                                ),
                              ),
                            ],
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
            )));
  }
}
