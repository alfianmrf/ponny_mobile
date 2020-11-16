import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Order.dart';
import 'package:ponny/util/globalUrl.dart';

class PostandComment with ChangeNotifier {
 
  Future<bool> posts(String token, param) async {
    final res = await http.post(newPost,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode(param));
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }

  Future<bool> comment(String token, param) async {
    final res = await http.post(newComment,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode(param));
    print(res.body);
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }

  Future<String> uploadImage(String token, filename, url) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }
}
