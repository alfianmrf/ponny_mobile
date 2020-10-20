import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/Coupon.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class CartModel with ChangeNotifier{
  List<Cart> listCardOfitem=[];
  bool loadingCard = false;
  Coupon coupon;

  CartModel();

 Future<void> addProductToCart(Product product) async
 {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    print( product.id);
    print(index);
    if(index < 0){
      listCardOfitem.add(Cart(1, product));
    }else{
      listCardOfitem.elementAt(index).quantity++;
    }
    notifyListeners();
 }

  Future<void> RemoveProductToCart(Product product) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    print(index);
    if(listCardOfitem.elementAt(index).quantity > 1){
      listCardOfitem.elementAt(index).quantity--;
      notifyListeners();
    }

  }

  Future<void> DeleteProductToCart(Product product) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    listCardOfitem.removeAt(index);
    notifyListeners();
  }

  Future<bool> AppyCoupon(String code, String token) async {
    var param ={
      "code":code
    };
    final response = await http.post(applyCoupon,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" },body: json.encode(param));
    final responseJson = json.decode(response.body);
    print(responseJson);
    if(response.statusCode == 200){
      coupon = Coupon.fromJson(responseJson);
      notifyListeners();
    }

  }

 int getCountOfquantity(){
   int jml=0;
   for(Cart item in listCardOfitem){
     jml+=item.quantity;
   }
   return jml;
 }

 int getSubtotal(){
   int subtotal=0;
   for(Cart item in listCardOfitem){
     subtotal+=item.quantity*item.product.base_discounted_price;
   }
   return subtotal;
 }

  double getSumtotal(){
    double total=0;
    for(Cart item in listCardOfitem){
      total+=item.quantity*item.product.base_discounted_price;
    }
    if(coupon != null && coupon.coupon_id != null){
      if(coupon.type == "percent"){
        total -= total*(coupon.discount/100);
      }else{
        total -= coupon.discount;
      }
    }
    return total;
  }

  double getJmlDiskon(){
    double diskon=0;
    double total=0;
    for(Cart item in listCardOfitem){
      total+=item.quantity*item.product.base_discounted_price;
    }
    if(coupon != null && coupon.coupon_id != null){
      if(coupon.type == "percent"){
        diskon = (total*(coupon.discount/100));
      }else{
        diskon = double.parse(coupon.discount.toString());
      }
    }
    return diskon;
  }

}


class Cart{
  int quantity;
  Product product;
  Cart(this.quantity, this.product);

}