import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/Order.dart';
import 'package:ponny/util/globalUrl.dart';

class PostandComment with ChangeNotifier {

 Future<bool> leaveRoomModel(String token,var param) async {
    final res = await http.post(leaveRoom,
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

  Future<bool> postRoomModel(String token,var param) async {
    final res = await http.post(postRoom,
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
    Future<bool> likePost(String token,String id) async {
    final res = await http.post(likeunlikepost+"$id"+"/1",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }
  Future<bool> unlikePost(String token,String id) async {
    final res = await http.post(likeunlikepost+"$id"+"/0",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }
  Future<bool> likeComment(String token,String id) async {
    final res = await http.post(likeunlikecomment+"$id"+"/1",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }
  Future<bool> unlikeComment(String token,String id) async {
    final res = await http.post(likeunlikecomment+"$id"+"/0",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
    print(res.statusCode);
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
      notifyListeners();
    }
    return result;
  }

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
  Future<bool> replycomment(String token, param) async {
    final res = await http.post(replyComment,
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
