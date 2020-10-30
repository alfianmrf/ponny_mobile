import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class WishModel with ChangeNotifier {
  int countwishlist=0;
  bool loading=true;

  WishModel();

  Future<void> getCountWislist(String token) async
  {
    try{
      final result = await http.get(countOfwishlist, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      if(result.statusCode == 200){
        final responseJson = json.decode(result.body);
        countwishlist = responseJson["jml_wishlish"];
        loading =false;
        notifyListeners();
      }

    }catch(err){
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
  Wish(this.id,this.product);

  factory Wish.fromJson(Map<String, dynamic> parsedJson){
    Product  _product = Product.fromJson(parsedJson["product"]["availability"]);
    return Wish(parsedJson["id"], _product);
  }
}
