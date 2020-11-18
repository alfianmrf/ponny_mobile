class PromotionResult {
  List<Coupons> coupons;
  List<Promotions> promotions;

  PromotionResult({this.coupons, this.promotions});

  PromotionResult.fromJson(Map<String, dynamic> json) {
    if (json['coupons'] != null) {
      coupons = new List<Coupons>();

      json['coupons'].forEach((v) {
        coupons.add(new Coupons.fromJson(v));
      });
    }
    if (json['promotions'] != null) {
      promotions = new List<Promotions>();
      json['promotions'].forEach((v) {
        promotions.add(new Promotions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupons != null) {
      data['coupons'] = this.coupons.map((v) => v.toJson()).toList();
    }
    if (this.promotions != null) {
      data['promotions'] = this.promotions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int id;
  String type;
  String code;
  Details details;
  int discount;
  String discountType;
  int startDate;
  int endDate;
  String createdAt;
  String updatedAt;
  String banner;
  String statusCode;
  String title;
  String keterangan;
  List<String> syarat;

  Coupons(
      {this.id,
        this.type,
        this.code,
        this.details,
        this.discount,
        this.discountType,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt,
        this.banner,
        this.statusCode,
        this.title,
        this.keterangan,
        this.syarat});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    discount = json['discount'];
    discountType = json['discount_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    statusCode = json['status_code'];
    title = json['title'];
    keterangan = json['keterangan'];
    syarat = json['syarat'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['code'] = this.code;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    data['status_code'] = this.statusCode;
    data['title'] = this.title;
    data['keterangan'] = this.keterangan;
    data['syarat'] = this.syarat;
    return data;
  }
}

class Details {
  int minBuy;
  int maxDiscount;

  Details({this.minBuy, this.maxDiscount});

  Details.fromJson(Map<String, dynamic> json) {
    minBuy = int.parse(json['min_buy']);
    maxDiscount = int.parse(json['max_discount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_buy'] = this.minBuy;
    data['max_discount'] = this.maxDiscount;
    return data;
  }
}

class Promotions {
  int id;
  String banner;
  String caption;

  Promotions({this.id, this.banner, this.caption});

  Promotions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['caption'] = this.caption;
    return data;
  }
}
