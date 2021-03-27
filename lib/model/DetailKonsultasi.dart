class DetailKonsultasi {
  List<String> data;
  bool success;
  int status;

  DetailKonsultasi({this.data, this.success, this.status});

  DetailKonsultasi.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}