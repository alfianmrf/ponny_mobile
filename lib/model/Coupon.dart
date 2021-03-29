class Coupon {
  int coupon_id;
  String code;
  String type;
  int discount;
  String calculated;
  String message;

  Coupon(
      {this.coupon_id,
        this.code,
        this.type,
        this.discount,
        this.calculated,
        this.message});

  Coupon.fromJson(Map<String, dynamic> json) {
    coupon_id = json['coupon_id'] != null
        ? json['coupon_id']
        : null;
    code = json['code'] != null
      ? json['code']
      : null;
    type = json['type'] != null
        ? json['type']
        : null;
    discount = json['discount'] != null
        ? json['discount']
        : null;
    calculated = json['calculated'] != null
        ? json['calculated'].toString()
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupon_id != null) {
      data['coupon_id'] = this.coupon_id;
    }
    else{
      data['coupon_id'] = null;
    }
    if (this.code != null) {
      data['code'] = this.code;
    }
    if (this.type != null) {
      data['type'] = this.type;
    }
    if (this.discount != null) {
      data['discount'] = this.discount;
    }
    if (this.calculated != null) {
      data['calculated'] = this.calculated;
    }
    data['message'] = this.message;
    return data;
  }
}
