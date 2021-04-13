class ProductFlashDeal{
  int id;
  int product_id;
  int discount;
  String discount_type;
  int stock;
  int num_of_sale;
  ProductFlashDeal(this.id, this.product_id, this.discount, this.discount_type, this.stock, this.num_of_sale);
  factory ProductFlashDeal.fromJson(Map<String, dynamic> parsedJson){
    return ProductFlashDeal(parsedJson["id"], parsedJson["product_id"], parsedJson["discount"], parsedJson["discount_type"], parsedJson["stock"], parsedJson["num_of_sale"]);
  }
}