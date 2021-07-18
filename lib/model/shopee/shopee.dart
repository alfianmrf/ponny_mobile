import 'package:flutter/material.dart';

class ShopeeListFilter with ChangeNotifier {
  String name;
  int price;
  bool status;

  ShopeeListFilter({this.name, this.status,this.price});

  ShopeeListFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['price'] = this.price;
    return data;
  }
}
