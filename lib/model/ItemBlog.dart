class ItemBlog {
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

  ItemBlog(
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

  ItemBlog.fromJson(Map<String, dynamic> json) {
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
