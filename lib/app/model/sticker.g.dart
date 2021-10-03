// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      imagefile: json['imagefile'] as String,
      emojis: json['emojis'] as List<dynamic>,
    )
      ..imageFile = json['imageFile'] as String
      ..emoji = json['emoji'] as List<dynamic>;

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'imagefile': instance.imagefile,
      'emojis': instance.emojis,
      'imageFile': instance.imageFile,
      'emoji': instance.emoji,
    };
