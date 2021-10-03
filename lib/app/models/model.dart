class Model {
  String androidplaystorelink = '';
  List stickerPack;

  Model({required this.androidplaystorelink, required this.stickerPack});

  String get playStoreLink => androidplaystorelink;
  List get stickerPac => stickerPack;

  set playStore(String androidplaystorelink) {
    this.androidplaystorelink = androidplaystorelink;
  }

  set stickerPacks(List stickerPack) {
    this.stickerPack = stickerPack;
  }

  factory Model.formJson(Map<dynamic, dynamic> json) {
    return Model(
        androidplaystorelink: json['android_play_store_link'],
        stickerPack: json['sticker_packs']);
  }
}
