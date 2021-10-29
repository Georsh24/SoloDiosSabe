class WaModel {
  String androidplaystorelink;
  List stickerpack;

  WaModel({required this.androidplaystorelink, required this.stickerpack});

  String get playStore => androidplaystorelink;
  List get stickerPack => stickerpack;

  set androidPlayStore(String androidplaystorelink) {
    this.androidplaystorelink = androidplaystorelink;
  }

  set stickerPacks(List stickerpack) {
    this.stickerpack = stickerpack;
  }

  factory WaModel.fromJson(Map<dynamic, dynamic> json) {
    return WaModel(
        androidplaystorelink: json['android_play_store_link'],
        stickerpack: json['sticker_packs']);
  }
}
