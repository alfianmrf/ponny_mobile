class Dashboards {
  String happySkinLabel;
  String membershipTitle;
  double totalOrder;
  String next;
  double toNext;
  double percent;
  Log log;
  int unpaid;
  int paid;
  int ondelivery;
  int delivered;
  int komplain;
  int dibatalkan;
  int selesai;


  Dashboards(
      {this.happySkinLabel,
        this.membershipTitle,
        this.totalOrder,
        this.next,
        this.toNext,
        this.percent,
        this.log,
        this.unpaid,
        this.paid,
        this.ondelivery,
        this.delivered,
        this.komplain,
        this.dibatalkan,
        this.selesai
      });

  Dashboards.fromJson(Map<String, dynamic> json) {
    print(json);
    happySkinLabel = json['happy_skin_label'];
    membershipTitle = json['membership_title'];
    totalOrder = double.parse(json['totalOrder'].toString());
    next = json['next'];
    toNext =  double.parse(json['to_next'].toString());
    percent = double.parse(json['percent'].toString());
    log = json['log'] != null ? new Log.fromJson(json['log']) : null;
    unpaid = json['unpaid'];
    paid = json['paid'];
    ondelivery = json['ondelivery'];
    delivered = json['delivered'];
    komplain = json['komplain'];
    dibatalkan = json['dibatalkan'];
    selesai = json['selesai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['happy_skin_label'] = this.happySkinLabel;
    data['membership_title'] = this.membershipTitle;
    data['totalOrder'] = this.totalOrder;
    data['next'] = this.next;
    data['to_next'] = this.toNext;
    data['percent'] = this.percent;
    if (this.log != null) {
      data['log'] = this.log.toJson();
    }
    return data;
  }
}

class Log {
  int id;
  int userId;
  int memberId;
  int totalPurchase;
  String createdAt;
  String updatedAt;
  String endsOn;
  Membership membership;

  Log(
      {this.id,
        this.userId,
        this.memberId,
        this.totalPurchase,
        this.createdAt,
        this.updatedAt,
        this.endsOn,
        this.membership});

  Log.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    memberId = json['member_id'];
    totalPurchase = json['total_purchase'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    endsOn = json['ends_on'];
    membership = json['membership'] != null
        ? new Membership.fromJson(json['membership'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['member_id'] = this.memberId;
    data['total_purchase'] = this.totalPurchase;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ends_on'] = this.endsOn;
    if (this.membership != null) {
      data['membership'] = this.membership.toJson();
    }
    return data;
  }
}

class Membership {
  int id;
  String title;
  int min;
  int period;
  int periodUnit;
  String createdAt;
  String updatedAt;
  int isProductIstimewa;
  int isKuponUltah;
  int isProductSpesial;
  double poinOrder;
  int freeShipingCost;
  int freeShipingMinOrder;

  Membership(
      {this.id,
        this.title,
        this.min,
        this.period,
        this.periodUnit,
        this.createdAt,
        this.updatedAt,
        this.isProductIstimewa,
        this.isKuponUltah,
        this.isProductSpesial,
        this.poinOrder,
        this.freeShipingCost,
        this.freeShipingMinOrder});

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    min = json['min'];
    period = json['period'];
    periodUnit = json['period_unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProductIstimewa = json['is_product_istimewa'];
    isKuponUltah = json['is_kupon_ultah'];
    isProductSpesial = json['is_product_spesial'];
    poinOrder = json['poin_order'];
    freeShipingCost = json['free_shiping_cost'];
    freeShipingMinOrder = json['free_shiping_min_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['min'] = this.min;
    data['period'] = this.period;
    data['period_unit'] = this.periodUnit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_product_istimewa'] = this.isProductIstimewa;
    data['is_kupon_ultah'] = this.isKuponUltah;
    data['is_product_spesial'] = this.isProductSpesial;
    data['poin_order'] = this.poinOrder;
    data['free_shiping_cost'] = this.freeShipingCost;
    data['free_shiping_min_order'] = this.freeShipingMinOrder;
    return data;
  }
}
