import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class SliderModel with ChangeNotifier{
  List<Slider> listSlider =[];

  SliderModel(){
    getPaymentMethods();
  }

  Future<void> getPaymentMethods() async {
    try{
      final result = await http.get(slider);
      if(result.statusCode == 200){
        final responseJson = json.decode(result.body);
        for (Map item in responseJson["data"]) {
          listSlider.add(Slider.fromJson(item));
        }
      }

      notifyListeners();
    }catch(err){
      print("error."+err.toString());
      notifyListeners();
    }
  }
}
class Slider{
  String photo;
  Slider(this.photo);
  factory Slider.fromJson(Map<String, dynamic> parsedJson){
    return Slider(parsedJson["photo"]);
  }
}