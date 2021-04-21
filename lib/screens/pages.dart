import 'dart:convert';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/MetodePengirimanModel.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:ponny/screens/payment_screen.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/screens/pages.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';


part 'list_toko_pengiriman_screen.dart';
part 'rincian_pengambilan_screen.dart';
part 'Payment_PickUp_Success.dart';
part 'Barcode_Scanner_Screen.dart';
