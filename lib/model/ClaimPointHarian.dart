import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';



ClaimPointHarian claimPointHarianFromJson(String str) => ClaimPointHarian.fromJson(json.decode(str));

String claimPointHarianToJson(ClaimPointHarian data) => json.encode(data.toJson());

class ClaimPointHarian with ChangeNotifier{

  List<History> HistoryPoint = [];
  Info InfoPoint;
  bool isLoading = true;

  ClaimPointHarian({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory ClaimPointHarian.fromJson(Map<String, dynamic> json) => ClaimPointHarian(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };


  Future<void> getClaimPoint(String token) async{
    final res = await http.get(getHistoryPoint,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"});
      final responseJson = json.decode(res.body);
      if (res.statusCode == 200) {
        HistoryPoint = [];
        for (Map item in responseJson["data"]["history"]){
          HistoryPoint.add(History.fromJson(item));
        }
        InfoPoint = Info.fromJson(responseJson["data"]["info"]);
        isLoading = false;
        notifyListeners();
      }
  }

  Future<void> claimPointHarian(Info info, String token) async{
    var params = <String,dynamic>{
      "point_get" : info.point,
      "checkin_id" : info.checkinId
    };
    final ress = await http.post(claimPoint,headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : "Bearer $token"
    },body: json.encode(params));

    if(ress.statusCode == 200){
        getClaimPoint(token);
        notifyListeners();
    }
  }
}


class Data {
  Data({
    this.info,
    this.history,
  });

  Info info;
  List<History> history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info: Info.fromJson(json["info"]),
    history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info.toJson(),
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class History {
  History({
    this.status,
    this.labelName,
    this.pointGet,
    this.checkinId,
  });

  bool status;
  String labelName;
  int pointGet;
  int checkinId;

  factory History.fromJson(Map<String, dynamic> json) => History(
    status: json["status"],
    labelName: json["label_name"],
    pointGet: json["point_get"],
    checkinId: json["checkin_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "label_name": labelName,
    "point_get": pointGet,
    "checkin_id": checkinId,
  };
}

class Info {
  Info({
    this.claimToday,
    this.point,
    this.checkinId,
  });

  bool claimToday;
  int point;
  int checkinId;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    claimToday: json["claim_today"],
    point: json["point"],
    checkinId: json["checkin_id"],
  );

  Map<String, dynamic> toJson() => {
    "claim_today": claimToday,
    "point": point,
    "checkin_id": checkinId,
  };
}
