import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http/http.dart' as http;

class AppModel with ChangeNotifier{
  LoginAuth auth;
  bool loggedIn =false;
  AppModel(){
    getAuth();
  }

  Future<void> getAuth() async {
    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem("auth");
        if (json != null) {
          auth = LoginAuth.fromLocalJson(json);
          loggedIn = true;
          notifyListeners();

        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<bool> setAuth(param) async {
    final res = await http.post(loginUrl,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    final LocalStorage storage = LocalStorage("ponnystore");
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      auth = LoginAuth.fromLocalJson(result);
      loggedIn =true;
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("auth", result);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> setAuthOtp(param) async {
    final res = await http.post(loginOtp,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    final LocalStorage storage = LocalStorage("ponnystore");
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      auth = LoginAuth.fromLocalJson(result);
      loggedIn =true;
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("auth", result);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {

    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("auth");
        await storage.deleteItem("useAddress");
        auth = null;
        loggedIn = false;
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }

  }

}
class LoginAuth {
  String access_token;
  String token_type;
  String expires_at;
  LoginAuth(this.access_token, this.token_type, this.expires_at);

  factory LoginAuth.fromLocalJson(Map<String, dynamic> json) {
    return LoginAuth(json["access_token"], json["token_type"], json["expires_at"]);
  }

}