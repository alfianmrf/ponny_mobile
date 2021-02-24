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
  int maxUsage;
  int aktif;
  int maxAtUser;
  int visible;
  DecodeDetail decodeDetail;

  Coupons(
      {this.id,
        this.type,
        this.code,
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
        this.syarat,
        this.maxUsage,
        this.aktif,
        this.maxAtUser,
        this.visible,
        this.decodeDetail});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
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
    maxUsage = json['max_usage'];
    aktif = json['aktif'];
    maxAtUser = json['max_at_user'];
    visible = json['visible'];
    decodeDetail = json['decode_detail'] != null
        ? new DecodeDetail.fromJson(json['decode_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['code'] = this.code;
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
    data['max_usage'] = this.maxUsage;
    data['aktif'] = this.aktif;
    data['max_at_user'] = this.maxAtUser;
    data['visible'] = this.visible;
    if (this.decodeDetail != null) {
      data['decode_detail'] = this.decodeDetail.toJson();
    }
    return data;
  }
}

class DecodeDetail {
  List<String> categoryId;
  List<String> subcategoryId;
  List<String> subsubcategoryId;
  List<String> productId;
  String minBuy;
  String maxDiscount;

  DecodeDetail(
      {this.categoryId,
        this.subcategoryId,
        this.subsubcategoryId,
        this.productId,
        this.minBuy,
        this.maxDiscount});

  DecodeDetail.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'].cast<String>();
    subcategoryId = json['subcategory_id'].cast<String>();
    subsubcategoryId = json['subsubcategory_id'].cast<String>();
    productId = json['product_id'].cast<String>();
    minBuy = json['min_buy'];
    maxDiscount = json['max_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subsubcategory_id'] = this.subsubcategoryId;
    data['product_id'] = this.productId;
    data['min_buy'] = this.minBuy;
    data['max_discount'] = this.maxDiscount;
    return data;
  }
}

class Promotions {
  int id;
  String banner;
  String caption;
  String createdAt;
  String updatedAt;
  String metaDescription;
  String thumbnail;
  String slug;

  Promotions(
      {this.id,
        this.banner,
        this.caption,
        this.createdAt,
        this.updatedAt,
        this.metaDescription,
        this.thumbnail,
        this.slug});

  Promotions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    caption = json['caption'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    metaDescription = json['meta_description'];
    thumbnail = json['thumbnail'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['caption'] = this.caption;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['meta_description'] = this.metaDescription;
    data['thumbnail'] = this.thumbnail;
    data['slug'] = this.slug;
    return data;
  }
}