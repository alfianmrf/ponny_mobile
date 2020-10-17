import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/util/globalUrl.dart';

class ProductModel with ChangeNotifier{
  List<Product> Best_sell =[];
  bool loadingBestSale =true;

  ProductModel(){
    getBestSell();
  }

  Future<void> getBestSell() async {
    try{
      final result = await http.get(best_sale);
      if(result.statusCode == 200){
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["data"]) {
          Best_sell.add(Product.fromJson(item));
        }
      }
      loadingBestSale=false;
      notifyListeners();
    }catch(err){
      print("error."+err.toString());
      notifyListeners();
    }
  }



}
class Product{
  String name;
  List<String> photos;
  String thumbnail_image;
  String featured_image;
  String flash_deal_image;
  int base_price;
  int base_discounted_price;
  int todays_deal;
  int featured;
  String unit;
  int discount;
  String discount_type;
  double rating;
  int sales;
  Brand brand;
  ProductFlashDeal is_flash_deal;
  int review_count;



  Product(this.name, this.photos, this.thumbnail_image, this.featured_image,
      this.flash_deal_image, this.base_price, this.base_discounted_price,
      this.todays_deal, this.featured, this.unit, this.discount,
      this.discount_type, this.rating, this.sales,this.brand,this.is_flash_deal,this.review_count);

  factory Product.fromJson(Map<String, dynamic> parsedJson){
    List<String> _tmp=[];
    for(String item in parsedJson['photos']){
      _tmp.add(item);
    }
    return Product(
        parsedJson["name"],
        _tmp,
        parsedJson["thumbnail_image"],
        parsedJson["featured_image"],
        parsedJson["flash_deal_image"],
        parsedJson["base_price"],
        parsedJson["base_discounted_price"],
        parsedJson["todays_deal"],
        parsedJson["featured"],
        parsedJson["unit"],
        parsedJson["discount"],
        parsedJson["discount_type"],
        double.parse(parsedJson["rating"].toString()),
        parsedJson["sales"],
        Brand.fromJson(parsedJson["brand"]),
        parsedJson["is_flash_deal"] != null ? ProductFlashDeal.fromJson(parsedJson["is_flash_deal"]): null,
        parsedJson['review_count']
    );
  }
}

