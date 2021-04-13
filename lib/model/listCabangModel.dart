import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/model/Cart.dart';
import 'package:provider/provider.dart';


ListCabang listCabangFromJson(String str) => ListCabang.fromJson(json.decode(str));

String listCabangToJson(ListCabang data) => json.encode(data.toJson());



class ListCabang with ChangeNotifier {
  List<Cart> unavaliable = [];
  List<Datum> dataCabang = [];
  Datum cabangClick;
  int unavaliableQty = 0;
  bool isDelivery = false;

  void addDataUn(Cart cart){
   
    dataCabang.indexWhere((element) => element.unavailableProduct == cart.product.id);
      for(var item in dataCabang){
        for ( var result in item.unavailableProduct) {
          if (result == cart.product.id) {
            unavaliable.add(cart);
          }
        }
      }
    notifyListeners();
  }

  set setDataCabang(value){
    cabangClick = value;
    notifyListeners();
  }

  set setUnavailable(value){
    unavaliable = unavaliable;
    notifyListeners();
  }

  set setDataUnavaliable(value){
      isDelivery = value;
      notifyListeners();
  }

  bool get setDataUnavaliable => isDelivery;
  Datum get setDataCabang => cabangClick;
  List<Cart> get setUnavailable => unavaliable;

  ListCabang({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory ListCabang.fromJson(Map<String, dynamic> json) => ListCabang(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  Future<void>getListCabang(String token) async{
    var res = await http.get(listCabangURL,headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: "Bearer $token"});
    final responseJson = json.decode(res.body);
    if(res.statusCode == 200){
      dataCabang = [];
      for(Map item in responseJson["data"]){
          print(item);
          dataCabang.add(Datum.fromJson(item));
      }
    }
  }


}

class Datum {
  Datum({
    this.id,
    this.namaCabang,
    this.lokasiCabang,
    this.alamatCabang,
    this.jamOperasional,
    this.waktu,
    this.statusAvailable,
    this.messageAvailable,
    this.availableProduct,
    this.unavailableProduct,
    this.getProduct,
  });

  int id;
  String namaCabang;
  String lokasiCabang;
  String alamatCabang;
  String jamOperasional;
  String waktu;
  bool statusAvailable;
  String messageAvailable;
  List<dynamic> availableProduct;
  List<int> unavailableProduct;
  List<dynamic> getProduct;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaCabang: json["nama_cabang"],
    lokasiCabang: json["lokasi_cabang"],
    alamatCabang: json["alamat_cabang"],
    jamOperasional: json["jam_operasional"],
    waktu: json["waktu"],
    statusAvailable: json["status_available"],
    messageAvailable: json["message_available"],
    availableProduct: List<dynamic>.from(json["available_product"].map((x) => x)),
    unavailableProduct: List<int>.from(json["unavailable_product"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_cabang": namaCabang,
    "lokasi_cabang": lokasiCabang,
    "alamat_cabang": alamatCabang,
    "jam_operasional": jamOperasional,
    "waktu": waktu,
    "status_available": statusAvailable,
    "message_available": messageAvailable,
    "available_product": List<dynamic>.from(availableProduct.map((x) => x)),
    "unavailable_product": List<dynamic>.from(unavailableProduct.map((x) => x)),
  };
}
