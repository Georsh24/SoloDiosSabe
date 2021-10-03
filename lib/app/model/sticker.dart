import 'package:json_annotation/json_annotation.dart';
part 'sticker.g.dart';

@JsonSerializable()
class Sticker {

  String imagefile;
  List emojis;

  Sticker({required this.imagefile, required this.emojis});

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);

  Map<String, dynamic> toJson() => _$StickerToJson(this);

  String get imageFile => imagefile;
  List get emoji => emojis;

  set imageFile(String imagefile){
    this.imagefile = imagefile;
  }

  set emoji(List emojis){
    this.emojis = emojis;
  }
}