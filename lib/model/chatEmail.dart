import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Order.dart';
import 'package:ponny/util/globalUrl.dart';

class ChatEmail with ChangeNotifier
{

  Future<bool> contactsEmail (String token,param) async {
    final res = await http.post(contactEmail, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param));
    print(res.statusCode);
    bool result =false;
    if(res.statusCode == 200){
      result =true;
    notifyListeners();
    }
    return result;
  }

}

