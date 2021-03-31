import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ponny/model/Dashboard.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Dashboard.dart';


class UserModel with ChangeNotifier{
  User user;
  bool loggedIn = false;
  bool loading = false;

  UserModel();

  Future<void> saveUser(Map<String, dynamic> user) async {
    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      // save to Preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      loggedIn = true;

      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {

        await storage.setItem("userInfo", user);
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
  }


  Future<void> getUser(String token) async {
    try {
      final response = await http.get(userprofile,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
      final responseJson = json.decode(response.body);
      if(response.statusCode == 200){
        user = User.fromLocalJson(responseJson);
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
  }

  Future<bool> setUser(String token,param) async {

    try {
      final result = await http.post(urlUpdateProfile+"/"+user.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
      if (result.statusCode == 200) {
        await getUser(token);
        return true;
      }
    } catch (err) {
      print(err);
    }
    return false;
  }

  Future<bool> setUserOTP(String token,param,id) async {

    try {
      final result = await http.post(urlUpdateProfile+"/"+id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
      if (result.statusCode == 200) {
        await getUser(token);
        return true;
      }
    } catch (err) {
      print(err);
    }
    return false;
  }

  Future<void> logout() async {
    user = null;
    loggedIn = false;
    final LocalStorage storage = LocalStorage("fstore");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("userInfo");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
class User{
   int id;
   String provider_id;
   String user_type;
   String name;
   String last_name;
   String email;
   String email_verified_at;
   String avatar_original;
   String phone;
   String gender;
   String tgl_lahir;
   int jenis_kulit;
   int warna_kulit;
   String kondisi_kulit;
   String kondisi_rambut;
   String preferensi_product;
   int completed_profile;
   int tier;
   int point;
   Dashboards dashboard;
   String referral_code;

   User(
      this.id,
      this.provider_id,
      this.user_type,
      this.name,
      this.last_name,
      this.email,
      this.email_verified_at,
      this.avatar_original,
      this.phone,
      this.gender,
      this.tgl_lahir,
      this.jenis_kulit,
      this.warna_kulit,
      this.kondisi_kulit,
      this.kondisi_rambut,
      this.preferensi_product,
      this.completed_profile,
      this.tier,
      this.point,
       this.dashboard,
       this.referral_code
       );

   User.fromLocalJson(Map<String, dynamic> json) {
     print(json);
     try {
       id = json['id'];
       provider_id = json['provider_id'];
       user_type = json['user_type'];
       name = json['name'];
       last_name = json['last_name'];
       email = json['email'];
       email_verified_at= json['email_verified_at'];
       avatar_original = json['avatar_original'];
       phone = json['phone'];
       gender = json['gender'];
       tgl_lahir = json['tgl_lahir'];
       jenis_kulit= json['jenis_kulit'];
       warna_kulit= json['warna_kulit'];
       kondisi_kulit = json['kondisi_kulit'];
       kondisi_rambut = json['kondisi_rambut'];
       preferensi_product = json['preferensi_product'];
       completed_profile = json['completed_profile'];
       tier = json['tier'];
       point = json['point'];
       dashboard = json['dashboard'] != null
           ? new Dashboards.fromJson(json['dashboard'])
           : null;
       referral_code = json['referral_code'];
     } catch (e) {
       print(e.toString());
     }
   }
}