class Coupon{
  int coupon_id;
  String type;
  int discount;
  String code;

  Coupon(this.coupon_id, this.type, this.discount,this.code);

  factory Coupon.fromJson(Map<String, dynamic> parsedJson){
    return Coupon(parsedJson["coupon_id"], parsedJson["type"], parsedJson["discount"],parsedJson['code']);
  }
}