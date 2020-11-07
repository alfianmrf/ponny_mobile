class OrderResult {
  String message;
  bool success;
  bool emailSuccess;
  String emailMessage;
  String orderCode;

  OrderResult(
      {this.message,
        this.success,
        this.emailSuccess,
        this.emailMessage,
        this.orderCode});

  OrderResult.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    emailSuccess = json['email_success'];
    emailMessage = json['email_message'];
    orderCode = json['order_code'];
  }


}

