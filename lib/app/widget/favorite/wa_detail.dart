import 'package:flutter/cupertino.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite.dart';




class WaDetail extends ChangeNotifier{

  bool favorite = false, loading = true;
  int favorites = 0;
  var waFav = WaFavorite();

  checkFav(int id) async {
    List? list = await waFav.check({'id': id });
    if (list.isNotEmpty) {
      setFav(true);
    }else{
      setFav(false);
    }
  }

  // removeFavorite(int id) async {
  //   waFav.remove({'id': id});
  //   checkFav(id);
  // }
  removeFavorite(int id) async {
    waFav.remove({'id': id}).then((v) {
      print(v);
      checkFav(v);
    });
  }

  addFavorite(int id, StickerPack ebookModel) async {
    await waFav.addFavorites({'id': id, 'item': ebookModel.toJson()});
    checkFav(id);
  }

  void setFav(value){
    favorite = value;
    notifyListeners();
  }

}