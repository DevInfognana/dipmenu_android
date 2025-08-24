class MobileWalletModel {
  bool? status;
  MobileWalletData? mobileWalletData;

  MobileWalletModel({this.status, this.mobileWalletData});

  MobileWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mobileWalletData = json['data'] != null ? MobileWalletData.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['status'] = status;
  //   if (mobileWalletData != null) {
  //     data['data'] = mobileWalletData!.toJson();
  //   }
  //   return data;
  // }
}

class MobileWalletData {
  int? id;
  int? userId;
  int? senderId;
  String? amount;
  String? code;
  int? redeemFlag;
  String? dateCreated;
  int? status;
  int? trash;
  String? message;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? mobileToken;

  MobileWalletData(
      {this.id,
        this.userId,
        this.senderId,
        this.amount,
        this.code,
        this.redeemFlag,
        this.dateCreated,
        this.status,
        this.trash,
        this.message,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.mobileToken});

  MobileWalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    amount = json['amount'];
    code = json['code']??'';
    redeemFlag = json['redeem_flag'];
    dateCreated = json['date_created'];
    status = json['status'];
    trash = json['trash'];
    message = json['message'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobileToken = json['mobile_token'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  Map<String, dynamic>();
  //   data['id'] = id;
  //   data['user_id'] = userId;
  //   data['sender_id'] = senderId;
  //   data['amount'] = amount;
  //   data['code'] = code;
  //   data['redeem_flag'] = redeemFlag;
  //   data['date_created'] = dateCreated;
  //   data['status'] = status;
  //   data['trash'] = trash;
  //   data['message'] = message;
  //   data['created_by'] = createdBy;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   data['mobile_token'] = mobileToken;
  //   return data;
  // }
}
