import 'package:ponny/model/Brand.dart';

import 'Product.dart';

class LocalPrideResult{
  String banner;
  List<Brand> brands=[];
  LocalPrideResult({this.banner,this.brands});

  LocalPrideResult.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] != null ? json['banner']['photo'] : null;
    if (json['brand'] != null) {
      brands = new List<Brand>();
      json['brand'].forEach((v) {
        brands.add(new Brand.fromJson(v['brand']));
      });
    }
  }

}