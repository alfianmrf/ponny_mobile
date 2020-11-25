class Brand{
  int id;
  String name;
  String logo;
  String metaDescription;


  Brand(this.id, this.name,this.logo,this.metaDescription);

  factory Brand.fromJson(Map<String, dynamic> parsedJson){
    return Brand( parsedJson["id"], parsedJson["name"],parsedJson["logo"],parsedJson["meta_description"]);
  }
}