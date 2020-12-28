import 'User.dart';

class Dokter {
  int userId;
  String graduated;
  String tempatPraktek;
  String deskripsi;
  String gambarProfile;
  String updatedAt;
  String bidang;
  String createdAt;
  User user;

  Dokter(
      {this.userId,
        this.graduated,
        this.tempatPraktek,
        this.deskripsi,
        this.gambarProfile,
        this.updatedAt,
        this.createdAt,
        this.bidang,
      this.user});

  Dokter.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    graduated = json['graduated'];
    tempatPraktek = json['tempat_praktek'];
    deskripsi = json['deskripsi'];
    gambarProfile = json['gambar_profile'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    bidang = json["bidang"];
    user = json['user'] != null ? User.fromLocalJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['graduated'] = this.graduated;
    data['tempat_praktek'] = this.tempatPraktek;
    data['deskripsi'] = this.deskripsi;
    data['gambar_profile'] = this.gambarProfile;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}