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
  List<Product> Local_product = [];
  List<Product> Best_sell = [];
  List<Product> PhoebeChoices = [];
  List<Product> Recomendasi = [];
  List<Product> Recom = [];
  List<Product> Sample = [];
  List<Product> news =[];
  bool loadingLocalProduct = true;
  bool loadingBestSale = true;
  bool loadingPhobe = true;
  bool loadingRekomendasi = true;
  bool loadingRecom = true;
  bool loadingNews =true;
  FlashDetail flashsale;


  ProductModel() {
    getLocalProduct();
    getBestSell();
    getPhoebe();
    getRekomendasi();
    getRecom();
    getFlashSale();
    getNews();
  }

  Future<void> getLocalProduct() async {
    loadingLocalProduct = false;
    try {
      final result = await http.get(localprideUrl);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        if (responseJson["products"] != null)
          for (Map item in responseJson["products"]) {
            Local_product.add(Product.fromJson(item));
          }
      }
      loadingLocalProduct = false;
      notifyListeners();
    } catch (err) {
      loadingLocalProduct = false;
      print("Get Local Product");
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getBestSell() async {
    loadingBestSale = false;
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
      print("Get Best Sell");
      print("error." + err.toString());
      notifyListeners();
    }
  }


  Future<void> getFlashSale() async {
    try {
      flashsale = null;
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
      print("FLASH SALE");
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
      print('Get Phoebe');
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getRekomendasi() async {
    try {
      final result = await http.get(rekomendasiProduk);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["products"]["data"]) {
          Recomendasi.add(Product.fromJson(item));
        }
      }
      loadingRekomendasi = false;
      notifyListeners();
    } catch (err) {
      loadingRekomendasi = false;
      print("Get Rekomendasi");
      print("error." + err.toString());
      notifyListeners();
    }
  }

  Future<void> getRecom() async {
    try {
      final result = await http.get(recomProduct);
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["products"][0]["data"]) {
          Recom.add(Product.fromJson(item));
        }
      }
      loadingRecom = false;
      notifyListeners();
    } catch (err) {
      loadingRecom = false;
      print("Get Recom");
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
      print("Get News");
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

        return SearchResult(products: _tmp,nextUrl: responseJson["links"]["next"],total: responseJson["meta"]["total"], meta: Meta.fromJson(responseJson["meta"]));
      }

    // } catch (err) {
    //   print("error." + err.toString());
    // }
    return resultSearch;
  }
  Future<VarianResult> getValueVariant(param) async {
    VarianResult result;
    print("PARAM: "+json.encode(param));
    try {
      final result = await http.post(varianPriceUrl, headers: { HttpHeaders.contentTypeHeader: 'application/json'},body: json.encode(param));
      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        print("response Variant"+responseJson.toString());
        return VarianResult.fromJson(responseJson);
      }
    } catch (err) {
      print("Get Value Variant");
      print("error." + err.toString());

    }
    return result;
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
  String home_price;
  List<Varian> varian;
  String komposisi;
  String slug;
  int currentStock;
  bool is_shown;



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
      this.home_price,
      this.varian,
      this.komposisi,
      this.slug,
      this.currentStock,
      this.is_shown
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
        parsedJson["base_price"].round(),
        parsedJson["base_discounted_price"].round(),
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
        parsedJson["home_price"],
        _var,
        parsedJson['komposisi'],
        parsedJson["slug"],
        parsedJson["current_stock"],
        parsedJson["is_shown"]
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
  Meta meta;
  SearchResult({this.products,this.nextUrl,this.total,this.meta});

}
class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class VarianResult {
  int productId;
  String varian;
  int price;
  int stock_quantity;
  int base_price;
  String gambar;

  VarianResult({this.productId, this.varian, this.price, this.stock_quantity,this.base_price,this.gambar});

  VarianResult.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    varian = json['varian'];
    price = json['price'];
    stock_quantity = json['stock_quantity'] != null ? json['stock_quantity'] : 0;
    base_price = json["base_price"];
    gambar = json["gambar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['varian_id'] = this.varian;
    data['price'] = this.price;
    data['quantity'] = this.stock_quantity;
    return data;
  }
}



