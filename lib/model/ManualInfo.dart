import 'package:ponny/model/ClaimPointHarian.dart';
import 'dart:convert';
class ManualInfo {
  var id;
  var userId;
  String paymentType;
  String paymentStatus;
  var grandTotal;
  var couponDiscount;
  String code;
  String deliveryStatus;
  var userConfrimOrder;
  var uniqTfManual;
  var freeOngkir;
  var isProductDigital;
  String an;
  String norek;
  String path;
  String ygHarusDibayar;
  var subtotal;
  String typePayment;
  OrderConfrim orderConfrim;

  ManualInfo(
      {this.id,
        this.userId,
        this.paymentType,
        this.paymentStatus,
        this.grandTotal,
        this.couponDiscount,
        this.code,
        this.deliveryStatus,
        this.userConfrimOrder,
        this.uniqTfManual,
        this.freeOngkir,
        this.isProductDigital,
        this.an,
        this.norek,
        this.path,
        this.ygHarusDibayar,
        this.subtotal,
        this.typePayment,
        this.orderConfrim
      });

  ManualInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    grandTotal = json['grand_total'];
    couponDiscount = json['coupon_discount'];
    code = json['code'];
    deliveryStatus = json['delivery_status'];
    userConfrimOrder = json['user_confrim_order'];
    uniqTfManual = json['uniq_tf_manual'];
    freeOngkir = json['free_ongkir'];
    isProductDigital = json['is_product_digital'];
    an = json['an'];
    norek = json['norek'];
    path = json['path'];
    ygHarusDibayar = json['yg_harus_dibayar'];
    subtotal = json['subtotal'];
    typePayment= json['type_payment']['param_2'];
    orderConfrim = json['order_confrim'] != null
        ? new OrderConfrim.fromJson(json['order_confrim'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['grand_total'] = this.grandTotal;
    data['coupon_discount'] = this.couponDiscount;
    data['code'] = this.code;
    data['delivery_status'] = this.deliveryStatus;
    data['user_confrim_order'] = this.userConfrimOrder;
    data['uniq_tf_manual'] = this.uniqTfManual;
    data['free_ongkir'] = this.freeOngkir;
    data['is_product_digital'] = this.isProductDigital;
    data['an'] = this.an;
    data['norek'] = this.norek;
    data['path'] = this.path;
    data['yg_harus_dibayar'] = this.ygHarusDibayar;
    data['subtotal'] = this.subtotal;
    if (this.orderConfrim != null) {
      data['order_confrim'] = this.orderConfrim.toJson();
    }
    return data;
  }
}

class OrderConfrim {
  int id;
  String uploadImg;
  String noRek;
  String anRek;
  String bank;
  String createdAt;
  String updatedAt;
  int orderId;

  OrderConfrim(
      {this.id,
        this.uploadImg,
        this.noRek,
        this.anRek,
        this.bank,
        this.createdAt,
        this.updatedAt,
        this.orderId});

  OrderConfrim.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadImg = json['upload_img'];
    noRek = json['no_rek'];
    anRek = json['an_rek'];
    bank = json['bank'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upload_img'] = this.uploadImg;
    data['no_rek'] = this.noRek;
    data['an_rek'] = this.anRek;
    data['bank'] = this.bank;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_id'] = this.orderId;
    return data;
  }
}



// NEW MANUAL Info
NewManualInfo newManualInfoFromJson(String str) => NewManualInfo.fromJson(json.decode(str));

String newManualInfoToJson(NewManualInfo data) => json.encode(data.toJson());

class NewManualInfo {
  NewManualInfo({
    this.id,
    this.userId,
    this.guestId,
    this.shippingAddress,
    this.paymentStatus,
    this.paymentDetails,
    this.grandTotal,
    this.couponDiscount,
    this.code,
    this.date,
    this.viewed,
    this.deliveryViewed,
    this.paymentStatusViewed,
    this.commissionCalculated,
    this.createdAt,
    this.updatedAt,
    this.customerAddresId,
    this.shippingInfo,
    this.mitransVal,
    this.confrimCourier,
    this.confrimResi,
    this.deliveryStatus,
    this.userConfrimOrder,
    this.uniqTfManual,
    this.freeOngkir,
    this.tglTerkirim,
    this.deliveryInfo,
    this.userConfrimDate,
    this.isProductDigital,
    this.dapatPoint,
    this.kupon,
    this.poinDipakai,
    this.cabangId,
    this.packingStatus,
    this.an,
    this.norek,
    this.path,
    this.ygHarusDibayar,
    this.jumlah,
    this.statusOrder,
    this.encrid,
    this.deliveryStts,
    this.complain,
    this.typePayment,
    this.orderConfrim,
    this.orderDetails,
    this.komplain,
  });

  int id;
  String userId;
  dynamic guestId;
  dynamic shippingAddress;
  String paymentType;
  String paymentStatus;
  dynamic paymentDetails;
  String grandTotal;
  String couponDiscount;
  String code;
  String date;
  String viewed;
  String deliveryViewed;
  String paymentStatusViewed;
  String commissionCalculated;
  DateTime createdAt;
  DateTime updatedAt;
  String customerAddresId;
  String shippingInfo;
  dynamic mitransVal;
  dynamic confrimCourier;
  dynamic confrimResi;
  String deliveryStatus;
  String userConfrimOrder;
  String uniqTfManual;
  String freeOngkir;
  dynamic tglTerkirim;
  dynamic deliveryInfo;
  dynamic userConfrimDate;
  String isProductDigital;
  String dapatPoint;
  String kupon;
  String poinDipakai;
  dynamic cabangId;
  dynamic packingStatus;
  String an;
  String norek;
  String path;
  String ygHarusDibayar;
  String jumlah;
  String statusOrder;
  String encrid;
  String deliveryStts;
  String complain;
  String typePayment;
  dynamic orderConfrim;
  List<OrderDetail> orderDetails;
  List<dynamic> komplain;

  factory NewManualInfo.fromJson(Map<String, dynamic> json) => NewManualInfo(
    id: json["id"],
    userId: json["user_id"],
    guestId: json["guest_id"],
    shippingAddress: json["shipping_address"],
    paymentStatus: json["payment_status"],
    paymentDetails: json["payment_details"],
    grandTotal: json["grand_total"],
    couponDiscount: json["coupon_discount"],
    code: json["code"],
    date: json["date"],
    viewed: json["viewed"],
    deliveryViewed: json["delivery_viewed"],
    paymentStatusViewed: json["payment_status_viewed"],
    commissionCalculated: json["commission_calculated"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customerAddresId: json["customer_addres_id"],
    shippingInfo: json["shipping_info"],
    mitransVal: json["mitrans_val"],
    confrimCourier: json["confrim_courier"],
    confrimResi: json["confrim_resi"],
    deliveryStatus: json["delivery_status"],
    userConfrimOrder: json["user_confrim_order"],
    uniqTfManual: json["uniq_tf_manual"],
    freeOngkir: json["free_ongkir"],
    tglTerkirim: json["tgl_terkirim"],
    deliveryInfo: json["delivery_info"],
    userConfrimDate: json["user_confrim_date"],
    isProductDigital: json["is_product_digital"],
    dapatPoint: json["dapat_point"],
    kupon: json["kupon"],
    poinDipakai: json["poin_dipakai"],
    cabangId: json["cabang_id"],
    packingStatus: json["packing_status"],
    an: json["an"],
    norek: json["norek"],
    path: json["path"],
    ygHarusDibayar: json["yg_harus_dibayar"],
    jumlah: json["jumlah"],
    statusOrder: json["status_order"],
    encrid: json["encrid"],
    deliveryStts: json["delivery_stts"],
    complain: json["complain"],
    typePayment: json["type_payment"]["param_2"],
    orderConfrim: json["order_confrim"],
    orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
    komplain: List<dynamic>.from(json["komplain"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "guest_id": guestId,
    "shipping_address": shippingAddress,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "payment_details": paymentDetails,
    "grand_total": grandTotal,
    "coupon_discount": couponDiscount,
    "code": code,
    "date": date,
    "viewed": viewed,
    "delivery_viewed": deliveryViewed,
    "payment_status_viewed": paymentStatusViewed,
    "commission_calculated": commissionCalculated,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "customer_addres_id": customerAddresId,
    "shipping_info": shippingInfo,
    "mitrans_val": mitransVal,
    "confrim_courier": confrimCourier,
    "confrim_resi": confrimResi,
    "delivery_status": deliveryStatus,
    "user_confrim_order": userConfrimOrder,
    "uniq_tf_manual": uniqTfManual,
    "free_ongkir": freeOngkir,
    "tgl_terkirim": tglTerkirim,
    "delivery_info": deliveryInfo,
    "user_confrim_date": userConfrimDate,
    "is_product_digital": isProductDigital,
    "dapat_point": dapatPoint,
    "kupon": kupon,
    "poin_dipakai": poinDipakai,
    "cabang_id": cabangId,
    "packing_status": packingStatus,
    "an": an,
    "norek": norek,
    "path": path,
    "yg_harus_dibayar": ygHarusDibayar,
    "jumlah": jumlah,
    "status_order": statusOrder,
    "encrid": encrid,
    "delivery_stts": deliveryStts,
    "complain": complain,
    "type_payment": typePayment,
    "order_confrim": orderConfrim,
    "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    "komplain": List<dynamic>.from(komplain.map((x) => x)),
  };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.orderId,
    this.sellerId,
    this.productId,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.paymentStatus,
    this.deliveryStatus,
    this.shippingType,
    this.pickupPointId,
    this.productReferralCode,
    this.createdAt,
    this.updatedAt,
    this.reviewId,
    this.arrivalDetailRefund,
    this.reviewed,
  });

  int id;
  String orderId;
  String sellerId;
  String productId;
  String variation;
  String price;
  String tax;
  String shippingCost;
  String quantity;
  String paymentStatus;
  String deliveryStatus;
  dynamic shippingType;
  dynamic pickupPointId;
  dynamic productReferralCode;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic reviewId;
  String arrivalDetailRefund;
  String reviewed;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderId: json["order_id"],
    sellerId: json["seller_id"],
    productId: json["product_id"],
    variation: json["variation"],
    price: json["price"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    quantity: json["quantity"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
    shippingType: json["shipping_type"],
    pickupPointId: json["pickup_point_id"],
    productReferralCode: json["product_referral_code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    reviewId: json["review_id"],
    arrivalDetailRefund: json["arrival_detail_refund"],
    reviewed: json["reviewed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "seller_id": sellerId,
    "product_id": productId,
    "variation": variation,
    "price": price,
    "tax": tax,
    "shipping_cost": shippingCost,
    "quantity": quantity,
    "payment_status": paymentStatus,
    "delivery_status": deliveryStatus,
    "shipping_type": shippingType,
    "pickup_point_id": pickupPointId,
    "product_referral_code": productReferralCode,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "review_id": reviewId,
    "arrival_detail_refund": arrivalDetailRefund,
    "reviewed": reviewed,
  };
}

class TypePayment {
  TypePayment({
    this.id,
    this.param1,
    this.param2,
    this.param3,
    this.param4,
    this.varId,
    this.isDeleted,
  });

  int id;
  String param1;
  String param2;
  dynamic param3;
  dynamic param4;
  String varId;
  String isDeleted;

  factory TypePayment.fromJson(Map<String, dynamic> json) => TypePayment(
    id: json["id"],
    param1: json["param_1"],
    param2: json["param_2"],
    param3: json["param_3"],
    param4: json["param_4"],
    varId: json["var_id"],
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "param_1": param1,
    "param_2": param2,
    "param_3": param3,
    "param_4": param4,
    "var_id": varId,
    "is_deleted": isDeleted,
  };
}
