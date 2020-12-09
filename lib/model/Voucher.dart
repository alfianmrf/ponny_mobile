import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/OrderResult.dart';
import 'package:ponny/util/globalUrl.dart';

class VoucherModel with ChangeNotifier{
  Voucher voucher;
  Future<bool> getVoucher() async {
    notifyListeners();
    final res = await http.get(voucherUrl);
    bool result = false;
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      print(responseJson);
      voucher = Voucher.fromJson(responseJson);
      notifyListeners();
    }
    return result;
  }

  Future<OrderResult> checkOut(String token,param) async {
    final res = await http.post(voucherCheckout, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
    print(res.statusCode);
    OrderResult result;
    if(res.statusCode == 200){
      final _w = json.decode(res.body);
      result = OrderResult.fromJson(_w);
    }
    return result;
  }

  Future<ResultOrderVoucher> getRiwayat(String url,String token) async {
    final res = await http.post(url, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    ResultOrderVoucher result;
    List<Order> orders=[];
    String nextUrl;
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      for (Map item in responseJson["data"]) {
        orders.add(Order.fromJson(item));
      }
      nextUrl = responseJson["pagination"]["next_page_url"];
      result = ResultOrderVoucher(orders,nextUrl);
    }
    return result;
  }

  Future<bool> incall(String token,param) async {
    final res = await http.post(inCallconsultation, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
    bool result =false;
    print(json.encode(param));
    print(res.statusCode);
    if(res.statusCode == 200){
      result =true;
    }
    return result;
  }

  Future<bool> incallStatus(String token,param) async {
    final res = await http.post(updateDuration, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
    bool result =false;
    print(json.encode(param));
    print(res.statusCode);
    if(res.statusCode == 200){
      result =true;
    }
    return result;
  }

  Future<ResultVoucher> getListVoucher(String url,String token) async {
    final res = await http.post(url, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    ResultVoucher result;
    List<OrderDetailVoucher> vouchers=[];
    String nextUrl;
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      for (Map item in responseJson["data"]) {
        vouchers.add(OrderDetailVoucher.fromJson(item));
      }
      nextUrl = responseJson["next_page_url"];
      result = ResultVoucher(vouchers,nextUrl);
    }
    return result;
  }
}

class Voucher {
  String harga;
  String durasi;
  String masaBerlaku;

  Voucher({this.harga, this.durasi, this.masaBerlaku});

  Voucher.fromJson(Map<String, dynamic> json) {
    harga = json['harga'];
    durasi = json['durasi'];
    masaBerlaku = json['masa_berlaku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['harga'] = this.harga;
    data['durasi'] = this.durasi;
    data['masa_berlaku'] = this.masaBerlaku;
    return data;
  }
}

class ResultOrderVoucher{
  List<Order> orders;
  String nextUrl;
  ResultOrderVoucher(this.orders,this.nextUrl);
}

class ResultVoucher{
  List<OrderDetailVoucher> vouchers;
  String nextUrl;
  ResultVoucher(this.vouchers,this.nextUrl);
}

