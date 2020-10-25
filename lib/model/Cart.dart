import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/Coupon.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

import 'Address.dart';

class CartModel with ChangeNotifier{
  List<Cart> listCardOfitem=[];
  bool loadingCard = false;
  Coupon coupon;
  Summary summary;
  MapCost shipping;


  CartModel();

 Future<void> addProductToCart(Product product, String token) async
   {
     int index = listCardOfitem.indexWhere((element) =>
     element.product.id == product.id);


     if (index < 0) {
       var param = {
         "product_id": product.id,
         "qty": 1
       };
       final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
       print(res.body);
       if (res.statusCode == 200) {
         print(res.body);
         listCardOfitem.add(Cart(1, product));
         await getSummary(token);
         notifyListeners();
       }
     } else {
       int quantity= listCardOfitem.elementAt(index).quantity;
       var param = {
         "product_id": product.id,
         "qty": quantity+1
       };
       final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
       if (res.statusCode == 200) {
         listCardOfitem.elementAt(index).quantity = quantity+1;
         await getSummary(token);
         notifyListeners();
       }

     }


 }

  Future<void> RemoveProductToCart(Product product,String token) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    print(index);
    if(listCardOfitem.elementAt(index).quantity > 1){
      int quantity= listCardOfitem.elementAt(index).quantity;
      var param = {
        "product_id": product.id,
        "qty": quantity-1
      };
      final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
      if (res.statusCode == 200) {
        listCardOfitem.elementAt(index).quantity--;
        await getSummary(token);
        notifyListeners();
      }

    }

  }

  Future<void> getCart(String token) async
  {


    try{
      final result = await http.get(listCarturl, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      if(result.statusCode == 200){
        listCardOfitem=[];
        coupon = null;
        summary = null;
        shipping = null;
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["data"]) {
          listCardOfitem.add(Cart.fromJson(item));
        }
      }
      await getSummary(token);
      notifyListeners();
    }catch(err){
      print("error."+err.toString());
      notifyListeners();
    }

  }

  Future<void> DeleteProductToCart(Product product,String token) async
  {
    final res = await http.get(removeCardUrl+"/"+product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if (res.statusCode == 200) {
      int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
      listCardOfitem.removeAt(index);
      await getSummary(token);
      notifyListeners();
    }

  }

  Future<void> getSummary(String token) async
  {
    String _coupon;
    String _courier;
    var param;
    if(coupon != null){
      _coupon =coupon.code;
    }


    if(shipping != null){
      _courier = json.encode(shipping.toJson());
    }

    if(_courier != null && _coupon != null){
      param = {
        "courier": _courier,
        "coupon_code":_coupon
      };
    }else if(_courier != null){
      param = {
        "courier": _courier
      };
    }else if(_coupon != null){
      param = {
        "coupon_code":_coupon
      };
    }

    print(param);
    final res = await http.post(cartSummary, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
    print(res.body);
    if (res.statusCode == 200) {
      final responseJson = json.decode(res.body);
      print(responseJson);
      summary = Summary.fromJson(responseJson);
      notifyListeners();
    }

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
      await getSummary(token);
      notifyListeners();
    }

  }

  Future<bool> AppyShipping(MapCost cost,String token) async {
    shipping = cost;
    await getSummary(token);
    notifyListeners();
  }

  Future<void> DefaultCart() async
  {
    listCardOfitem=[];
    coupon=null;
    summary =null;
    shipping =null;
    notifyListeners();
  }

  Future<void> RemoveCoupon() async
  {
    coupon=null;
    notifyListeners();
  }

  Future<void> RemoveShipping() async
  {
    shipping =null;
    notifyListeners();
  }

  Future<bool> Checkout(String token, Address useAddress,String method) async {
   var param;
   if(coupon != null){
     param={
       "address_id":useAddress.id,
       "courier":  json.encode(shipping.toJson()),
       "coupon_code":coupon.code,
       "payment_code":method
     };
   }else{
     param={
       "address_id":useAddress.id,
       "courier":  json.encode(shipping.toJson()),
       "payment_code":method
     };
   }
   final res = await http.post(cartChekouturl, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
   print(res.body);
   if (res.statusCode == 200) {
     final responseJson = json.decode(res.body);
     print(responseJson);
     listCardOfitem=[];
     notifyListeners();
     return true;
   }
   return false;
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
  factory Cart.fromJson(Map<String, dynamic> parsedJson){
    Product  _product = Product.fromJson(parsedJson);
    int _quantity = parsedJson['cart']['quantity'];
    return Cart(_quantity, _product);
  }

}

class Summary{
  String subtotal;
  String free_shipping;
  String discount;
  String shipping;
  String total;
  int earnPoint;

  Summary(this.subtotal, this.free_shipping, this.discount, this.shipping,
      this.total, this.earnPoint);

  factory Summary.fromJson(Map<String, dynamic> parsedJson){
    return Summary(parsedJson["subtotal"], parsedJson["free_shipping"], parsedJson["discount"], parsedJson["shipping"], parsedJson["total"], parsedJson["earnPoint"]);
  }
}