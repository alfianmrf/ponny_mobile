import 'package:ponny/model/Product.dart';


class FlashDetail{
  FlashDeal detail;
  List<FlashSaleProduct> flash_products;
  FlashDetail({this.detail,this.flash_products});
  FlashDetail.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null ? FlashDeal.fromJson(json['detail']) : null;
    if (json['flash_products'] != null) {
      flash_products = new List<FlashSaleProduct>();
      json['flash_products']["data"].forEach((v) {
        flash_products.add(new FlashSaleProduct.fromJson(v));
      });
    }
  }
}
class FlashDeal {
  int id;
  String title;
  int startDate;
  int endDate;
  int status;
  int featured;
  String backgroundColor;
  String textColor;
  String banner;
  String slug;
  String createdAt;
  String updatedAt;

  FlashDeal(
      {this.id,
        this.title,
        this.startDate,
        this.endDate,
        this.status,
        this.featured,
        this.backgroundColor,
        this.textColor,
        this.banner,
        this.slug,
        this.createdAt,
        this.updatedAt});

  FlashDeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    featured = json['featured'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
    banner = json['banner'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['background_color'] = this.backgroundColor;
    data['text_color'] = this.textColor;
    data['banner'] = this.banner;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class FlashSaleProduct {
  int id;
  int flashDealId;
  int productId;
  int discount;
  String discountType;
  int qty;
  int percentase;
  Product product;

  FlashSaleProduct(
      {this.id,
        this.flashDealId,
        this.productId,
        this.discount,
        this.discountType,
        this.qty,
        this.percentase,
      this.product});

  FlashSaleProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flashDealId = json['flash_deal_id'];
    productId = json['product_id'];
    discount = json['discount'];
    discountType = json['discount_type'];
    qty = json['qty'];
    percentase = json['percentase'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flash_deal_id'] = this.flashDealId;
    data['product_id'] = this.productId;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['qty'] = this.qty;
    data['percentase'] = this.percentase;
    return data;
  }
}
