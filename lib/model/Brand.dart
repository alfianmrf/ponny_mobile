class Brand{
  int id;
  String name;

  Brand(this.id, this.name);

  factory Brand.fromJson(Map<String, dynamic> parsedJson){
    return Brand( parsedJson["id"], parsedJson["name"]);
  }
}