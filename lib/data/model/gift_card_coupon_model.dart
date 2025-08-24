class GiftCardModelSuccess {
  bool? status;
  String? message;

  GiftCardModelSuccess({this.status, this.message});

  GiftCardModelSuccess.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   return data;
  // }
}


class AddCouponCode {
  bool? status;
  String? message;
  String? couponcode;

  AddCouponCode({this.status, this.message, this.couponcode});

  AddCouponCode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    couponcode = json['couponcode'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   data['couponcode'] = this.couponcode;
  //   return data;
  // }
}


