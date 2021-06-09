import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/model/LacakResult.dart';
import 'package:ponny/model/ManualInfo.dart';
import 'package:ponny/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

class OrderModel with ChangeNotifier {
  List<Order> unpaid;
  List<Order> paid;
  List<Order> on_delivery;
  List<Order> completed;
  bool loading = true;
  String imageBukti;
  String namaBank;
  int noRek;
  String namaNasabah;
  OrderModel();

  Future<void> getOrder(String token) async {
    print("get order");
    final res = await http.get(urlOrder, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (res.statusCode == 200) {
      unpaid = [];
      print(res.body);
      final responseJson = json.decode(res.body);
      for (Map item in responseJson["unpaid"]) {
        print(Order.fromJson(item).code);
        unpaid.add(Order.fromJson(item));
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<NewManualInfo> getManualpembayaran(
      String token, String order_id) async {
    final res = await http.get(paymentInfo + "/" + order_id, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    NewManualInfo result;
    print("awesome===" + order_id);
    print(json.decode(res.body));
    print(res.statusCode);
    if (res.statusCode == 200) {
      final responseJson = json.decode(res.body);
      print("ini parse");
      print(responseJson);
      result = NewManualInfo.fromJson(json.decode(res.body));
      print("ini result");
      print(result);
    }
    return result;
  }

  Future<LacakResult> getLacak(String token, String order_id) async {
    final res = await http.get(urlTracking + "/" + order_id, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    LacakResult result;
    if (res.statusCode == 200) {
      final responseJson = json.decode(res.body);
      result = LacakResult.fromJson(responseJson);
    }
    return result;
  }

  Future<bool> konfirmasiTerima(String token, String order_id) async {
    final res = await http.get(urlTerimaBarang + "/" + order_id, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    bool result = false;
    if (res.statusCode == 200) {
      result = true;
    }
    return result;
  }
}

class Order {
  int id;
  String code;
  String date;
  String payment_type;
  String payment_status;
  int subtotal;
  String grand_total; //dev
  String coupon_discount; //dev
  Address user_order_address;
  MapCost shipping_info;
  Midtrans mitrans_val;
  String free_ongkir; //dev
  List<OrderDetail> order_details;
  List<OrderDetailSample> orderDetailSample;
  List<OrderDetailPoint> orderDetailPoint;
  List<OrderDetailVoucher> orderDetailVoucher;
  StatusOrder status;
  TypePayment payment;
  String typePayment;
  String confrimCourier;
  String confrimResi;
  String deliveryStatus;
  MidtransRaw mitransVal;
  int usingPoint;
  bool pickUp;
  CabangInfo cabangInfo;

  Order(
      this.id,
      this.code,
      this.date,
      this.payment_type,
      this.payment_status,
      this.grand_total,
      this.subtotal,
      this.coupon_discount,
      this.user_order_address,
      this.shipping_info,
      this.mitrans_val,
      this.free_ongkir,
      this.order_details,
      this.orderDetailSample,
      this.orderDetailPoint,
      this.status,
      this.payment,
      this.typePayment,
      this.confrimCourier,
      this.confrimResi,
      this.deliveryStatus,
      this.orderDetailVoucher,
      this.mitransVal,
      this.usingPoint,
      this.pickUp,
      this.cabangInfo);

  factory Order.fromJson(Map<String, dynamic> parsedJson) {
    List<OrderDetail> _order_details = [];
    Address _user_order_address = parsedJson["user_order_address"] != null
        ? Address.fromJson(parsedJson["user_order_address"])
        : null;
    MapCost _shipping_info = parsedJson["shipping_info"] != null
        ? MapCost.fromJson(parsedJson["shipping_info"])
        : null;
    Midtrans _mitrans_val = parsedJson["mitrans_val"] != null
        ? Midtrans.fromJson(parsedJson["mitrans_val"])
        : null;
    MidtransRaw _mitrans_raw = parsedJson["mitrans_val"] != null
        ? MidtransRaw.fromJson(parsedJson["mitrans_val"])
        : null;
    List<OrderDetailSample> _orderDetailSample = [];
    List<OrderDetailPoint> _orderDetailPoint = [];
    List<OrderDetailVoucher> _orderDetailVoucher = [];
    StatusOrder _status = parsedJson["statusOrder"] != null
        ? StatusOrder.fromJson(parsedJson["statusOrder"])
        : null;
    TypePayment _payment = parsedJson["typePayment"] != null
        ? TypePayment.fromJson(parsedJson["typePayment"])
        : null;
    String _typePayment = parsedJson["typePayment"] != null
        ? parsedJson["typePayment"]["param_2"]
        : null;
    CabangInfo _cabangInfo = parsedJson["cabang_info"].length != 0
        ? CabangInfo.fromJson(parsedJson["cabang_info"])
        : null;
    int _usingPoint =
        parsedJson["using_point"] != null ? parsedJson["using_point"] : null;
    for (Map item in parsedJson["orderDetails"]) {
      _order_details.add(OrderDetail.fromJson(item));
    }

    for (Map item in parsedJson["orderDetailSample"]) {
      _orderDetailSample.add(OrderDetailSample.fromJson(item));
    }
    for (Map item in parsedJson["orderDetailPoint"]) {
      _orderDetailPoint.add(OrderDetailPoint.fromJson(item));
    }
    for (Map item in parsedJson["orderVoucher"]) {
      _orderDetailVoucher.add(OrderDetailVoucher.fromJson(item));
    }
    return Order(
        parsedJson["id"],
        parsedJson["code"],
        parsedJson["date"],
        parsedJson["payment_type"],
        parsedJson["payment_status"],
        parsedJson["grand_total"],
        parsedJson["subtotal"],
        parsedJson["coupon_discount"],
        _user_order_address,
        _shipping_info,
        _mitrans_val,
        parsedJson["free_ongkir"],
        _order_details,
        _orderDetailSample,
        _orderDetailPoint,
        _status,
        _payment,
        _typePayment,
        parsedJson["confrim_courier"],
        parsedJson["confrim_resi"],
        parsedJson["delivery_status"],
        _orderDetailVoucher,
        _mitrans_raw,
        _usingPoint,
        parsedJson["pickup"],
        _cabangInfo);
  }
}

class Midtrans {
  String payment_type;
  String mitrans_val;

  Midtrans(this.payment_type, this.mitrans_val);

  factory Midtrans.fromJson(Map<String, dynamic> parsedJson) {
    String _va_numbers;
    if (parsedJson != null &&
        parsedJson["payment_type"] == "bank_transfer" &&
        parsedJson["va_numbers"] != null) {
      for (Map item in parsedJson["va_numbers"]) {
        _va_numbers = item["bank"].toString().toUpperCase() +
            " Virtual \nCode: " +
            item["va_number"];
      }
      return Midtrans(parsedJson["payment_type"], _va_numbers);
    } else if (parsedJson != null && parsedJson["payment_type"] == "cstore") {
      _va_numbers = parsedJson["store"].toString().toUpperCase() +
          "\nCode: " +
          parsedJson["payment_code"];
      return Midtrans(parsedJson["payment_type"], _va_numbers);
    } else if (parsedJson != null && parsedJson["payment_type"] == "echannel") {
      _va_numbers = "Mandiri Bill Payment" +
          "\nBill key: " +
          parsedJson["bill_key"] +
          "\nBiller Code: " +
          parsedJson["biller_code"];
      return Midtrans(parsedJson["payment_type"], _va_numbers);
    } else if (parsedJson != null &&
        parsedJson["payment_type"] == "bank_transfer" &&
        parsedJson["permata_va_number"] != null) {
      _va_numbers =
          "Permata Virtual" + "\nCode: " + parsedJson["permata_va_number"];
      return Midtrans(parsedJson["payment_type"], _va_numbers);
    } else
      return null;
  }
}

class OrderDetail {
  int id;
  String quantity;
  String price;
  Product product;
  String reviewed;
  OrderDetail(this.id, this.quantity, this.product, this.price, this.reviewed);
  factory OrderDetail.fromJson(Map<String, dynamic> parsedJson) {
    return OrderDetail(
        parsedJson["id"],
        parsedJson["quantity"],
        Product.fromJson(parsedJson["product"]["availability"]),
        parsedJson["price"],
        parsedJson["reviewed"]);
  }
}

class CabangInfo {
  String namaCabang;
  String alamatCabang;

  CabangInfo({this.namaCabang, this.alamatCabang});

  CabangInfo.fromJson(Map<String, dynamic> json) {
    namaCabang = json['nama_cabang'];
    alamatCabang = json['alamat_cabang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_cabang'] = this.namaCabang;
    data['alamat_cabang'] = this.alamatCabang;
    return data;
  }
}

class OrderDetailSample {
  int id;
  String quantity;
  Product product;
  String reviewed;
  OrderDetailSample(this.id, this.quantity, this.product, this.reviewed);
  factory OrderDetailSample.fromJson(Map<String, dynamic> parsedJson) {
    return OrderDetailSample(
        parsedJson["id"],
        parsedJson["quantity"],
        Product.fromJson(parsedJson["product"]["availability"]),
        parsedJson["reviewed"]);
  }
}

class OrderDetailPoint {
  int id;
  String quantity;
  String jml_point;
  Product product;
  String reviewed;
  OrderDetailPoint(
      this.id, this.quantity, this.product, this.jml_point, this.reviewed);
  factory OrderDetailPoint.fromJson(Map<String, dynamic> parsedJson) {
    return OrderDetailPoint(
        parsedJson["id"],
        parsedJson["quantity"],
        Product.fromJson(parsedJson["product"]["availability"]),
        parsedJson["log_product_point"]["jml_point"],
        parsedJson["reviewed"]);
  }
}

class OrderDetailVoucher {
  int id;
  int durasi;
  String expDate;
  int harga;
  int orderId;
  int userId;
  int isActive;
  String createdAt;
  String updatedAt;
  int masaBerlaku;
  int dokterId;
  int durasiPanggilan;
  String waktuPanggilan;
  String waktuPanggilanBerakhir;

  OrderDetailVoucher(
      {this.id,
      this.durasi,
      this.expDate,
      this.harga,
      this.orderId,
      this.userId,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.masaBerlaku,
      this.dokterId,
      this.durasiPanggilan,
      this.waktuPanggilan,
      this.waktuPanggilanBerakhir});

  OrderDetailVoucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    durasi = json['durasi'];
    expDate = json['exp_date'];
    harga = json['harga'];
    orderId = json['order_id'];
    userId = json['user_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    masaBerlaku = json['masa_berlaku'];
    dokterId = json['dokter_id'];
    durasiPanggilan = json['durasi_panggilan'];
    waktuPanggilan = json['waktu_panggilan'];
    waktuPanggilanBerakhir = json['waktu_panggilan_berakhir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['durasi'] = this.durasi;
    data['exp_date'] = this.expDate;
    data['harga'] = this.harga;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['masa_berlaku'] = this.masaBerlaku;
    data['dokter_id'] = this.dokterId;
    data['durasi_panggilan'] = this.durasiPanggilan;
    data['waktu_panggilan'] = this.waktuPanggilan;
    data['waktu_panggilan_berakhir'] = this.waktuPanggilanBerakhir;
    return data;
  }
}

class StatusOrder {
  int _id;
  String _param1;
  String _param2;
  String _param3;
  Null _param4;
  String _varId;
  int _isDeleted;

  StatusOrder(
      {int id,
      String param1,
      String param2,
      String param3,
      Null param4,
      String varId,
      int isDeleted}) {
    this._id = id;
    this._param1 = param1;
    this._param2 = param2;
    this._param3 = param3;
    this._param4 = param4;
    this._varId = varId;
    this._isDeleted = isDeleted;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get param1 => _param1;
  set param1(String param1) => _param1 = param1;
  String get param2 => _param2;
  set param2(String param2) => _param2 = param2;
  String get param3 => _param3;
  set param3(String param3) => _param3 = param3;
  Null get param4 => _param4;
  set param4(Null param4) => _param4 = param4;
  String get varId => _varId;
  set varId(String varId) => _varId = varId;
  int get isDeleted => _isDeleted;
  set isDeleted(int isDeleted) => _isDeleted = isDeleted;

  StatusOrder.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _param1 = json['param_1'];
    _param2 = json['param_2'];
    _param3 = json['param_3'];
    _param4 = json['param_4'];
    _varId = json['var_id'];
    _isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['param_1'] = this._param1;
    data['param_2'] = this._param2;
    data['param_3'] = this._param3;
    data['param_4'] = this._param4;
    data['var_id'] = this._varId;
    data['is_deleted'] = this._isDeleted;
    return data;
  }
}

class TypePayment {
  int _id;
  String _param1;
  String _param2;
  String _param3;
  Null _param4;
  String _varId;
  String _isDeleted;

  TypePayment(
      {int id,
      String param1,
      String param2,
      String param3,
      Null param4,
      String varId,
      String isDeleted}) {
    this._id = id;
    this._param1 = param1;
    this._param2 = param2;
    this._param3 = param3;
    this._param4 = param4;
    this._varId = varId;
    this._isDeleted = isDeleted;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get param1 => _param1;
  set param1(String param1) => _param1 = param1;
  String get param2 => _param2;
  set param2(String param2) => _param2 = param2;
  String get param3 => _param3;
  set param3(String param3) => _param3 = param3;
  Null get param4 => _param4;
  set param4(Null param4) => _param4 = param4;
  String get varId => _varId;
  set varId(String varId) => _varId = varId;
  String get isDeleted => _isDeleted;
  set isDeleted(String isDeleted) => _isDeleted = isDeleted;

  TypePayment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _param1 = json['param_1'];
    _param2 = json['param_2'];
    _param3 = json['param_3'];
    _param4 = json['param_4'];
    _varId = json['var_id'];
    _isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['param_1'] = this._param1;
    data['param_2'] = this._param2;
    data['param_3'] = this._param3;
    data['param_4'] = this._param4;
    data['var_id'] = this._varId;
    data['is_deleted'] = this._isDeleted;
    return data;
  }
}

class MidtransRaw {
  String statusCode;
  String statusMessage;
  String transactionId;
  String orderId;
  String merchantId;
  String grossAmount;
  String currency;
  String paymentType;
  String transactionTime;
  String transactionStatus;
  String fraudStatus;
  List<Actions> actions;

  MidtransRaw(
      {this.statusCode,
      this.statusMessage,
      this.transactionId,
      this.orderId,
      this.merchantId,
      this.grossAmount,
      this.currency,
      this.paymentType,
      this.transactionTime,
      this.transactionStatus,
      this.fraudStatus,
      this.actions});

  MidtransRaw.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    transactionId = json['transaction_id'];
    orderId = json['order_id'];
    merchantId = json['merchant_id'];
    grossAmount = json['gross_amount'];
    currency = json['currency'];
    paymentType = json['payment_type'];
    transactionTime = json['transaction_time'];
    transactionStatus = json['transaction_status'];
    fraudStatus = json['fraud_status'];
    if (json['actions'] != null) {
      actions = new List<Actions>();
      json['actions'].forEach((v) {
        actions.add(new Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['transaction_id'] = this.transactionId;
    data['order_id'] = this.orderId;
    data['merchant_id'] = this.merchantId;
    data['gross_amount'] = this.grossAmount;
    data['currency'] = this.currency;
    data['payment_type'] = this.paymentType;
    data['transaction_time'] = this.transactionTime;
    data['transaction_status'] = this.transactionStatus;
    data['fraud_status'] = this.fraudStatus;
    if (this.actions != null) {
      data['actions'] = this.actions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String name;
  String method;
  String url;

  Actions({this.name, this.method, this.url});

  Actions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    method = json['method'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['method'] = this.method;
    data['url'] = this.url;
    return data;
  }
}
