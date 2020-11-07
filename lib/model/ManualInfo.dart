class ManualInfo {
  int id;
  int userId;
  String paymentType;
  String paymentStatus;
  int grandTotal;
  int couponDiscount;
  String code;
  String deliveryStatus;
  int userConfrimOrder;
  int uniqTfManual;
  int freeOngkir;
  int isProductDigital;
  String an;
  String norek;
  String path;
  String ygHarusDibayar;
  int subtotal;
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
