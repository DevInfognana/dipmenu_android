class PosTimeValues {
  List<Order>? order;

  PosTimeValues({this.order});

  PosTimeValues.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.order != null) {
  //     data['order'] = this.order!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Order {
  String? orderModeDetails;

  Order({this.orderModeDetails});

  Order.fromJson(Map<String, dynamic> json) {
    orderModeDetails = json['schedulepickup_time'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['schedulepickup_time'] = this.orderModeDetails;
  //   return data;
  // }
}
