import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

AffiliateWithdraw affiliateWithdrawFromJson(String str) =>
    AffiliateWithdraw.fromJson(json.decode(str));

String affiliateWithdrawToJson(AffiliateWithdraw data) =>
    json.encode(data.toJson());

class AffiliateWithdraw with ChangeNotifier {
  Future<bool> withdrawFund(bankname, norek, name, token) async {
    var params = {"payment_method": bankname, "norek": norek, "atasnama": name};
    final res = await http.post(affiliateWithdraw,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: json.encode(params));
    if (res.statusCode == 200) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  AffiliateWithdraw({
    this.message,
    this.success,
    this.status,
  });

  String message;
  bool success;
  int status;

  factory AffiliateWithdraw.fromJson(Map<String, dynamic> json) =>
      AffiliateWithdraw(
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
