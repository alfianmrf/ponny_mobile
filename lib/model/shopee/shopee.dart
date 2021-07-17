import 'package:flutter/material.dart';

class ShopeeListFilter with ChangeNotifier {
  String name;
  bool status;

  ShopeeListFilter({this.name, this.status});

  ShopeeListFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
