class Review {
  User user;
  double rating;
  int ratingKemasan;
  int ratingKegunaan;
  int ratingEfektif;
  int ratingHarga;
  int statusBeli;
  int statusRecomendasi;
  String comment;
  String time;
  List<String> photos;

  Review(
      {this.user,
        this.rating,
        this.ratingKemasan,
        this.ratingKegunaan,
        this.ratingEfektif,
        this.ratingHarga,
        this.statusBeli,
        this.statusRecomendasi,
        this.comment,
        this.time,
        this.photos});

  Review.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating = json['rating'];
    ratingKemasan = json['rating_kemasan'];
    ratingKegunaan = json['rating_kegunaan'];
    ratingEfektif = json['rating_efektif'];
    ratingHarga = json['rating_harga'];
    statusBeli = json['status_beli'];
    statusRecomendasi = json['status_recomendasi'];
    comment = json['comment'];
    time = json['time'];
    photos = json['photos'] != null ? json['photos'].cast<String>():[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rating'] = this.rating;
    data['rating_kemasan'] = this.ratingKemasan;
    data['rating_kegunaan'] = this.ratingKegunaan;
    data['rating_efektif'] = this.ratingEfektif;
    data['rating_harga'] = this.ratingHarga;
    data['status_beli'] = this.statusBeli;
    data['status_recomendasi'] = this.statusRecomendasi;
    data['comment'] = this.comment;
    data['time'] = this.time;
    data['photos'] = this.photos;
    return data;
  }
}

class User {
  String name;
  String avatarOriginal;
  String gender;

  User({this.name, this.avatarOriginal, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatarOriginal = json['avatar_original'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar_original'] = this.avatarOriginal;
    data['gender'] = this.gender;
    return data;
  }
}
