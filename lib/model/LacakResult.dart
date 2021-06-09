class LacakResult {
  bool success;
  String messsage;
  String object;
  String id;
  String waybillId;
  Courier courier;
  Origin origin;
  Origin destination;
  List<History> history;
  String link;
  int orderId;
  String status;

  LacakResult(
      {this.success,
        this.messsage,
        this.object,
        this.id,
        this.waybillId,
        this.courier,
        this.origin,
        this.destination,
        this.history,
        this.link,
        this.orderId,
        this.status});

  LacakResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messsage = json['messsage'];
    object = json['object'];
    id = json['id'];
    waybillId = json['waybill_id'];
    courier =
    json['courier'] != null ? new Courier.fromJson(json['courier']) : null;
    origin =
    json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    destination = json['destination'] != null
        ? new Origin.fromJson(json['destination'])
        : null;
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    link = json['link'];
    orderId = json['order_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messsage'] = this.messsage;
    data['object'] = this.object;
    data['id'] = this.id;
    data['waybill_id'] = this.waybillId;
    if (this.courier != null) {
      data['courier'] = this.courier.toJson();
    }
    if (this.origin != null) {
      data['origin'] = this.origin.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    data['link'] = this.link;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    return data;
  }
}

class Courier {
  String company;
  String name;
  String phone;

  Courier({this.company, this.name, this.phone});

  Courier.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Origin {
  String contactName;
  String address;

  Origin({this.contactName, this.address});

  Origin.fromJson(Map<String, dynamic> json) {
    contactName = json['contact_name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_name'] = this.contactName;
    data['address'] = this.address;
    return data;
  }
}

class History {
  String note;
  String updatedAt;
  String status;

  History({this.note, this.updatedAt, this.status});

  History.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}