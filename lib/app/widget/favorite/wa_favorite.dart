import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';

class WaFavorite {

  var path = '/data/user/0/com.stickerfun.stickerfun/app_flutter/wa_favorites.db';
  WaFavorite(){getPath();}

  getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
     path = directory.path + '/wa_favorites.db';
     print(path);
    
  }

  addFavorites(Map map) async {
    final database = ObjectDB(FileSystemStorage(path));
   // final database = ObjectDB(await getPath());
    //database.open();
    database.insert(map);
    await database.close();
  }

  Future<int> remove(Map map) async {
      final database = ObjectDB(FileSystemStorage(path));
    // final database = ObjectDB(await getPath());
    // database.open();
    int val = await database.remove(map);
    await database.close();
    return val;
  }

  Future<List> listAll() async {
    // final database = ObjectDB(await getPath());
    // database.open();
     final database = ObjectDB(FileSystemStorage(path));
    List list = await database.find({});
    // database.tidy();
    await database.close();
    return list;
  }

  Future<List> check(Map map) async {
      final database = ObjectDB(FileSystemStorage(path));
   // final database = ObjectDB(await getPath());
   // database.open();
    List check = await database.find(map);
    await database.close();
    return check;
  }
}