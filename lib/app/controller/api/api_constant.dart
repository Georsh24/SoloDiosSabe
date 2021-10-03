import 'package:flutter/services.dart';

class ApiConstant{

  static const MethodChannel methodChannel = const MethodChannel('com.viztushar.flutter.flutter_stickers_internet/sharedata');
  //Change this base url with yours
  static const String BASE_URL = "http://admin.stickerfun.io/";

  //DON'T CHANGE BELOW
  static const String JSON = "api.php?";
  static const String HOME = "home";
  static const String SLIDER = "slider";
  static const String PACKAGE = "package";
  static const String REGISTER = "action/register.php?";
  static const String CATEGORY = "category";
  static const String BYCATEGORY = "sticker_by_cat=";
  static const String SEARCH = "search=";
}