class DetailRuangModel {
  List<Room> room;
  List<Topics> topics;

  DetailRuangModel({this.room, this.topics});

  DetailRuangModel.fromJson(Map<String, dynamic> json) {
    if (json['room'] != null) {
      room = new List<Room>();
      json['room'].forEach((v) {
        room.add(new Room.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['room'] = this.room.map((v) => v.toJson()).toList();
    }
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
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
  int orderby;
  int totalUser;
  String join;
  List<Posts> posts;

  Room(
      {this.id,
      this.title,
      this.subTitle,
      this.img,
      this.topicsId,
      this.createdAt,
      this.updatedAt,
      this.orderby,
      this.totalUser,
      this.join,
      this.posts});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    img = json['img'];
    topicsId = json['topics_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderby = json['orderby'];
    totalUser = json['total_user'];
    join = json['join'];
    if (json['posts'] != null) {
      posts = new List<Posts>();
      json['posts'].forEach((v) {
        posts.add(new Posts.fromJson(v));
      });
    }
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
    data['orderby'] = this.orderby;
    data['total_user'] = this.totalUser;
    data['join'] = this.join;
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int id;
  String title;
  String text;
  String thumbnail;
  int userId;
  int roomId;
  String createdAt;
  String updatedAt;
  String slug;
  Users user;
  List<Reply> reply;
  List<Like> like;

  Posts(
      {this.id,
      this.title,
      this.text,
      this.thumbnail,
      this.userId,
      this.roomId,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.user,
      this.reply,
      this.like});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    thumbnail = json['thumbnail'];
    userId = json['user_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.reply != null) {
      data['reply'] = this.reply.map((v) => v.toJson()).toList();
    }
    if (this.like != null) {
      data['like'] = this.like.map((v) => v.toJson()).toList();
    }
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
  int balance;
  String referralCode;
  String customerPackageId;
  int remainingUploads;
  String createdAt;
  String updatedAt;
  String lastName;
  String gender;
  String tglLahir;
  int jenisKulit;
  String warnaKulit;
  String kondisiKulit;
  String kondisiRambut;
  String preferensiProduct;
  String fbtoken;
  int point;
  int tier;
  int completedProfile;

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
      this.completedProfile});

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

class Reply {
  int id;
  String text;
  int postId;
  int userId;
  String createdAt;
  String updatedAt;
  int notifiable;
  User user;

  Reply(
      {this.id,
      this.text,
      this.postId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.notifiable,
      this.user});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    postId = json['post_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notifiable = json['notifiable'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
  int balance;
  String referralCode;
  String customerPackageId;
  int remainingUploads;
  String createdAt;
  String updatedAt;
  String lastName;
  String gender;
  String tglLahir;
  int jenisKulit;
  int warnaKulit;
  String kondisiKulit;
  String kondisiRambut;
  String preferensiProduct;
  String fbtoken;
  int point;
  int tier;
  int completedProfile;

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

class Topics {
  int id;
  String title;

  Topics({this.id, this.title});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
