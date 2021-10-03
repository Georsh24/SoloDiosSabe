import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {

  @JsonKey(name: 'cat_id')
  int cat_id;
  @JsonKey(name: 'photo_cat')
  String photo_cat;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'color')
  String color;

  Category({required this.cat_id, required this.photo_cat, required this.name, required this.status, required this.color});

  factory Category.fromJson(Map<String, dynamic> json)=>_$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  int get catId => cat_id;
  String get photoCat => photo_cat;
  String get namE => name;
  int get statuS => status;
  String get coloR => color;

  set catId(int catId){
    this.cat_id = catId;
  }
  set photoCat(String photoCat){
    this.photo_cat = photoCat;
  }
  set namE(String namE){
    this.name = namE;
  }
  set statuS(int statuS){
    this.status = statuS;
  }
  set coloR(String coloR){
    this.color = coloR;
  }
}