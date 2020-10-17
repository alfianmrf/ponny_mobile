import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class BannerModel with ChangeNotifier{
  List<Banner> listbanner =[];
  
  Future<void> getPaymentMethods() async {
    try{
      final result = await http.get(banner);
    }catch(err){
      
    }
    
  }
  
  


}
class Banner{
  String photo;
  String url;
  String position;

  Banner(this.photo, this.url, this.position);
  factory Banner.fromJson(Map<String, dynamic> parsedJson){
    return Banner(parsedJson["photo"], parsedJson["url"], parsedJson["position"]);
  }
}