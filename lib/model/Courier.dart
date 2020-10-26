class Courier{
  String code;
  String name;
  List<Layanan> costs;
  Courier(this.code, this.name, this.costs);
  factory Courier.fromJson(Map<String, dynamic> parsedJson){
    List<Layanan> _costs=[];
    for(Map item in parsedJson['costs']){
      _costs.add(Layanan.fromJson(item));
    }
    return Courier(parsedJson["code"], parsedJson["name"], _costs);
  }
}
class Layanan{
  String service;
  String description;
  List<Cost> cost;

  Layanan(this.service, this.description, this.cost);
  factory Layanan.fromJson(Map<String, dynamic> parsedJson){
    List<Cost> _cost=[];
    for(Map item in parsedJson['cost']){
      _cost.add(Cost.fromJson(item));
    }
    return Layanan(parsedJson["service"], parsedJson["description"], _cost);
  }

}
class Cost{
  int value;
  String etd;
  String etd_text;
  Cost(this.value, this.etd,this.etd_text);

  factory Cost.fromJson(Map<String, dynamic> parsedJson){
    return Cost(parsedJson["value"], parsedJson["etd"],parsedJson["etd_text"]);
  }
}

class MapCost{
  int index;
  String code;
  String services;
  int cost;

  MapCost(this.index,this.code, this.services, this.cost);

  factory MapCost.fromJson(Map<String, dynamic> parsedJson){
    print(parsedJson);
    return MapCost(-1, parsedJson["code"],parsedJson["services"],parsedJson["cost"]);
  }

  Map<String, dynamic> toJson() =>{
    "code":code,
    "services":services,
    "cost":cost
  };
}
