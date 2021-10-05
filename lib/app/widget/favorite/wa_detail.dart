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
    print ('check fav');
    print(checkFav(id));
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
      print('remove to favorito wa detail');
      print(id);
      print('variable v');
      print(v);
      print('metodo remove');
      print(removeFavorite(id));
      checkFav(v);
    });
  }

  addFavorite(int id,) async {
    await waFav.addFavorites({'id': id, });
    print('add favorito del wall detail');
    print(id);
    print ('metodo add favorites wadetail');
    print(addFavorite(id));
    checkFav(id);
  }

  void setFav(value){
    favorite = value;
    print('Favorito de wa detail');
    print(favorite);
    notifyListeners();
  }

}