import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

AddCodeResult addCodeResultFromJson(String str) =>
    AddCodeResult.fromJson(json.decode(str));

String addCodeResultToJson(AddCodeResult data) => json.encode(data.toJson());

class AddCodeResult with ChangeNotifier {
  Future<void> customCode(code, token) async {
    var param = {"code": code};
    final res = await http.post(affiliateCustomCode,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode(param));
    if (res.statusCode == 200) {}
    notifyListeners();
  }

  AddCodeResult({
    this.message,
    this.success,
    this.status,
  });

  String message;
  bool success;
  int status;

  factory AddCodeResult.fromJson(Map<String, dynamic> json) => AddCodeResult(
        message: json["message"],
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "status": status,
      };
}
