class OrderUpdateValues {
  bool? status;
  String? message;
  int? orderStatus;

  OrderUpdateValues({this.status, this.message, this.orderStatus});

  OrderUpdateValues.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderStatus = json['order_status'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   data['order_status'] = this.orderStatus;
  //   return data;
  // }
}
