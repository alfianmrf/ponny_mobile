class DetailForumModel {
  Forum forum;
  bool seen;

  DetailForumModel({this.forum, this.seen});

  DetailForumModel.fromJson(Map<String, dynamic> json) {
    forum = json['forum'] != null ? new Forum.fromJson(json['forum']) : null;
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forum != null) {
      data['forum'] = this.forum.toJson();
    }
    data['seen'] = this.seen;
    return data;
  }
}

class Forum {
  int id;
  String title;
  String text;
  String thumbnail;
  int userId;
  int roomId;
  String createdAt;
  String updatedAt;
  String slug;
  Room room;
  User user;
  List<Reply> reply;
  List<Like> like;
  List<Seen> seen;

  Forum(
      {this.id,
      this.title,
      this.text,
      this.thumbnail,
      this.userId,
      this.roomId,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.room,
      this.user,
      this.reply,
      this.like,
      this.seen});

  Forum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    thumbnail = json['thumbnail'];
    userId = json['user_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['reply'] != null) {
      reply = new List<Reply>();
      json['reply'].forEach((v) {
        reply.add(new Reply.fromJson(v));
      });
    }
    if (json['like'] != null) {
      like = new List<Like>();
      json['like'].forEach((v) {
        like.add(new Like.fromJson(v));
      });
    }
    if (json['seen'] != null) {
      seen = new List<Seen>();
      json['seen'].forEach((v) {
        seen.add(new Seen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['thumbnail'] = this.thumbnail;
    data['user_id'] = this.userId;
    data['room_id'] = this.roomId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    if (this.room != null) {
      data['room'] = this.room.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.reply != null) {
      data['reply'] = this.reply.map((v) => v.toJson()).toList();
    }
    if (this.like != null) {
      data['like'] = this.like.map((v) => v.toJson()).toList();
    }
    if (this.seen != null) {
      data['seen'] = this.seen.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Room {
  int id;
  String title;
  String subTitle;
  String img;
  int topicsId;
  String createdAt;
  String updatedAt;

  Room(
      {this.id,
      this.title,
      this.subTitle,
      this.img,
      this.topicsId,
      this.createdAt,
      this.updatedAt});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    img = json['img'];
    topicsId = json['topics_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['img'] = this.img;
    data['topics_id'] = this.topicsId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int id;
  String referredBy;
  String providerId;
  String userType;
  String name;
  String email;
  String emailVerifiedAt;
  String avatar;
  String avatarOriginal;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;
  double balance;
  String referralCode;
  String customerPackageId;
  double remainingUploads;
  String createdAt;
  String updatedAt;
  String lastName;
  String gender;
  String tglLahir;
  double jenisKulit;
  String warnaKulit;
  String kondisiKulit;
  String kondisiRambut;
  String preferensiProduct;
  String fbtoken;
  double point;
  double tier;
  double completedProfile;
  UserTier userTier;

  User(
      {this.id,
      this.referredBy,
      this.providerId,
      this.userType,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.avatar,
      this.avatarOriginal,
      this.address,
      this.country,
      this.city,
      this.postalCode,
      this.phone,
      this.balance,
      this.referralCode,
      this.customerPackageId,
      this.remainingUploads,
      this.createdAt,
      this.updatedAt,
      this.lastName,
      this.gender,
      this.tglLahir,
      this.jenisKulit,
      this.warnaKulit,
      this.kondisiKulit,
      this.kondisiRambut,
      this.preferensiProduct,
      this.fbtoken,
      this.point,
      this.tier,
      this.completedProfile,
      this.userTier});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referredBy = json['referred_by'];
    providerId = json['provider_id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    balance = json['balance'];
    referralCode = json['referral_code'];
    customerPackageId = json['customer_package_id'];
    remainingUploads = json['remaining_uploads'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastName = json['last_name'];
    gender = json['gender'];
    tglLahir = json['tgl_lahir'];
    jenisKulit = json['jenis_kulit'];
    warnaKulit = json['warna_kulit'];
    kondisiKulit = json['kondisi_kulit'];
    kondisiRambut = json['kondisi_rambut'];
    preferensiProduct = json['preferensi_product'];
    fbtoken = json['fbtoken'];
    point = json['point'];
    tier = json['tier'];
    completedProfile = json['completed_profile'];
    userTier = json['user_tier'] != null
        ? new UserTier.fromJson(json['user_tier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referred_by'] = this.referredBy;
    data['provider_id'] = this.providerId;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    data['referral_code'] = this.referralCode;
    data['customer_package_id'] = this.customerPackageId;
    data['remaining_uploads'] = this.remainingUploads;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['tgl_lahir'] = this.tglLahir;
    data['jenis_kulit'] = this.jenisKulit;
    data['warna_kulit'] = this.warnaKulit;
    data['kondisi_kulit'] = this.kondisiKulit;
    data['kondisi_rambut'] = this.kondisiRambut;
    data['preferensi_product'] = this.preferensiProduct;
    data['fbtoken'] = this.fbtoken;
    data['point'] = this.point;
    data['tier'] = this.tier;
    data['completed_profile'] = this.completedProfile;
    if (this.userTier != null) {
      data['user_tier'] = this.userTier.toJson();
    }
    return data;
  }
}

class UserTier {
  int id;
  String title;
  double min;
  double period;
  double periodUnit;
  String createdAt;
  String updatedAt;
  int isProductIstimewa;
  int isKuponUltah;
  int isProductSpesial;
  double poinOrder;
  double freeShipingCost;
  double freeShipingMinOrder;
  String icon;

  UserTier(
      {this.id,
      this.title,
      this.min,
      this.period,
      this.periodUnit,
      this.createdAt,
      this.updatedAt,
      this.isProductIstimewa,
      this.isKuponUltah,
      this.isProductSpesial,
      this.poinOrder,
      this.freeShipingCost,
      this.freeShipingMinOrder,
      this.icon});

  UserTier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    min = json['min'];
    period = json['period'];
    periodUnit = json['period_unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProductIstimewa = json['is_product_istimewa'];
    isKuponUltah = json['is_kupon_ultah'];
    isProductSpesial = json['is_product_spesial'];
    poinOrder = json['poin_order'];
    freeShipingCost = json['free_shiping_cost'];
    freeShipingMinOrder = json['free_shiping_min_order'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['min'] = this.min;
    data['period'] = this.period;
    data['period_unit'] = this.periodUnit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_product_istimewa'] = this.isProductIstimewa;
    data['is_kupon_ultah'] = this.isKuponUltah;
    data['is_product_spesial'] = this.isProductSpesial;
    data['poin_order'] = this.poinOrder;
    data['free_shiping_cost'] = this.freeShipingCost;
    data['free_shiping_min_order'] = this.freeShipingMinOrder;
    data['icon'] = this.icon;
    return data;
  }
}

class Reply {
  int id;
  String text;
  int postId;
  int userId;
  String createdAt;
  String updatedAt;
  double notifiable;
  Users user;
  List<Rekomendasi> rekomendasi;

  Reply(
      {this.id,
      this.text,
      this.postId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.notifiable,
      this.user,
      this.rekomendasi});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    postId = json['post_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notifiable = json['notifiable'];
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    if (json['rekomendasi'] != null) {
      rekomendasi = new List<Rekomendasi>();
      json['rekomendasi'].forEach((v) {
        rekomendasi.add(new Rekomendasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['notifiable'] = this.notifiable;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.rekomendasi != null) {
      data['rekomendasi'] = this.rekomendasi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int id;
  String referredBy;
  String providerId;
  String userType;
  String name;
  String email;
  String emailVerifiedAt;
  String avatar;
  String avatarOriginal;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;
  double balance;
  String referralCode;
  String customerPackageId;
  double remainingUploads;
  String createdAt;
  String updatedAt;
  String lastName;
  String gender;
  String tglLahir;
  double jenisKulit;
  double warnaKulit;
  String kondisiKulit;
  String kondisiRambut;
  String preferensiProduct;
  String fbtoken;
  double point;
  double tier;
  double completedProfile;

  Users(
      {this.id,
      this.referredBy,
      this.providerId,
      this.userType,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.avatar,
      this.avatarOriginal,
      this.address,
      this.country,
      this.city,
      this.postalCode,
      this.phone,
      this.balance,
      this.referralCode,
      this.customerPackageId,
      this.remainingUploads,
      this.createdAt,
      this.updatedAt,
      this.lastName,
      this.gender,
      this.tglLahir,
      this.jenisKulit,
      this.warnaKulit,
      this.kondisiKulit,
      this.kondisiRambut,
      this.preferensiProduct,
      this.fbtoken,
      this.point,
      this.tier,
      this.completedProfile});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referredBy = json['referred_by'];
    providerId = json['provider_id'];
    userType = json['user_type'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    balance = json['balance'];
    referralCode = json['referral_code'];
    customerPackageId = json['customer_package_id'];
    remainingUploads = json['remaining_uploads'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastName = json['last_name'];
    gender = json['gender'];
    tglLahir = json['tgl_lahir'];
    jenisKulit = json['jenis_kulit'];
    warnaKulit = json['warna_kulit'];
    kondisiKulit = json['kondisi_kulit'];
    kondisiRambut = json['kondisi_rambut'];
    preferensiProduct = json['preferensi_product'];
    fbtoken = json['fbtoken'];
    point = json['point'];
    tier = json['tier'];
    completedProfile = json['completed_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referred_by'] = this.referredBy;
    data['provider_id'] = this.providerId;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    data['referral_code'] = this.referralCode;
    data['customer_package_id'] = this.customerPackageId;
    data['remaining_uploads'] = this.remainingUploads;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['tgl_lahir'] = this.tglLahir;
    data['jenis_kulit'] = this.jenisKulit;
    data['warna_kulit'] = this.warnaKulit;
    data['kondisi_kulit'] = this.kondisiKulit;
    data['kondisi_rambut'] = this.kondisiRambut;
    data['preferensi_product'] = this.preferensiProduct;
    data['fbtoken'] = this.fbtoken;
    data['point'] = this.point;
    data['tier'] = this.tier;
    data['completed_profile'] = this.completedProfile;
    return data;
  }
}

class Rekomendasi {
  int id;
  int productId;
  int replyId;
  String createdAt;
  String updatedAt;
  Product product;

  Rekomendasi(
      {this.id,
      this.productId,
      this.replyId,
      this.createdAt,
      this.updatedAt,
      this.product});

  Rekomendasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    replyId = json['reply_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['reply_id'] = this.replyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  String tagline;
  String addedBy;
  int userId;
  int categoryId;
  int subcategoryId;
  int subsubcategoryId;
  int brandId;
  String photos;
  String thumbnailImg;
  String featuredImg;
  String flashDealImg;
  String videoProvider;
  String videoLink;
  String tags;
  String description;
  String penggunaan;
  double unitPrice;
  double purchasePrice;
  double variantProduct;
  String attributes;
  String choiceOptions;
  String colors;
  String variations;
  double todaysDeal;
  double published;
  double featured;
  double currentStock;
  String unit;
  double discount;
  String discountType;
  double tax;
  String taxType;
  String shippingType;
  double shippingCost;
  double numOfSale;
  String metaTitle;
  String metaDescription;
  String metaImg;
  String pdf;
  String slug;
  double refundable;
  double rating;
  String barcode;
  double digital;
  String fileName;
  String filePath;
  String createdAt;
  String updatedAt;
  String komposisi;
  String nomerBpom;
  String bahanAktif;
  String satuanUkuran;
  double earnPoint;
  double isSpecial;
  double isDelete;
  double isSample;
  Availability availability;
  Brand brand;
  Cart cart;
  List<Reviews> reviews;

  Product(
      {this.id,
      this.name,
      this.tagline,
      this.addedBy,
      this.userId,
      this.categoryId,
      this.subcategoryId,
      this.subsubcategoryId,
      this.brandId,
      this.photos,
      this.thumbnailImg,
      this.featuredImg,
      this.flashDealImg,
      this.videoProvider,
      this.videoLink,
      this.tags,
      this.description,
      this.penggunaan,
      this.unitPrice,
      this.purchasePrice,
      this.variantProduct,
      this.attributes,
      this.choiceOptions,
      this.colors,
      this.variations,
      this.todaysDeal,
      this.published,
      this.featured,
      this.currentStock,
      this.unit,
      this.discount,
      this.discountType,
      this.tax,
      this.taxType,
      this.shippingType,
      this.shippingCost,
      this.numOfSale,
      this.metaTitle,
      this.metaDescription,
      this.metaImg,
      this.pdf,
      this.slug,
      this.refundable,
      this.rating,
      this.barcode,
      this.digital,
      this.fileName,
      this.filePath,
      this.createdAt,
      this.updatedAt,
      this.komposisi,
      this.nomerBpom,
      this.bahanAktif,
      this.satuanUkuran,
      this.earnPoint,
      this.isSpecial,
      this.isDelete,
      this.isSample,
      this.availability,
      this.brand,
      this.cart,
      this.reviews});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryId = json['subsubcategory_id'];
    brandId = json['brand_id'];
    photos = json['photos'];
    thumbnailImg = json['thumbnail_img'];
    featuredImg = json['featured_img'];
    flashDealImg = json['flash_deal_img'];
    videoProvider = json['video_provider'];
    videoLink = json['video_link'];
    tags = json['tags'];
    description = json['description'];
    penggunaan = json['penggunaan'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    variantProduct = json['variant_product'];
    attributes = json['attributes'];
    choiceOptions = json['choice_options'];
    colors = json['colors'];
    variations = json['variations'];
    todaysDeal = json['todays_deal'];
    published = json['published'];
    featured = json['featured'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    discount = json['discount'];
    discountType = json['discount_type'];
    tax = json['tax'];
    taxType = json['tax_type'];
    shippingType = json['shipping_type'];
    shippingCost = json['shipping_cost'];
    numOfSale = json['num_of_sale'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImg = json['meta_img'];
    pdf = json['pdf'];
    slug = json['slug'];
    refundable = json['refundable'];
    rating = json['rating'];
    barcode = json['barcode'];
    digital = json['digital'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    komposisi = json['komposisi'];
    nomerBpom = json['nomer_bpom'];
    bahanAktif = json['bahan_aktif'];
    satuanUkuran = json['satuan_ukuran'];
    earnPoint = json['earn_point'];
    isSpecial = json['is_special'];
    isDelete = json['is_delete'];
    isSample = json['is_sample'];
    availability = json['availability'] != null
        ? new Availability.fromJson(json['availability'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagline'] = this.tagline;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subsubcategory_id'] = this.subsubcategoryId;
    data['brand_id'] = this.brandId;
    data['photos'] = this.photos;
    data['thumbnail_img'] = this.thumbnailImg;
    data['featured_img'] = this.featuredImg;
    data['flash_deal_img'] = this.flashDealImg;
    data['video_provider'] = this.videoProvider;
    data['video_link'] = this.videoLink;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['penggunaan'] = this.penggunaan;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['variant_product'] = this.variantProduct;
    data['attributes'] = this.attributes;
    data['choice_options'] = this.choiceOptions;
    data['colors'] = this.colors;
    data['variations'] = this.variations;
    data['todays_deal'] = this.todaysDeal;
    data['published'] = this.published;
    data['featured'] = this.featured;
    data['current_stock'] = this.currentStock;
    data['unit'] = this.unit;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['shipping_type'] = this.shippingType;
    data['shipping_cost'] = this.shippingCost;
    data['num_of_sale'] = this.numOfSale;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_img'] = this.metaImg;
    data['pdf'] = this.pdf;
    data['slug'] = this.slug;
    data['refundable'] = this.refundable;
    data['rating'] = this.rating;
    data['barcode'] = this.barcode;
    data['digital'] = this.digital;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['komposisi'] = this.komposisi;
    data['nomer_bpom'] = this.nomerBpom;
    data['bahan_aktif'] = this.bahanAktif;
    data['satuan_ukuran'] = this.satuanUkuran;
    data['earn_point'] = this.earnPoint;
    data['is_special'] = this.isSpecial;
    data['is_delete'] = this.isDelete;
    data['is_sample'] = this.isSample;
    if (this.availability != null) {
      data['availability'] = this.availability.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Availability {
  int id;
  String name;
  List<String> photos;
  String thumbnailImage;
  String featuredImage;
  String flashDealImage;
  double basePrice;
  double baseDiscountedPrice;
  double todaysDeal;
  double featured;
  String unit;
  double discount;
  String discountType;
  String isFlashDeal;
  Brand brand;
  String slug;
  Cart cart;
  double currentStock;
  double rating;
  double reviewCount;
  double sales;
  String nomerBpom;
  String description;
  String penggunaan;
  String bahanAktif;
  String komposisi;
  String homeDiscountedPrice;
  List<Varian> varian;
  Links links;

  Availability(
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

  Availability.fromJson(Map<String, dynamic> json) {
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
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    slug = json['slug'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    currentStock = json['current_stock'];
    rating = json['rating'];
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

class Brand {
  int id;
  String name;
  String logo;
  double top;
  String slug;
  String metaTitle;
  String metaDescription;
  String createdAt;
  String updatedAt;
  String jenis;
  String description;
  String banner;

  Brand(
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

  Brand.fromJson(Map<String, dynamic> json) {
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
  double price;
  double tax;
  double shippingCost;
  double quantity;
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

class Reviews {
  int id;
  int productId;
  int userId;
  double ratingKemasan;
  String comment;
  double status;
  double viewed;
  String createdAt;
  String updatedAt;
  double ratingKegunaan;
  double ratingEfektif;
  double ratingHarga;
  double statusBeli;
  double statusRecomendasi;
  String photos;
  double rating;

  Reviews(
      {this.id,
      this.productId,
      this.userId,
      this.ratingKemasan,
      this.comment,
      this.status,
      this.viewed,
      this.createdAt,
      this.updatedAt,
      this.ratingKegunaan,
      this.ratingEfektif,
      this.ratingHarga,
      this.statusBeli,
      this.statusRecomendasi,
      this.photos,
      this.rating});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    ratingKemasan = json['rating_kemasan'];
    comment = json['comment'];
    status = json['status'];
    viewed = json['viewed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingKegunaan = json['rating_kegunaan'];
    ratingEfektif = json['rating_efektif'];
    ratingHarga = json['rating_harga'];
    statusBeli = json['status_beli'];
    statusRecomendasi = json['status_recomendasi'];
    photos = json['photos'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['rating_kemasan'] = this.ratingKemasan;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['viewed'] = this.viewed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating_kegunaan'] = this.ratingKegunaan;
    data['rating_efektif'] = this.ratingEfektif;
    data['rating_harga'] = this.ratingHarga;
    data['status_beli'] = this.statusBeli;
    data['status_recomendasi'] = this.statusRecomendasi;
    data['photos'] = this.photos;
    data['rating'] = this.rating;
    return data;
  }
}

class Like {
  int id;
  int postId;
  int commentId;
  int userId;
  String createdAt;
  String updatedAt;

  Like(
      {this.id,
      this.postId,
      this.commentId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Like.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Seen {
  int id;
  int userId;
  int postId;

  Seen({this.id, this.userId, this.postId});

  Seen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    return data;
  }
}
