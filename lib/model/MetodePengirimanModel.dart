import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class MetodePengiriman with ChangeNotifier {
  static String storeAddress =
      "Mau diantar atau diambil sendiri nih? Kamu bisa pilih loh!";

  set setAddress(newValue) {
    storeAddress = newValue;
    notifyListeners();
  }

  String get setAddress => storeAddress;
}
