import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

Future<String> roomsData() async {
  final response = await http.get(loginUrl);
  Map<String, dynamic> map = json.decode(response.body);
  String data = map["access_token"];
  print(response.body);
  return data;
}
