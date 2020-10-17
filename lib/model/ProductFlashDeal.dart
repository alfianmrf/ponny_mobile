class ProductFlashDeal{
  int id;
  int product_id;
  int discount;
  String discount_type;
  ProductFlashDeal(this.id, this.product_id, this.discount, this.discount_type);
  factory ProductFlashDeal.fromJson(Map<String, dynamic> parsedJson){
    return ProductFlashDeal(parsedJson["id"], parsedJson["product_id"], parsedJson["discount"], parsedJson["discount_type"]);
  }
}