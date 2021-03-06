import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http/http.dart' as http;

class CategoryModel with ChangeNotifier {

  List<Category> categoris = List<Category>();
  bool loadingCategory =true;

  CategoryModel(){
    getCategory();
  }

  Future<void> getCategory() async {

    final res = await http.get(categoryList);
    // print(res.body);
    if(res.statusCode == 200){
      final responejson = json.decode(res.body);
      responejson.forEach((v) {
        categoris.add(new Category.fromJson(v));
      });
      loadingCategory=false;
      notifyListeners();

    }

  }

}

class Category {
  int id;
  String name;
  int commisionRate;
  String banner;
  String icon;
  int featured;
  int top;
  int digital;
  String slug;
  String metaTitle;
  String metaDescription;
  String createdAt;
  String updatedAt;
  List<Subcategories> subcategories;
  List<MasalahKulit> masalahKulit;

  Category(
      {this.id,
        this.name,
        this.commisionRate,
        this.banner,
        this.icon,
        this.featured,
        this.top,
        this.digital,
        this.slug,
        this.metaTitle,
        this.metaDescription,
        this.createdAt,
        this.updatedAt,
        this.subcategories,
      this.masalahKulit});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commisionRate = json['commision_rate'];
    banner = json['banner'];
    icon = json['icon'];
    featured = json['featured'];
    top = json['top'];
    digital = json['digital'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
    if (json['masalahkulit'] != null) {
      masalahKulit = new List<MasalahKulit>();
      json['masalahkulit'].forEach((v) {
        masalahKulit.add(new MasalahKulit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['commision_rate'] = this.commisionRate;
    data['banner'] = this.banner;
    data['icon'] = this.icon;
    data['featured'] = this.featured;
    data['top'] = this.top;
    data['digital'] = this.digital;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int id;
  String name;
  int categoryId;
  String slug;
  String metaTitle;
  String metaDescription;
  String createdAt;
  String updatedAt;
  String icon_mobile;
  List<Subsubcategories> subsubcategories;

  Subcategories(
      {this.id,
        this.name,
        this.categoryId,
        this.slug,
        this.metaTitle,
        this.metaDescription,
        this.createdAt,
        this.updatedAt,
        this.subsubcategories,
      this.icon_mobile});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon_mobile = json['icon_mobile'];
    if (json['subsubcategories'] != null) {
      subsubcategories = new List<Subsubcategories>();
      json['subsubcategories'].forEach((v) {
        subsubcategories.add(new Subsubcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subsubcategories != null) {
      data['subsubcategories'] =
          this.subsubcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MasalahKulit {
  int id;
  String name;
  String slug;
  String updatedAt;
  String createdAt;
  String iconMobile;
  int subCategoryId;
  String metaDescription;
  String icon;

  MasalahKulit(
      {this.id,
        this.name,
        this.slug,
        this.updatedAt,
        this.createdAt,
        this.iconMobile,
        this.subCategoryId,
        this.metaDescription,
        this.icon});

  MasalahKulit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iconMobile = json['icon_mobile'];
    subCategoryId = json['sub_category_id'];
    metaDescription = json['meta_description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['icon_mobile'] = this.iconMobile;
    data['sub_category_id'] = this.subCategoryId;
    data['meta_description'] = this.metaDescription;
    data['icon'] = this.icon;
    return data;
  }
}

class Subsubcategories {
  int id;
  int subCategoryId;
  String name;
  String slug;
  String metaTitle;
  String metaDescription;
  String createdAt;
  String updatedAt;

  Subsubcategories(
      {this.id,
        this.subCategoryId,
        this.name,
        this.slug,
        this.metaTitle,
        this.metaDescription,
        this.createdAt,
        this.updatedAt});

  Subsubcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    name = json['name'];
    slug = json['slug'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
