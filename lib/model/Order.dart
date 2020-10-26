import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class OrderModel with ChangeNotifier{
  List<Order> unpaid;
  List<Order> paid;
  List<Order> on_delivery;
  List<Order> completed;
  bool loading=true;
  OrderModel();

  Future<void> getOrder(String token) async
  {
    print("get order");
    final res = await http.get(urlOrder, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});

    if (res.statusCode == 200) {
      unpaid=[];
      final responseJson = json.decode(res.body);
      for (Map item in responseJson["unpaid"]) {
        print(Order.fromJson(item).code);
        unpaid.add(Order.fromJson(item));
      }
      loading=false;
      notifyListeners();
    }

  }
}


class Order {
  int id;
  String code;
  String payment_type;
  int subtotal;
  int grand_total;
  int coupon_discount;
  Address user_order_address;
  MapCost shipping_info;
  Midtrans mitrans_val;
  int free_ongkir;
  List<OrderDetail> order_details;

  Order(
      this.id,
      this.code,
      this.payment_type,
      this.grand_total,
      this.subtotal,
      this.coupon_discount,
      this.user_order_address,
      this.shipping_info,
      this.mitrans_val,
      this.free_ongkir,
      this.order_details);

  factory Order.fromJson(Map<String, dynamic> parsedJson){
    List<OrderDetail> _order_details=[];
    Address _user_order_address = Address.fromJson(parsedJson["user_order_address"]);
    MapCost _shipping_info = MapCost.fromJson(parsedJson["shipping_info"]);
    Midtrans _mitrans_val = Midtrans.fromJson(parsedJson["mitrans_val"]);
    
    for(Map item in parsedJson["order_details"]){
      _order_details.add(OrderDetail.fromJson(item));
    }
    return Order(parsedJson["id"], parsedJson["code"], parsedJson["payment_type"], parsedJson["grand_total"],parsedJson["subtotal"], parsedJson["coupon_discount"], _user_order_address, _shipping_info, _mitrans_val, parsedJson["free_ongkir"], _order_details);
  }



}

class Midtrans{
  String payment_type;
  String mitrans_val;

  Midtrans(this.payment_type, this.mitrans_val);

  factory Midtrans.fromJson(Map<String, dynamic> parsedJson){
    String _va_numbers;
    if(parsedJson != null && parsedJson["payment_type"] == "bank_transfer"){
      for(Map item in parsedJson["va_numbers"]){
        _va_numbers= item["bank"].toString().toUpperCase()+" Virtual \nCode: "+item["va_number"];

      }
      return Midtrans(parsedJson["payment_type"],_va_numbers);
    }else if( parsedJson != null && parsedJson["payment_type"] == "cstore"){
      _va_numbers= parsedJson["store"].toString().toUpperCase()+"\nCode: "+parsedJson["payment_code"];
      return Midtrans(parsedJson["payment_type"],_va_numbers);
    }

    return null;
  }
}

class OrderDetail {
  int id;
  int quantity;
  int price;
  Product product;
  OrderDetail(this.id, this.quantity, this.product,this.price);
  factory OrderDetail.fromJson(Map<String, dynamic> parsedJson){
    return OrderDetail(parsedJson["id"],parsedJson["quantity"],Product.fromJson(parsedJson["product"]["availability"]),parsedJson["price"]);
  }
}


