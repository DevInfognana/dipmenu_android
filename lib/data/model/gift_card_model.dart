class GiftCardData {
  bool? status;
  String? message;
  Data? data;

  GiftCardData({this.status, this.message, this.data});

  GiftCardData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  int? id;
  int? userId;
  String? emailId;
  String? firstName;
  String? lastName;
  String? loadPoints;
  String? mobile;
  String? giftcardId;
  String? fromDate;
  String? toDate;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.emailId,
        this.firstName,
        this.lastName,
        this.loadPoints,
        this.mobile,
        this.giftcardId,
        this.fromDate,
        this.toDate,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    emailId = json['email_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    loadPoints = json['load_points'];
    mobile = json['mobile'];
    giftcardId = json['giftcard_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user_id'] = this.userId;
  //   data['email_id'] = this.emailId;
  //   data['first_name'] = this.firstName;
  //   data['last_name'] = this.lastName;
  //   data['load_points'] = this.loadPoints;
  //   data['mobile'] = this.mobile;
  //   data['giftcard_id'] = this.giftcardId;
  //   data['from_date'] = this.fromDate;
  //   data['to_date'] = this.toDate;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
