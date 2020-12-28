class GeneralSetting {
  String logo;
  String siteName;
  String address;
  String description;
  String phone;
  String email;
  String facebook;
  String twitter;
  String instagram;
  String youtube;
  String googlePlus;
  String embedVideo;
  String announcementBar;

  GeneralSetting(
      {this.logo,
        this.siteName,
        this.address,
        this.description,
        this.phone,
        this.email,
        this.facebook,
        this.twitter,
        this.instagram,
        this.youtube,
        this.googlePlus,
        this.embedVideo,
        this.announcementBar});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    siteName = json['site_name'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    googlePlus = json['google_plus'];
    embedVideo = json['embed_video'];
    announcementBar = json['announcement_bar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['site_name'] = this.siteName;
    data['address'] = this.address;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['google_plus'] = this.googlePlus;
    data['embed_video'] = this.embedVideo;
    data['announcement_bar'] = this.announcementBar;
    return data;
  }
}