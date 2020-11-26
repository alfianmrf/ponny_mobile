import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/util/globalUrl.dart';

import 'FlashDeal.dart';

class ProductModel with ChangeNotifier {
  List<Product> Best_sell = [];
  List<Product> PhoebeChoices = [];
  List<Product> Recomendasi = [];
  List<Product> Sample = [];
  List<Product> news =[];
  bool loadingBestSale = true;
  bool loadingPhobe = true;
  bool loadingRekomendasi = true;
  bool loadingNews =true;
  FlashDetail flashsale;


  ProductModel() {
    getBestSell();
    getPhoebe();
    getRekomendasi();
    getFlashSale();
    getNews();
  }

  Future<void> getBestSell() async {
    try {
      final result = await http.get(best_sale);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        if (responseJson != null)
          for (Map item in responseJson["data"]) {
            Best_sell.add(Product.fromJson(item));
          }
      }
      loadingBestSale = false;
      notifyListeners();
    } catch (err) {
      loadingBestSale = false;
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getFlashSale() async {
    try {
      final result = await http.get(flashdealUrl);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        // print(responseJson);
        if (responseJson["status"]) {
          flashsale = FlashDetail.fromJson(responseJson);
          notifyListeners();
        }
      }
    } catch (err) {
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getPhoebe() async {
    try {
      final result = await http.get(phobe);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["data"]) {
          PhoebeChoices.add(Product.fromJson(item));
        }
      }
      loadingPhobe = false;
      notifyListeners();
    } catch (err) {
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getRekomendasi() async {
    try {
      final result = await http.get(rekomendasiProduk);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["data"]) {
          Recomendasi.add(Product.fromJson(item));
        }
      }
      loadingRekomendasi = false;
      notifyListeners();
    } catch (err) {
      loadingRekomendasi = false;
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getNews() async {
    try {
      final result = await http.get(newProduct);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        for (Map item in responseJson) {
          news.add(Product.fromJson(item['availability']));
        }
      }
      loadingNews = false;
      notifyListeners();
    } catch (err) {
      loadingNews = false;
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<SearchResult> searchProduct(String url,param) async {
    SearchResult resultSearch =null;
    // try {
    print(json.encode(param));
      print(param);
      final result = await http.post(url,headers: { HttpHeaders.contentTypeHeader: 'application/json'} ,body: json.encode(param));
      print(result.body);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);

        List<Product> _tmp=[];
        for (Map item in responseJson["data"]) {
          _tmp.add(Product.fromJson(item));
        }

        print(_tmp.length);

        return SearchResult(products: _tmp,nextUrl: responseJson["links"]["next"],total: responseJson["meta"]["total"]);
      }

    // } catch (err) {
    //   print("error." + err.toString());
    // }
    return resultSearch;
  }



}
class Product{
  int id;
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
  String nomer_bpom;
  String description;
  String penggunaan;
  String bahan_aktif;
  String home_discounted_price;
  List<Varian> varian;
  String komposisi;
  String slug;




  Product(
      this.id,
      this.name,
      this.photos,
      this.thumbnail_image,
      this.featured_image,
      this.flash_deal_image,
      this.base_price,
      this.base_discounted_price,
      this.todays_deal,
      this.featured,
      this.unit,
      this.discount,
      this.discount_type,
      this.rating,
      this.sales,
      this.brand,
      this.is_flash_deal,
      this.review_count,
      this.nomer_bpom,
      this.description,
      this.penggunaan,
      this.bahan_aktif,
      this.home_discounted_price,
      this.varian,
      this.komposisi,
      this.slug
      );



  factory Product.fromJson(Map<String, dynamic> parsedJson){
    List<String> _tmp=[];
    List<Varian> _var=[];

    if(parsedJson["photos"] != null)
    for(String item in parsedJson['photos']){
      _tmp.add(item);
    }

    for(Map item in parsedJson['varian']){
      _var.add(Varian.fromJson(item));
    }
    print(parsedJson['varian']);
    return Product(
        parsedJson["id"],
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
        parsedJson['review_count'],
        parsedJson["nomer_bpom"],
        parsedJson["description"],
        parsedJson["penggunaan"],
        parsedJson["bahan_aktif"],
        parsedJson["home_discounted_price"],
        _var,
        parsedJson['komposisi'],
        parsedJson["slug"]
    );
  }
}

class Varian {
  String attribute_id;
  String atribut_name;
  List<String> values;

  Varian(this.attribute_id, this.atribut_name, this.values);

  factory Varian.fromJson(Map<String, dynamic> parsedJson){
    List<String> _tmp=[];
    for(String item in parsedJson['values']){
      _tmp.add(item);
    }
    return Varian(parsedJson["attribute_id"], parsedJson["atribut_name"], _tmp);
  }


}
class SearchResult{
  List<Product> products;
  String nextUrl;
  int total;
  SearchResult({this.products,this.nextUrl,this.total});

}

