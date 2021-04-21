class BlogCategories {
  int id;
  String title;
  String icon;
  String createdAt;
  String updatedAt;

  BlogCategories(
      {this.id, this.title, this.icon, this.createdAt, this.updatedAt});

  BlogCategories.fromJson(Map<String, dynamic> json) {
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
