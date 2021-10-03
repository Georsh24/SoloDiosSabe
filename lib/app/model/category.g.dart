// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      cat_id: json['cat_id'] as int,
      photo_cat: json['photo_cat'] as String,
      name: json['name'] as String,
      status: json['status'] as int,
      color: json['color'] as String,
    )
      ..catId = json['catId'] as int
      ..photoCat = json['photoCat'] as String
      ..namE = json['namE'] as String
      ..statuS = json['statuS'] as int
      ..coloR = json['coloR'] as String;

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'cat_id': instance.cat_id,
      'photo_cat': instance.photo_cat,
      'name': instance.name,
      'status': instance.status,
      'color': instance.color,
      'catId': instance.catId,
      'photoCat': instance.photoCat,
      'namE': instance.namE,
      'statuS': instance.statuS,
      'coloR': instance.coloR,
    };
