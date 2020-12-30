class StockVariant {
  int id;
  int productId;
  String variant;
  String sku;
  int price;
  int qty;
  String createdAt;
  String updatedAt;
  String image;

  StockVariant(
      {this.id,
        this.productId,
        this.variant,
        this.sku,
        this.price,
        this.qty,
        this.createdAt,
        this.updatedAt,
        this.image});

  StockVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    variant = json['variant'];
    sku = json['sku'];
    price = json['price'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['variant'] = this.variant;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
