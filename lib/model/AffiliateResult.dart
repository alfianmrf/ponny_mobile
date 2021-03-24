class AffiliateResult {
  String firstName;
  String lastName;
  BannerAffiliate banner;
  List<Withdrawal> withdrawal;
  bool isAffiliate;
  List<Codes> codes;
  int sessions;
  int totalUsed;
  String sales;
  String pathImg;

  AffiliateResult(
      {this.firstName,
      this.lastName,
      this.banner,
      this.withdrawal,
      this.isAffiliate,
      this.codes,
      this.sessions,
      this.totalUsed,
      this.sales,
      this.pathImg});

  AffiliateResult.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    banner = json['banner'] != null
        ? new BannerAffiliate.fromJson(json['banner'])
        : null;
    if (json['withdrawal'] != null) {
      withdrawal = new List<Withdrawal>();
      json['withdrawal'].forEach((v) {
        withdrawal.add(new Withdrawal.fromJson(v));
      });
    }
    isAffiliate = json['is_affiliate'];
    if (json['codes'] != null) {
      codes = new List<Codes>();
      json['codes'].forEach((v) {
        codes.add(new Codes.fromJson(v));
      });
    }
    sessions = json['sessions'];
    totalUsed = json['total_used'];
    sales = json['sales'];
    pathImg = json['path_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.banner != null) {
      data['banner'] = this.banner.toJson();
    }
    if (this.withdrawal != null) {
      data['withdrawal'] = this.withdrawal.map((v) => v.toJson()).toList();
    }
    data['is_affiliate'] = this.isAffiliate;
    if (this.codes != null) {
      data['codes'] = this.codes.map((v) => v.toJson()).toList();
    }
    data['sessions'] = this.sessions;
    data['total_used'] = this.totalUsed;
    data['sales'] = this.sales;
    data['path_img'] = this.pathImg;
    return data;
  }
}

class BannerAffiliate {
  int id;
  String photo;
  String url;
  int position;
  int published;
  String createdAt;
  String updatedAt;
  Null banner;

  BannerAffiliate(
      {this.id,
      this.photo,
      this.url,
      this.position,
      this.published,
      this.createdAt,
      this.updatedAt,
      this.banner});

  BannerAffiliate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    url = json['url'];
    position = json['position'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['url'] = this.url;
    data['position'] = this.position;
    data['published'] = this.published;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    return data;
  }
}

class Withdrawal {
  int id;
  int affiliateUserId;
  int amount;
  String paymentMethod;
  Null paymentDetails;
  String createdAt;
  String updatedAt;
  String status;
  String norek;
  String atasnama;
  String tglBayar;
  String gambar;

  Withdrawal(
      {this.id,
      this.affiliateUserId,
      this.amount,
      this.paymentMethod,
      this.paymentDetails,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.norek,
      this.atasnama,
      this.tglBayar,
      this.gambar});

  Withdrawal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affiliateUserId = json['affiliate_user_id'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    paymentDetails = json['payment_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    norek = json['norek'];
    atasnama = json['atasnama'];
    tglBayar = json['tgl_bayar'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['affiliate_user_id'] = this.affiliateUserId;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['payment_details'] = this.paymentDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['norek'] = this.norek;
    data['atasnama'] = this.atasnama;
    data['tgl_bayar'] = this.tglBayar;
    data['gambar'] = this.gambar;
    return data;
  }
}

class Codes {
  String kodeId;
  int userId;
  String createdAt;
  String updatedAt;
  int isActive;
  int use;
  int sales;
  int komisi;
  int id;

  Codes(
      {this.kodeId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.use,
      this.sales,
      this.komisi,
      this.id});

  Codes.fromJson(Map<String, dynamic> json) {
    kodeId = json['kode_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    use = json['use'];
    sales = json['sales'];
    komisi = json['komisi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_id'] = this.kodeId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['use'] = this.use;
    data['sales'] = this.sales;
    data['komisi'] = this.komisi;
    data['id'] = this.id;
    return data;
  }
}
