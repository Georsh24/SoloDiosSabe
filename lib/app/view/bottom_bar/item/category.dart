import 'dart:convert';
import 'package:flutter_stickers_internet/app/controller/api/api_constant.dart';
import 'package:flutter_stickers_internet/app/model/category.dart';
import 'package:flutter_stickers_internet/app/model/wa_model_cat.dart';
import 'package:flutter_stickers_internet/app/routers/wa_route.dart';
import 'package:flutter_stickers_internet/app/view/all_sticker_by_cat/wa_sticker_bycat.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/flutter_meedu.dart' as medu;

import 'package:http/http.dart' as http;

class CategoryItem extends StatefulWidget {
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {

  List<Category> listOfCategory = [];
  bool isLoading = true;

  Future<void> getAllCategory() async {
    var response = await http.get(Uri.parse(ApiConstant.BASE_URL+ApiConstant.JSON+ApiConstant.CATEGORY),
        headers: {'Accept': 'application/json'});
    setState(() {
      Map<String, dynamic> map = jsonDecode(response.body);
      WaModelCat waModelCat = WaModelCat.fromJson(map);

      for(Map<String, dynamic> cate in waModelCat.category){
        listOfCategory.add(Category(
            cat_id: cate['cat_id'],
            photo_cat: cate['photo_cat'],
            name: cate['name'],
            status: cate['status'],
            color: cate['color']));
      }
    });
    isLoading = false;
    print("cek ${response.body}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
     final logoimg = Theme.of(context).brightness == Brightness.dark
        ? 'assets/logoblack.png'
        : 'assets/logowhite.png';
    final size = MediaQuery.of(context).size;
    return Material(
        child: Scaffold(
           appBar: AppBar(
          toolbarHeight: size.height * 0.10,
          automaticallyImplyLeading: false,
         
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
            body: Column(
              children: [
                SizedBox(height: 15,),
                Container(
                  child: isLoading ? Center(child: Container(child: CircularProgressIndicator(strokeWidth: 1.5,),))
                      : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 8.0 / 9.0,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0
                      ),
                      itemCount: listOfCategory.length,
                      itemBuilder: (ctx, i){
                        return Hero(
                          tag: listOfCategory[i],
                          child: GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: listOfCategory[i].color == "" ? getColorFromHex(GlobalColors().bgSticker) : getColorFromHex(listOfCategory[i].color),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '${listOfCategory[i].name}',
                                      style: TextStyle(color: getColorFromHex(GlobalColors().colorText), //ebookTheme.themeMode().ratingBar,
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
                            onTap: (){
                              pushPage(context, WaAllStickerByCat(id: listOfCategory[i].cat_id,));
                            },
                          ),
                        );
                      }
                  ),
                ),
              ],
            )
        )
    );
  }
}
