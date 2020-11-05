class LacakResult {
  Query query;
  Status status;
  Result result;

  LacakResult({this.query, this.status, this.result});

  LacakResult.fromJson(Map<String, dynamic> json) {
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Query {
  String waybill;
  String courier;

  Query({this.waybill, this.courier});

  Query.fromJson(Map<String, dynamic> json) {
    waybill = json['waybill'];
    courier = json['courier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waybill'] = this.waybill;
    data['courier'] = this.courier;
    return data;
  }
}

class Status {
  int code;
  String description;

  Status({this.code, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Result {
  bool delivered;
  Summary summary;
  Details details;
  DeliveryStatus deliveryStatus;
  List<Manifest> manifest;

  Result(
      {this.delivered,
        this.summary,
        this.details,
        this.deliveryStatus,
        this.manifest});

  Result.fromJson(Map<String, dynamic> json) {
    delivered = json['delivered'];
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    deliveryStatus = json['delivery_status'] != null
        ? new DeliveryStatus.fromJson(json['delivery_status'])
        : null;
    if (json['manifest'] != null) {
      manifest = new List<Manifest>();
      json['manifest'].forEach((v) {
        manifest.add(new Manifest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivered'] = this.delivered;
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    if (this.deliveryStatus != null) {
      data['delivery_status'] = this.deliveryStatus.toJson();
    }
    if (this.manifest != null) {
      data['manifest'] = this.manifest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  String courierCode;
  String courierName;
  String waybillNumber;
  String serviceCode;
  String waybillDate;
  String shipperName;
  String receiverName;
  String origin;
  String destination;
  String status;

  Summary(
      {this.courierCode,
        this.courierName,
        this.waybillNumber,
        this.serviceCode,
        this.waybillDate,
        this.shipperName,
        this.receiverName,
        this.origin,
        this.destination,
        this.status});

  Summary.fromJson(Map<String, dynamic> json) {
    courierCode = json['courier_code'];
    courierName = json['courier_name'];
    waybillNumber = json['waybill_number'];
    serviceCode = json['service_code'];
    waybillDate = json['waybill_date'];
    shipperName = json['shipper_name'];
    receiverName = json['receiver_name'];
    origin = json['origin'];
    destination = json['destination'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courier_code'] = this.courierCode;
    data['courier_name'] = this.courierName;
    data['waybill_number'] = this.waybillNumber;
    data['service_code'] = this.serviceCode;
    data['waybill_date'] = this.waybillDate;
    data['shipper_name'] = this.shipperName;
    data['receiver_name'] = this.receiverName;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['status'] = this.status;
    return data;
  }
}

class Details {
  String waybillNumber;
  String waybillDate;
  String waybillTime;
  String weight;
  String origin;
  String destination;
  String shippperName;
  String shipperAddress1;
  String shipperAddress2;
  String shipperAddress3;
  String shipperCity;
  String receiverName;
  String receiverAddress1;
  String receiverAddress2;
  String receiverAddress3;
  String receiverCity;

  Details(
      {this.waybillNumber,
        this.waybillDate,
        this.waybillTime,
        this.weight,
        this.origin,
        this.destination,
        this.shippperName,
        this.shipperAddress1,
        this.shipperAddress2,
        this.shipperAddress3,
        this.shipperCity,
        this.receiverName,
        this.receiverAddress1,
        this.receiverAddress2,
        this.receiverAddress3,
        this.receiverCity});

  Details.fromJson(Map<String, dynamic> json) {
    waybillNumber = json['waybill_number'];
    waybillDate = json['waybill_date'];
    waybillTime = json['waybill_time'];
    weight = json['weight'];
    origin = json['origin'];
    destination = json['destination'];
    shippperName = json['shippper_name'];
    shipperAddress1 = json['shipper_address1'];
    shipperAddress2 = json['shipper_address2'];
    shipperAddress3 = json['shipper_address3'];
    shipperCity = json['shipper_city'];
    receiverName = json['receiver_name'];
    receiverAddress1 = json['receiver_address1'];
    receiverAddress2 = json['receiver_address2'];
    receiverAddress3 = json['receiver_address3'];
    receiverCity = json['receiver_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waybill_number'] = this.waybillNumber;
    data['waybill_date'] = this.waybillDate;
    data['waybill_time'] = this.waybillTime;
    data['weight'] = this.weight;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['shippper_name'] = this.shippperName;
    data['shipper_address1'] = this.shipperAddress1;
    data['shipper_address2'] = this.shipperAddress2;
    data['shipper_address3'] = this.shipperAddress3;
    data['shipper_city'] = this.shipperCity;
    data['receiver_name'] = this.receiverName;
    data['receiver_address1'] = this.receiverAddress1;
    data['receiver_address2'] = this.receiverAddress2;
    data['receiver_address3'] = this.receiverAddress3;
    data['receiver_city'] = this.receiverCity;
    return data;
  }
}

class DeliveryStatus {
  String status;
  String podReceiver;
  String podDate;
  String podTime;

  DeliveryStatus({this.status, this.podReceiver, this.podDate, this.podTime});

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    podReceiver = json['pod_receiver'];
    podDate = json['pod_date'];
    podTime = json['pod_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['pod_receiver'] = this.podReceiver;
    data['pod_date'] = this.podDate;
    data['pod_time'] = this.podTime;
    return data;
  }
}

class Manifest {
  String manifestDescription;
  String manifestDate;
  String manifestTime;
  String cityName;

  Manifest(
      {this.manifestDescription,
        this.manifestDate,
        this.manifestTime,
        this.cityName});

  Manifest.fromJson(Map<String, dynamic> json) {
    manifestDescription = json['manifest_description'];
    manifestDate = json['manifest_date'];
    manifestTime = json['manifest_time'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manifest_description'] = this.manifestDescription;
    data['manifest_date'] = this.manifestDate;
    data['manifest_time'] = this.manifestTime;
    data['city_name'] = this.cityName;
    return data;
  }
}
