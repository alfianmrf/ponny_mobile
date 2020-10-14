import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier{
  User user;
  bool loggedIn = false;
  bool loading = false;

  UserModel(){
    
  }

  Future<void> saveUser(User user) async {
    final LocalStorage storage = LocalStorage("fstore");
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
    final LocalStorage storage = LocalStorage("fstore");
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem(kLocalKey["userInfo"]);
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
}