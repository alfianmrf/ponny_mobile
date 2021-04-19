import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
// import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/model/GeneralSetting.dart';
import 'package:ponny/model/ItemBlog.dart';
import 'package:ponny/model/ItemSkinklopedia.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/util/AppId.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http/http.dart' as http;

class AppModel with ChangeNotifier{
  LoginAuth auth;
  WaContact waContact;
  GeneralSetting setting;
  List<FaqHeader> listFaq =[];
  bool loggedIn =false;
  bool loadingFaq =true;
  bool loadingSetting= true;
  AppModel(){
    getAuth();
    getFAQ();
    getWA();
    generalSettings();
  }

  Future<void> generalSettings() async {
    final response = await http.get(generalSetting);
    if (response.statusCode == 200) {
      //print('sukses');
      final res = json.decode(response.body);
      setting = GeneralSetting.fromJson(res['data'][0]);
      loadingSetting = false;
      notifyListeners();
      //print(data);
      // return data;
    } else {
      throw Exception('Failed to load data');
    }
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

  Future<LoginResult> setAuth(param) async {
    LoginResult _result = LoginResult(status: 500,message: "Terjadi kesalahan pada server, mohon ulangi beberapa saat lagi." );
    final res = await http.post(loginUrl,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    final LocalStorage storage = LocalStorage("ponnystore");
    var result = json.decode(res.body);
    _result = LoginResult(status: res.statusCode,message:result['message'] );
    if(res.statusCode == 200){
      auth = LoginAuth.fromLocalJson(result);
      loggedIn =true;
      _result = LoginResult(status: res.statusCode,message: result['message']);
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("auth", result);
        notifyListeners();
        return _result;
      }
    }
    return _result;
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

  Future<void> getWA() async {
    final res = await http.get(waContacturl);
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      waContact = WaContact.fromJson(result);
    }
  }

  Future<User> setAuthOtp(param) async {
    User _result;
    final res = await http.post(loginOtp,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    final LocalStorage storage = LocalStorage("ponnystore");
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      auth = LoginAuth.fromLocalJson(result);
      _result = User.fromLocalJson(result['user']);
      loggedIn =true;
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("auth", result);
        notifyListeners();
        return _result;
      }
    }
    return _result;
  }

  Future<User> setAuthSocial(param) async {
    User _result;
    final res = await http.post(loginSocial,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    // print(res.body);
    final LocalStorage storage = LocalStorage("ponnystore");

    if(res.statusCode == 200){
      var result = json.decode(res.body);
      auth = LoginAuth.fromLocalJson(result);
      _result = User.fromLocalJson(result['user']);
      print(_result.name);
      print(_result.email);
      loggedIn =true;
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("auth", result);
        notifyListeners();
        return _result;
      }
    }
    return _result;
  }

  Future<SearchGlobalResult> search(param) async {
    final res = await http.post(globalSearch,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));

    if(res.statusCode == 200){
      var result = json.decode(res.body);
      return SearchGlobalResult.fromJson(result);
    }
    return null;
  }

  Future<List<Faq>> searchFaqData(param) async {
    final res = await http.post(faqSearch,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    List<Faq> _result=[];
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      result.forEach((v) {
        _result.add(new Faq.fromJson(v));
      });
    }
    return _result;
  }

  Future<List<ItemSkinklopedia>> searchSkinklopedia(param) async {
    final res = await http.post(skinklopediaSearch,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    List<ItemSkinklopedia> _result=[];
    if(res.statusCode == 200){
      var result = json.decode(res.body);
      result.forEach((v) {
        _result.add(new ItemSkinklopedia.fromJson(v));
      });
    }
    return _result;
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

class WaContact {
  String link;
  String text;
  String phone;

  WaContact({this.link, this.text, this.phone});

  WaContact.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    text = json['text'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['text'] = this.text;
    data['phone'] = this.phone;
    return data;
  }
}

class SearchGlobalResult{
  List<Product> products=[];
  List<Brand> brands=[];
  List<Category> categorys=[];
  List<ItemBlog> blogs = [];
  SearchGlobalResult(this.products,this.brands,this.categorys,this.blogs);
  SearchGlobalResult.fromJson(Map<String, dynamic> json) {

    json['products'].forEach((v) {
      products.add(new Product.fromJson(v['availability']));
    });
    json['categorys'].forEach((v) {
      categorys.add(new Category.fromJson(v));
    });
    json['blog'].forEach((v) {
      blogs.add(new ItemBlog.fromJson(v));
    });
    json['brand'].forEach((v) {
      brands.add(new Brand.fromJson(v));
    });

  }
}
class LoginResult{
  int status;
  String message;
  LoginResult({this.status,this.message});
}