import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class WishModel with ChangeNotifier {
  int countwishlist=0;
  bool loading=true;
  List<WishRaw> rawlist =[];
  bool success = false;

  Future<void> getCountWislist(String token) async
  {
    try{
      final result = await http.get(countOfwishlist, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      if(result.statusCode == 200){
        final responseJson = json.decode(result.body);
        countwishlist = responseJson["jml_wishlish"];
        if(responseJson['data'] != null){
          rawlist =[];
          for(Map item in responseJson['data']){
            rawlist.add(WishRaw.fromJson(item));
          }
        }
        loading =false;
        notifyListeners();
      }

    }catch(err){
      print("GET COUNT WISHLIST");
      print("error."+err.toString());
    }

  }

  Future<bool> addProductToWish(Product product, String token) async
  {
    final res = await http.get(addToWishlist+"/"+product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if (res.statusCode == 200) {
      await getCountWislist(token);
      return true;
    }
    return false;
  }

  Future<bool> removeProductFromWish(Product product, String token) async
  {
    final res = await http.get(removeToWishlist+"/"+product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if (res.statusCode == 200) {
      await getCountWislist(token);
      return true;
    }
    return false;
  }
}



class Wish{
  int id;
  Product product;
  List stocks;

  Wish(this.id,this.product,this.stocks);

  factory Wish.fromJson(Map<String, dynamic> parsedJson){
    Product  _product =  Product.fromJson(parsedJson["product"]["availability"]);
    return Wish(parsedJson["id"], _product, parsedJson["product"]["stocks"]);
  }
}

class WishRaw {
  int id;
  int userId;
  int productId;
  String createdAt;
  String updatedAt;

  WishRaw(
      {this.id, this.userId, this.productId, this.createdAt, this.updatedAt});

  WishRaw.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

