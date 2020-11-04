import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/model/ManualInfo.dart';
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
      print(res.body);
      final responseJson = json.decode(res.body);
      for (Map item in responseJson["unpaid"]) {
        print(Order.fromJson(item).code);
        unpaid.add(Order.fromJson(item));
      }

    }
    loading=false;
    notifyListeners();

  }

  Future<ManualInfo> getManualpembayaran(String token,String order_id) async {

    final res = await http.get(paymentInfo+"/"+order_id, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    ManualInfo result;
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      result = ManualInfo.fromJson(responseJson);
    }
    return result;
  }

}


class Order {
  int id;
  String code;
  String date;
  String payment_type;
  String payment_status;
  int subtotal;
  int grand_total;
  int coupon_discount;
  Address user_order_address;
  MapCost shipping_info;
  Midtrans mitrans_val;
  int free_ongkir;
  List<OrderDetail> order_details;
  List<OrderDetailSample> orderDetailSample;
  List<OrderDetailPoint> orderDetailPoint;
  StatusOrder status;
  StatusOrder payment;
  String typePayment;

  Order(
      this.id,
      this.code,
      this.date,
      this.payment_type,
      this.payment_status,
      this.grand_total,
      this.subtotal,
      this.coupon_discount,
      this.user_order_address,
      this.shipping_info,
      this.mitrans_val,
      this.free_ongkir,
      this.order_details,
      this.orderDetailSample,
      this.orderDetailPoint,
      this.status,
      this.payment,
      this.typePayment
      );

  factory Order.fromJson(Map<String, dynamic> parsedJson){
    List<OrderDetail> _order_details=[];
    Address _user_order_address = Address.fromJson(parsedJson["user_order_address"]);
    MapCost _shipping_info = MapCost.fromJson(parsedJson["shipping_info"]);
    Midtrans _mitrans_val = Midtrans.fromJson(parsedJson["mitrans_val"]);
    List<OrderDetailSample> _orderDetailSample=[];
    List<OrderDetailPoint> _orderDetailPoint=[];
    StatusOrder _status = StatusOrder.fromJson(parsedJson["statusOrder"]);
    StatusOrder _payment= StatusOrder.fromJson(parsedJson["typePayment"]);
    
    for(Map item in parsedJson["orderDetails"]){
      _order_details.add(OrderDetail.fromJson(item));
    }

    for(Map item in parsedJson["orderDetailSample"]){
      _orderDetailSample.add(OrderDetailSample.fromJson(item));
    }
    for(Map item in parsedJson["orderDetailPoint"]){
      _orderDetailPoint.add(OrderDetailPoint.fromJson(item));
    }
    return Order(parsedJson["id"],
        parsedJson["code"],
        parsedJson["date"],
        parsedJson["payment_type"],
        parsedJson["payment_status"],
        parsedJson["grand_total"],
        parsedJson["subtotal"],
        parsedJson["coupon_discount"],
        _user_order_address,
        _shipping_info,
        _mitrans_val,
        parsedJson["free_ongkir"],
        _order_details,
      _orderDetailSample,
      _orderDetailPoint,
      _status,
      _payment,
        parsedJson["typePayment"]["param_2"]
    );
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
    }else if( parsedJson != null && parsedJson["payment_type"] == "echannel"){
      _va_numbers= "Mandiri Bill Payment"+"\nBill key: "+parsedJson["bill_key"]+"\nBiller Code: "+parsedJson["biller_code"];
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

class OrderDetailSample  {
  int id;
  int quantity;
  Product product;
  OrderDetailSample (this.id, this.quantity, this.product);
  factory OrderDetailSample.fromJson(Map<String, dynamic> parsedJson){
    return OrderDetailSample(parsedJson["id"],parsedJson["quantity"],Product.fromJson(parsedJson["product"]["availability"]));
  }
}

class OrderDetailPoint  {
  int id;
  int quantity;
  int jml_point;
  Product product;
  OrderDetailPoint (this.id, this.quantity, this.product,this.jml_point);
  factory OrderDetailPoint.fromJson(Map<String, dynamic> parsedJson){
    return OrderDetailPoint(parsedJson["id"],parsedJson["quantity"],Product.fromJson(parsedJson["product"]["availability"]),parsedJson["log_product_point"]["jml_point"]);
  }
}

class StatusOrder {
  int _id;
  String _param1;
  String _param2;
  String _param3;
  Null _param4;
  String _varId;
  int _isDeleted;

  StatusOrder(
      {int id,
        String param1,
        String param2,
        String param3,
        Null param4,
        String varId,
        int isDeleted}) {
    this._id = id;
    this._param1 = param1;
    this._param2 = param2;
    this._param3 = param3;
    this._param4 = param4;
    this._varId = varId;
    this._isDeleted = isDeleted;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get param1 => _param1;
  set param1(String param1) => _param1 = param1;
  String get param2 => _param2;
  set param2(String param2) => _param2 = param2;
  String get param3 => _param3;
  set param3(String param3) => _param3 = param3;
  Null get param4 => _param4;
  set param4(Null param4) => _param4 = param4;
  String get varId => _varId;
  set varId(String varId) => _varId = varId;
  int get isDeleted => _isDeleted;
  set isDeleted(int isDeleted) => _isDeleted = isDeleted;

  StatusOrder.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _param1 = json['param_1'];
    _param2 = json['param_2'];
    _param3 = json['param_3'];
    _param4 = json['param_4'];
    _varId = json['var_id'];
    _isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['param_1'] = this._param1;
    data['param_2'] = this._param2;
    data['param_3'] = this._param3;
    data['param_4'] = this._param4;
    data['var_id'] = this._varId;
    data['is_deleted'] = this._isDeleted;
    return data;
  }
}




