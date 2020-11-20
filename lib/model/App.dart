import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/util/AppId.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http/http.dart' as http;

class AppModel with ChangeNotifier{
  LoginAuth auth;
  List<FaqHeader> listFaq =[];
  bool loggedIn =false;
  bool loadingFaq =true;
  AppModel(){
    getAuth();
    getFAQ();
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

  Future<void> getFAQ() async {
    listFaq =[];
    final res = await http.get(faqUrl);
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      for(Map item in result){
        listFaq.add(FaqHeader.fromJson(item));
      }
    }
    loadingFaq =false;
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

  Future<bool> setAuthSocial(param) async {
    final res = await http.post(loginSocial,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    print(res.body);
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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final TwitterLogin twitterLogin = TwitterLogin(consumerKey: TWITTER_CLIENT_ID, consumerSecret: TWITTER_CLIENT_SECRET);
    final LocalStorage storage = LocalStorage("ponnystore");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("auth");
        await storage.deleteItem("useAddress");
        final googleSinginStatus = await googleSignIn.isSignedIn();
        if(googleSinginStatus)
        await googleSignIn.signOut();
        final twitterStatus =await twitterLogin.isSessionActive;
        if(twitterStatus) await twitterLogin.logOut();
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