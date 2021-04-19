import 'Order.dart';

class OrderResult {
  int orderId;
  String message;
  bool success;
  bool emailSuccess;
  MitransRequest mitransRequest;
  Midtrans mitrans_val;
  String orderCode;
  int codParam;

  OrderResult(
      {this.orderId,
        this.message,
        this.success,
        this.emailSuccess,
        this.mitransRequest,
        this.orderCode,
        this.mitrans_val,
        this.codParam
      });

  OrderResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    message = json['message'];
    success = json['success'] != null ? json['success'] :false;
    emailSuccess = json['email_success'] != null ? json['email_success'] :false ;
    mitransRequest = json['mitrans_request'] != null
        ? new MitransRequest.fromJson(json['mitrans_request'])
        : null;
    orderCode = json['order_code'];
    codParam = json['cod_param'];
    mitrans_val = json["mitrans_request"] != null ? Midtrans.fromJson(json["mitrans_request"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['email_success'] = this.emailSuccess;
    if (this.mitransRequest != null) {
      data['mitrans_request'] = this.mitransRequest.toJson();
    }
    data['order_code'] = this.orderCode;
    return data;
  }
}
class MitransRequest {
  String statusCode;
  String statusMessage;
  String transactionId;
  String orderId;
  String merchantId;
  String grossAmount;
  String currency;
  String paymentType;
  String transactionTime;
  String transactionStatus;
  String fraudStatus;
  List<Actions> actions;

  MitransRequest(
      {this.statusCode,
        this.statusMessage,
        this.transactionId,
        this.orderId,
        this.merchantId,
        this.grossAmount,
        this.currency,
        this.paymentType,
        this.transactionTime,
        this.transactionStatus,
        this.fraudStatus,
        this.actions});

  MitransRequest.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    transactionId = json['transaction_id'];
    orderId = json['order_id'];
    merchantId = json['merchant_id'];
    grossAmount = json['gross_amount'];
    currency = json['currency'];
    paymentType = json['payment_type'];
    transactionTime = json['transaction_time'];
    transactionStatus = json['transaction_status'];
    fraudStatus = json['fraud_status'];
    if (json['actions'] != null) {
      actions = new List<Actions>();
      json['actions'].forEach((v) {
        actions.add(new Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['transaction_id'] = this.transactionId;
    data['order_id'] = this.orderId;
    data['merchant_id'] = this.merchantId;
    data['gross_amount'] = this.grossAmount;
    data['currency'] = this.currency;
    data['payment_type'] = this.paymentType;
    data['transaction_time'] = this.transactionTime;
    data['transaction_status'] = this.transactionStatus;
    data['fraud_status'] = this.fraudStatus;
    if (this.actions != null) {
      data['actions'] = this.actions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String name;
  String method;
  String url;

  Actions({this.name, this.method, this.url});

  Actions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    method = json['method'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['method'] = this.method;
    data['url'] = this.url;
    return data;
  }
}
