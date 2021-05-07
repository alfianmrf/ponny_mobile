import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class PaymentMethodModel with ChangeNotifier{
  List<PaymentMethod> listPayment= List<PaymentMethod>();

  PaymentMethodModel(){
    getListPayment();
  }

  Future<void> getListPayment() async {
    final res = await http.get(paymentMethod,headers: { HttpHeaders.contentTypeHeader: 'application/json' });

    if(res.statusCode == 200){
      listPayment=[];
      final responseJson = json.decode(res.body);
      for (Map item in responseJson['payments']) {
        // print(Address.fromJson(item).id);
        listPayment.add(PaymentMethod.fromJson(item));
      }
      notifyListeners();
    }
  }
}

class PaymentMethod{
  String name;
  int status;
  String code;

  PaymentMethod(
      {this.name,
        this.status,
        this.code});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}