class ItemSkinklopedia {
  int id;
  String title;
  String text;
  String img;
  String createdAt;
  String updatedAt;

  ItemSkinklopedia(
      {this.id,
        this.title,
        this.text,
        this.img,
        this.createdAt,
        this.updatedAt});

  ItemSkinklopedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['img'] = this.img;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
