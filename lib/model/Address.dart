import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Courier.dart';
import 'package:ponny/util/globalUrl.dart';

class AddressModel with ChangeNotifier{
  List<Address> listAdress= List<Address>();
  List<Courier> listCourier = List<Courier>();
  List<MasterAddress> listProvinces =List<MasterAddress>();
  List<MasterAddress> listcities =List<MasterAddress>();
  List<MasterAddress> listsubcities =List<MasterAddress>();

  Address useAddress;
  bool loading=true;
  MasterAddress provinces;
  MasterAddress cities;
  MasterAddress Subcities;

  AddressModel(){
    getDefaultAddress();
  }

  Future<void> setDefaultAddress(Address address ) async {
    final LocalStorage storage = LocalStorage("ponnystore");
    final ready = await storage.ready;
    if (ready) {
      final result = address.toJson();
      await storage.setItem("useAddress", result);
      useAddress = address;
      notifyListeners();
    }
  }


  Future<void> getDefaultAddress() async {
    final LocalStorage storage = LocalStorage("ponnystore");
    final ready = await storage.ready;
    if (ready) {
      final json = storage.getItem("useAddress");
      // print(json);
      if (json != null) {
        useAddress = Address.fromJson(json);
        notifyListeners();
      }
      loading=false;
    }
  }


  Future<void> getListAddress(token) async {
    final res = await http.get(urlAddress,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token"  });

    if(res.statusCode == 200){
      listAdress=[];
      final responseJson = json.decode(res.body);
      for (Map item in responseJson) {
        print(Address.fromJson(item).id);
        listAdress.add(Address.fromJson(item));
      }
      notifyListeners();

    }

  }

  Future<void> RemoveDefaultAddress() async {
      useAddress = null;
      notifyListeners();
  }

  Future<void> RemoveAddress(String token, Address address) async {
    final res = await http.get(removeAddressUrl+"/"+address.id.toString(),headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token"  });
    final responseJson = json.decode(res.body);
    if(res.statusCode == 200){
      listAdress.remove(address);
      notifyListeners();
    }
  }

  Future<void> getListCourier(token) async {
    var param="?address_id="+useAddress.id.toString();
    // print(CostShipping+param);
    final res = await http.get(CostShipping+param,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token"  });
    final responseJson = json.decode(res.body);

    if(res.statusCode == 200){
      listCourier=[];
      for (Map item in responseJson) {
        // print(Courier.fromJson(item));
        listCourier.add(Courier.fromJson(item));
      }
      notifyListeners();
    }
  }

  Future<bool> SaveAddressToServer(token,param) async {
    final res = await http.post(saveAddressUrl,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token"  },body: json.encode(param));

    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      await getListAddress(token);
      if(param['id'] !=null ){
        useAddress = listAdress.firstWhere((element) => element.id == param['id']);
        await getListCourier(token);
        notifyListeners();
      }
      //

      return true;
    }
    return false;
  }

  Future<List<MasterAddress>> getParamAddress(String type,String kode) async {
    List<MasterAddress>  result=[];
    String url ="";
    if(type == "prov"){
      url=urlProv;
    }else if(type =="kab" && kode != null){
      url=urlKab+"/"+kode.toString();
    }else if(type =="kec" && kode != null){
      url=urlKec+"/"+kode.toString();
    }
    final res = await http.get(url);
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      for (Map item in responseJson) {
        result.add(MasterAddress.fromJson(item));
      }
    }
    return result;
  }



}
class Address {
  int id;
  String nama_depan;
  String nama_belakang;
  String nomor_hp;
  String province_id;
  String province;
  String city_id;
  String city_name;
  String kecamatan_id;
  String kecamatan;
  String postal_code;
  String alamat_lengkap;
  int user_id;
  String results_raw;
  String created_at;
  String updated_at;
  int is_deleted;
  String lat;
  String lng;

  Address(
      this.id,
      this.nama_depan,
      this.nama_belakang,
      this.nomor_hp,
      this.province_id,
      this.province,
      this.city_id,
      this.city_name,
      this.kecamatan_id,
      this.kecamatan,
      this.postal_code,
      this.alamat_lengkap,
      this.user_id,
      this.results_raw,
      this.created_at,
      this.updated_at,
      this.is_deleted,
      this.lat,
      this.lng,
      );



  factory Address.fromJson(Map<String, dynamic> parsedJson){
      return  Address(
        parsedJson["id"],
        parsedJson["nama_depan"],
        parsedJson["nama_belakang"],
        parsedJson["nomor_hp"],
        parsedJson["province_id"],
        parsedJson["province"],
        parsedJson["city_id"],
        parsedJson["city_name"],
        parsedJson["kecamatan_id"],
        parsedJson["kecamatan"],
        parsedJson["postal_code"],
        parsedJson["alamat_lengkap"],
        parsedJson["user_id"],
        parsedJson["results_raw"],
        parsedJson["created_at"],
        parsedJson["updated_at"],
        parsedJson["is_deleted"],
        parsedJson["lat"],
        parsedJson["lng"],
      );
  }

  Map<String, dynamic> toJson() =>{
    "id":this.id,
    "nama_depan":this.nama_depan,
    "nama_belakang":this.nama_belakang,
    "nomor_hp":this.nomor_hp,
    "province_id":this.province_id,
    "province":this.province,
    "city_id":this.city_id,
    "city_name":this.city_name,
    "kecamatan_id":this.kecamatan_id,
    "kecamatan":this.kecamatan,
    "postal_code":this.postal_code,
    "alamat_lengkap":this.alamat_lengkap,
    "user_id":this.user_id,
    "results_raw":this.results_raw,
    "created_at":this.created_at,
    "updated_at":this.updated_at,
    "is_deleted":this.is_deleted,
    "lat":this.lat,
    "lng":this.lng,
  };

}
class MasterAddress{
  String id;
  String text;
  MasterAddress(this.id, this.text);

  factory MasterAddress.fromJson(Map<String, dynamic> parsedJson){
    return  MasterAddress(parsedJson["id"],parsedJson["text"]);
  }
}