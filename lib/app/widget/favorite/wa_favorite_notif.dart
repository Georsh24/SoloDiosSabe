import 'package:flutter/cupertino.dart';
import 'package:flutter_stickers_internet/app/widget/favorite/wa_favorite.dart';


class WaFavoriteNotif extends ChangeNotifier{

   List list =[]; 
  bool loading = true;
  var dbFavorite = WaFavorite();

  getEbooksFavorites() async{
    setLoading(true);
    list.clear();
    List listAll = await dbFavorite.listAll();
    list.addAll(listAll);
    setLoading(false);
  }

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  setList(value){
    list = value;
    notifyListeners();
  }

  List getList(){
    return list;
  }
}