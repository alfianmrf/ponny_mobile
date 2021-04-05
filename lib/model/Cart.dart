import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/Coupon.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/model/OrderResult.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

import 'Address.dart';
import 'ProductPoin.dart';

class CartModel with ChangeNotifier{
  List<Cart> listCardOfitem=[];
  List<Product> listSample=[];
  List<Product> listUseSample=[];
  List<ProductPoin> listProductPoin=[];
  bool loadingCard = true;
  Coupon coupon;
  Summary summary;
  MapCost shipping;
  int CurentPoint =0;



  CartModel();

  Future<CartResult> addProductToCart(Product product, String token,VarianResult variant) async
  {
    CartResult result;
     int index;
     if(variant != null )index = listCardOfitem.indexWhere((element) =>
     element.product.id == product.id && element.variant == variant.varian);
     else index = listCardOfitem.indexWhere((element) =>
     element.product.id == product.id);

     var param=<String,dynamic>{};

     if (index < 0) {
       if(variant != null){
         param.addAll({"variant":variant.varian});
       }
       print(variant);
       param.addAll({
         "product_id": product.id,
         "qty": 1
       });
       print(param);
       final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
       // print(res.body);
       final jsonData =json.decode(res.body);
       result = CartResult(message: jsonData["message"],statusCode: res.statusCode);
       if (res.statusCode == 200) {
         // print(res.body);
         if(variant != null){
           param.addAll({"variant":variant.varian});
           listCardOfitem.add(Cart(jsonData["cart_id"], 1, product,variant.varian,variant.price));
         }else{
           listCardOfitem.add(Cart(jsonData["cart_id"], 1, product,null,product.base_discounted_price));
         }
         await getSummary(token);
         notifyListeners();
       }

     } else {
       int quantity= listCardOfitem.elementAt(index).quantity;
       param.addAll({
         "product_id": product.id,
         "qty": quantity + 1
       });
       if(variant != null){
         param.addAll({"variant":variant.varian});
       }
       print(json.encode(param));
       final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
       if (res.statusCode == 200) {
         listCardOfitem.elementAt(index).quantity = quantity+1;
         await getSummary(token);
         notifyListeners();
       }
       final jsonData =json.decode(res.body);
       result = CartResult(message: jsonData["message"],statusCode: res.statusCode);
     }
    return result;
 }

  Future<void> addSampleToCart(Product product, String token) async
  {
    int index = listUseSample.indexWhere((element) =>
    element.id == product.id);
    if (index < 0) {
      final res = await http.post(addSample+"/"+product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      // print(res.body);
      if (res.statusCode == 200) {
        // print(res.body);
        listUseSample.add(product);
        notifyListeners();
      }
    }
  }

  Future<void> addRedemToCart(ProductPoin product, String token) async
  {
    int index = listProductPoin.indexWhere((element) =>
    element.id == product.id);
    if (index < 0) {
      var param={
        "qty":1
      };
      final res = await http.post(rendemProduct+"/"+product.product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
      if (res.statusCode == 200) {
        // print(res.body);
        listProductPoin.add(product);
        notifyListeners();
      }
    }else{
      int quantity= listProductPoin.elementAt(index).qty;
      var param={
        "qty":quantity+1
      };
      final res = await http.post(rendemProduct+"/"+product.product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
      if (res.statusCode == 200) {
        // print(res.body);
        listProductPoin.elementAt(index).qty++;
        notifyListeners();
      }

    }
  }

  Future<void> RemoveProductToCart(Product product,String token, String variant) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id && element.variant == variant);
    // print(index);
    if(listCardOfitem.elementAt(index).quantity > 1){
      int quantity= listCardOfitem.elementAt(index).quantity;
      var param = <String,dynamic>{
        "product_id": product.id,
        "qty": quantity-1
      };
      if(variant != null){
        param.addAll({"variant":variant});
      }
      final res = await http.post(addtocart, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
      if (res.statusCode == 200) {
        listCardOfitem.elementAt(index).quantity--;
        await getSummary(token);
        notifyListeners();
      }

    }

  }

  Future<void> RemoveRedemToCart(ProductPoin product,String token) async
  {
    int index = listProductPoin.indexWhere((element) => element.id == product.id);
    if(listProductPoin.elementAt(index).qty > 1){
      int quantity= listProductPoin.elementAt(index).qty;
      var param = {
        "qty": quantity-1
      };
      final res = await http.post(rendemProduct+"/"+product.product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));
      if (res.statusCode == 200) {
        listProductPoin.elementAt(index).qty--;
        notifyListeners();
      }
    }
  }
  Future<void> DeleteProductSample(Product product,String token) async
  {
    final res = await http.get(removeProductSample+"/"+product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    // print(res.body);
    if (res.statusCode == 200) {
      int index = listUseSample.indexWhere((element) => element.id == product.id);
      listUseSample.removeAt(index);
      await getSummary(token);
      notifyListeners();
    }

  }

  Future<void> DeleteRendemProduct(ProductPoin product,String token) async
  {
    final res = await http.get(removePoinProduct+"/"+product.product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if (res.statusCode == 200) {
      int index = listProductPoin.indexWhere((element) => element.id == product.id);
      listProductPoin.removeAt(index);
      await getSummary(token);
      notifyListeners();
    }

  }

  Future<void> getCart(String token) async
  {
    try{
      final result = await http.get(preChekout, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      if(result.statusCode == 200){
        listCardOfitem=[];
        loadingCard=true;
        coupon = null;
        summary = null;
        shipping = null;
        listSample =[];
        listUseSample=[];
        listProductPoin=[];

        final responseJson = json.decode(result.body);

        for (Map item in responseJson["cart"]) {
          listCardOfitem.add(Cart.fromJson(item));
        }
        for (Map item in responseJson["sampleOfProducts"]) {
          listSample.add(Product.fromJson(item["product"]["availability"]));
        }


        for (Map item in responseJson["sampleProduct_used"]) {
          listUseSample.add(Product.fromJson(item["product"]["availability"]));
        }
        // print(responseJson["productPoint_used"]);
        for (Map item in responseJson["productPoint_used"]) {
          if(item["product"]!=null)
          listProductPoin.add(ProductPoin(item["id"], item["product_point"]!= null ? item["product_point"]["jml_point"]:null, item["product"]!=null?  Product.fromJson(item["product"]["availability"]) :null,item["qty"]));
        }
        summary = Summary.fromJson(responseJson["summary"]);
        loadingCard =false;
        notifyListeners();

      }

    }catch(err){
      print("error."+err.toString());
      notifyListeners();
    }

  }

  Future<void> DeleteProductToCart(int id,String token) async
  {
    final res = await http.get(removeCardUrl+"/"+id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if (res.statusCode == 200) {
      int index = listCardOfitem.indexWhere((element) => element.id == id);
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
      // print(responseJson);
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

  Future<OrderResult> Checkout(String token, Address useAddress,String method) async {
   var param;
   OrderResult result;
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
   final responseJson = json.decode(res.body);
   result= OrderResult.fromJson(responseJson);
   if (res.statusCode == 200) {
     // print(responseJson);
     listCardOfitem=[];
     notifyListeners();
     return result;
   }
   return result;
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

  int gettotalPoin(){
    int subtotal=0;
    for(ProductPoin item in listProductPoin){
      subtotal+=item.qty*item.jml_point;
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
  int id;
  int quantity;
  Product product;
  String variant;
  int price;

  Cart(this.id, this.quantity, this.product,this.variant,this.price);
  factory Cart.fromJson(Map<String, dynamic> parsedJson){
    int _id = parsedJson['id'];
    Product  _product = Product.fromJson(parsedJson["product"]["availability"]);
    int _quantity = parsedJson['quantity'];
    String _variant = parsedJson["variation"];
    int _price =parsedJson["price"];
    return Cart(_id, _quantity, _product,_variant,_price);
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

class CartResult{
  String message;
  int statusCode;
  CartResult({this.message,this.statusCode});
}
