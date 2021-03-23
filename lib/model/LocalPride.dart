import 'package:ponny/model/Brand.dart';

import 'Product.dart';

class LocalPrideResult{
  String banner;
  List<Brand> brands=[];
  List<Products> products;

  LocalPrideResult({this.banner,this.brands, this.products});

  LocalPrideResult.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] != null ? json['banner']['photo'] : null;
    if (json['brand'] != null) {
      brands = new List<Brand>();
      json['brand'].forEach((v) {
        brands.add(new Brand.fromJson(v['brand']));
      });
    }
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    } 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  List<String> photos;
  String thumbnailImage;
  String featuredImage;
  String flashDealImage;
  int basePrice;
  int baseDiscountedPrice;
  int todaysDeal;
  int featured;
  String unit;
  int discount;
  String discountType;
  Null isFlashDeal;
  BrandLocal brand;
  String slug;
  Cart cart;
  int currentStock;
  String rating;
  int reviewCount;
  int sales;
  String nomerBpom;
  String description;
  String penggunaan;
  String bahanAktif;
  String komposisi;
  String homeDiscountedPrice;
  List<Varian> varian;
  Links links;

  Products(
      {this.id,
        this.name,
        this.photos,
        this.thumbnailImage,
        this.featuredImage,
        this.flashDealImage,
        this.basePrice,
        this.baseDiscountedPrice,
        this.todaysDeal,
        this.featured,
        this.unit,
        this.discount,
        this.discountType,
        this.isFlashDeal,
        this.brand,
        this.slug,
        this.cart,
        this.currentStock,
        this.rating,
        this.reviewCount,
        this.sales,
        this.nomerBpom,
        this.description,
        this.penggunaan,
        this.bahanAktif,
        this.komposisi,
        this.homeDiscountedPrice,
        this.varian,
        this.links});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photos = json['photos'].cast<String>();
    thumbnailImage = json['thumbnail_image'];
    featuredImage = json['featured_image'];
    flashDealImage = json['flash_deal_image'];
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
    todaysDeal = json['todays_deal'];
    featured = json['featured'];
    unit = json['unit'];
    discount = json['discount'];
    discountType = json['discount_type'];
    isFlashDeal = json['is_flash_deal'];
    brand = json['brand'] != null ? new BrandLocal.fromJson(json['brand']) : null;
    slug = json['slug'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    currentStock = json['current_stock'];
    rating = json['rating'].toString();
    reviewCount = json['review_count'];
    sales = json['sales'];
    nomerBpom = json['nomer_bpom'];
    description = json['description'];
    penggunaan = json['penggunaan'];
    bahanAktif = json['bahan_aktif'];
    komposisi = json['komposisi'];
    homeDiscountedPrice = json['home_discounted_price'];
    if (json['varian'] != null) {
      varian = new List<Varian>();
      json['varian'].forEach((v) {
        varian.add(new Varian.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photos'] = this.photos;
    data['thumbnail_image'] = this.thumbnailImage;
    data['featured_image'] = this.featuredImage;
    data['flash_deal_image'] = this.flashDealImage;
    data['base_price'] = this.basePrice;
    data['base_discounted_price'] = this.baseDiscountedPrice;
    data['todays_deal'] = this.todaysDeal;
    data['featured'] = this.featured;
    data['unit'] = this.unit;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['is_flash_deal'] = this.isFlashDeal;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['slug'] = this.slug;
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    data['current_stock'] = this.currentStock;
    data['rating'] = this.rating;
    data['review_count'] = this.reviewCount;
    data['sales'] = this.sales;
    data['nomer_bpom'] = this.nomerBpom;
    data['description'] = this.description;
    data['penggunaan'] = this.penggunaan;
    data['bahan_aktif'] = this.bahanAktif;
    data['komposisi'] = this.komposisi;
    data['home_discounted_price'] = this.homeDiscountedPrice;
    if (this.varian != null) {
      data['varian'] = this.varian.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class BrandLocal {
  int id;
  String name;
  String logo;
  int top;
  String slug;
  Null metaTitle;
  String metaDescription;
  String createdAt;
  String updatedAt;
  String jenis;
  Null description;
  String banner;

  BrandLocal(
      {this.id,
        this.name,
        this.logo,
        this.top,
        this.slug,
        this.metaTitle,
        this.metaDescription,
        this.createdAt,
        this.updatedAt,
        this.jenis,
        this.description,
        this.banner});

  BrandLocal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    top = json['top'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jenis = json['jenis'];
    description = json['description'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['top'] = this.top;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['jenis'] = this.jenis;
    data['description'] = this.description;
    data['banner'] = this.banner;
    return data;
  }
}

class Cart {
  int id;
  int userId;
  int productId;
  String variation;
  int price;
  int tax;
  int shippingCost;
  int quantity;
  String createdAt;
  String updatedAt;

  Cart(
      {this.id,
        this.userId,
        this.productId,
        this.variation,
        this.price,
        this.tax,
        this.shippingCost,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['variation'] = this.variation;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Varian {
  String attributeId;
  List<String> values;
  String atributName;

  Varian({this.attributeId, this.values, this.atributName});

  Varian.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    values = json['values'].cast<String>();
    atributName = json['atribut_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    data['values'] = this.values;
    data['atribut_name'] = this.atributName;
    return data;
  }
}

class Links {
  String details;
  String reviews;
  String related;
  String topFromSeller;

  Links({this.details, this.reviews, this.related, this.topFromSeller});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    reviews = json['reviews'];
    related = json['related'];
    topFromSeller = json['top_from_seller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['reviews'] = this.reviews;
    data['related'] = this.related;
    data['top_from_seller'] = this.topFromSeller;
    return data;
  }
}