class WaModelCat {
  List category;

  WaModelCat({required this.category});

  List get categoY => category;

  set categorY(List categorY) {
    this.category = categoY;
  }

  factory WaModelCat.fromJson(Map<dynamic, dynamic> json) {
    return WaModelCat(category: json['category']);
  }
}
