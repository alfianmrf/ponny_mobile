class FaqHeader {
  int id;
  String title;
  String createdAt;
  String updatedAt;
  List<Faq> faq;

  FaqHeader({this.id, this.title, this.createdAt, this.updatedAt, this.faq});

  FaqHeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['faq'] != null) {
      faq = new List<Faq>();
      json['faq'].forEach((v) {
        faq.add(new Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.faq != null) {
      data['faq'] = this.faq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faq {
  int id;
  String ask;
  String ans;
  int categoryId;
  String updatedAt;
  String createdAt;

  Faq(
      {this.id,
        this.ask,
        this.ans,
        this.categoryId,
        this.updatedAt,
        this.createdAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ask = json['ask'];
    ans = json['ans'];
    categoryId = json['category_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ask'] = this.ask;
    data['ans'] = this.ans;
    data['category_id'] = this.categoryId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
