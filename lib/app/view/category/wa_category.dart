import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/category.dart';
import 'package:flutter_stickers_internet/app/model/wa_model_cat.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_category/wa_all_category.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker_by_cat/wa_sticker_bycat.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:http/http.dart' as http;

class WaCategory extends StatefulWidget {
  @override
  _WaCategoryState createState() => _WaCategoryState();
}

class _WaCategoryState extends State<WaCategory> {
  List<Category> categories = [];
  bool loading = true;

  Future<void> getCategory() async {
    var response = await http.get(
        Uri.parse(
            ApiConstant.BASE_URL + ApiConstant.JSON + ApiConstant.CATEGORY),
        headers: {"Accept": "application/json"});
    setState(() {
      Map mapResult = jsonDecode(response.body);
      WaModelCat wmc = WaModelCat.fromJson(mapResult);
      for (Map<String, dynamic> cate in wmc.category) {
        categories.add(Category(
            cat_id: cate['cat_id'],
            photo_cat: cate['photo_cat'],
            name: cate['name'],
            status: cate['status'],
            color: cate['color']));
      }
    });
    loading = false;
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ))
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Category stickers',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Theme.of(context).textTheme.bodyText1!.color,
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
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                      onTap: () {
                        pushPageNoAnim(context, WaAllCategory());
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            pushPage(
                                context,
                                WaAllStickerByCat(
                                  id: categories[index].cat_id,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width * 0.25,
                                    height: size.height * 0.115,
                                    margin: EdgeInsets.all(0.2),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: categories[index].color == ""
                                          ? getColorFromHex(
                                              GlobalColors().colorWhite)
                                          : getColorFromHex(
                                              categories[index].color),
                                      boxShadow: [
                                        BoxShadow(
                                          color: categories[index].color == ""
                                              ? getColorFromHex(
                                                  GlobalColors().colorWhite)
                                              : getColorFromHex(
                                                  categories[index].color),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.2,
                                        )
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: categories[index].photo_cat,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${categories[index].name}',
                                      // style: TextStyle(color: getColorFromHex(GlobalColors().searchIconColor), //ebookTheme.themeMode().ratingBar,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 16),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
