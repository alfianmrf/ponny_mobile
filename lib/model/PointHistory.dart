class PointHistory {
  String userId;
  String points;
  String createdAt;
  String keterangan;
  String status;

  PointHistory(
      {this.userId, this.points, this.createdAt, this.keterangan, this.status});

  PointHistory.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    // points = json['points'].round();
    points = json['points'];
    createdAt = json['created_at'];
    keterangan = json['keterangan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['keterangan'] = this.keterangan;
    data['status'] = this.status;
    return data;
  }
}
