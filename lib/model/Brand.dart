class Brand{
  int id;
  String name;
  String logo;


  Brand(this.id, this.name,this.logo);

  factory Brand.fromJson(Map<String, dynamic> parsedJson){
    return Brand( parsedJson["id"], parsedJson["name"],parsedJson["logo"]);
  }
}