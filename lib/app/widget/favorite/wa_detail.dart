import 'package:flutter/cupertino.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/model/stickerPack.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite.dart';


class WaDetail extends ChangeNotifier{

  bool favorite = false, loading = true;
  late int favorites;
  var waFav = WaFavorite();

  checkFav(int id) async {
    List list = await waFav.check({'id': id.toString()});
    print('me traer');
    print(id);
    print('wadetail');
    print(list);
    if (list.isNotEmpty) {
      setFav(true);
    }else{
      setFav(false);
    }
  }

  removeFavorite(int id, StickerPack ebookModel) async {
    waFav.remove({'id': id.toString(), 'item': ebookModel.toJson()});
     print('me traer');
    print(id);
    print('remove wa detail');
    print(waFav);
    checkFav(id);
  }

  addFavorite(int id, StickerPack ebookModel) async {
    await waFav.addFavorites({'id': id.toString(), 'item': ebookModel.toJson()});
    checkFav(id);
      print(id);
    print('add wa fav');
    print(waFav);
  
  }

  void setFav(value){
    favorite = value;
    notifyListeners();
  }

}