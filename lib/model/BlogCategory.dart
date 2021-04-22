class BlogCategory {
  List<Blogs> blogs;
  List<OtherArticles> otherArticles;

  BlogCategory({this.blogs, this.otherArticles});

  BlogCategory.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = new List<Blogs>();
      json['blogs'].forEach((v) {
        blogs.add(new Blogs.fromJson(v));
      });
    }
    if (json['other_articles'] != null) {
      otherArticles = new List<OtherArticles>();
      json['other_articles'].forEach((v) {
        otherArticles.add(new OtherArticles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    if (this.otherArticles != null) {
      data['other_articles'] =
          this.otherArticles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int id;
  String title;
  String icon;
  String createdAt;
  String updatedAt;
  List<Blog> blog;

  Blogs(
      {this.id,
        this.title,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.blog});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['blog'] != null) {
      blog = new List<Blog>();
      json['blog'].forEach((v) {
        blog.add(new Blog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.blog != null) {
      data['blog'] = this.blog.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blog {
  int id;
  String title;
  String content;
  String productRecommend;
  int userId;
  int categoryblogId;
  String thumbnail;
  int showblog;
  String createdAt;
  String updatedAt;
  String slug;

  Blog(
      {this.id,
        this.title,
        this.content,
        this.productRecommend,
        this.userId,
        this.categoryblogId,
        this.thumbnail,
        this.showblog,
        this.createdAt,
        this.updatedAt,
        this.slug});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    productRecommend = json['product_recommend'];
    userId = json['user_id'];
    categoryblogId = json['categoryblog_id'];
    thumbnail = json['thumbnail'];
    showblog = json['showblog'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['product_recommend'] = this.productRecommend;
    data['user_id'] = this.userId;
    data['categoryblog_id'] = this.categoryblogId;
    data['thumbnail'] = this.thumbnail;
    data['showblog'] = this.showblog;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    return data;
  }
}

class OtherArticles {
  int id;
  String title;
  String content;
  String productRecommend;
  int userId;
  int categoryblogId;
  String thumbnail;
  int showblog;
  String createdAt;
  String updatedAt;
  String slug;
  Category category;
  User user;

  OtherArticles(
      {this.id,
        this.title,
        this.content,
        this.productRecommend,
        this.userId,
        this.categoryblogId,
        this.thumbnail,
        this.showblog,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.category,
        this.user});

  OtherArticles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    productRecommend = json['product_recommend'];
    userId = json['user_id'];
    categoryblogId = json['categoryblog_id'];
    thumbnail = json['thumbnail'];
    showblog = json['showblog'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['product_recommend'] = this.productRecommend;
    data['user_id'] = this.userId;
    data['categoryblog_id'] = this.categoryblogId;
    data['thumbnail'] = this.thumbnail;
    data['showblog'] = this.showblog;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String title;
  String icon;
  String createdAt;
  String updatedAt;

  Category({this.id, this.title, this.icon, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int id;
  Null referredBy;
  Null providerId;
  String userType;
  String name;
  String email;
  String emailVerifiedAt;
  Null avatar;
  Null avatarOriginal;
  Null address;
  Null country;
  Null city;
  Null postalCode;
  String phone;
  int balance;
  Null referralCode;
  Null customerPackageId;
  int remainingUploads;
  String createdAt;
  String updatedAt;
  Null lastName;
  String gender;
  Null tglLahir;
  Null jenisKulit;
  Null warnaKulit;
  Null kondisiKulit;
  Null kondisiRambut;
  Null preferensiProduct;
  Null fbtoken;
  int point;
  int tier;
  int completedProfile;
  String cek;
  String verifyToken;

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
        this.cek,
        this.verifyToken});

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
    cek = json['cek'];
    verifyToken = json['verify_token'];
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
    data['cek'] = this.cek;
    data['verify_token'] = this.verifyToken;
    return data;
  }
}
