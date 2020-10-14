import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier{
  User user;
  bool loggedIn = false;
  bool loading = false;

  UserModel(){
    getUser();
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      // save to Preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);

      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("userInfo", user);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> getUser() async {
    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem("userInfo");
        if (json != null) {
          user = User.fromLocalJson(json);
          loggedIn = true;
          notifyListeners();
        }
      }
    } catch (err) {
      print(err);
    }
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
   String jenis_kulit;
   String warna_kulit;
   String kondisi_kulit;
   String kondisi_rambut;
   String preferensi_product;
   int completed_profile;
   int tier;
   int point;

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
      this.point);

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
     } catch (e) {
       print(e.toString());
     }
   }
}