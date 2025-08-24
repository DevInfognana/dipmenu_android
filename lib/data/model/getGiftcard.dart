class GetGiftCards {
  bool? status;
  String? message;
  List<GetGiftCardsData>? data;
  List<String>? userEmails;

  GetGiftCards({this.status, this.message, this.data, this.userEmails});

  GetGiftCards.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetGiftCardsData>[];
      json['data'].forEach((v) {
        data!.add(GetGiftCardsData.fromJson(v));
      });
    }
    userEmails = json['userEmails'].cast<String>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['userEmails'] = this.userEmails;
  //   return data;
  // }
}

class GetGiftCardsData {
  int? id;
  int? userId;
  int? senderId;
  String? amount;
  String? code;
  int? redeemFlag;
  String? dateCreated;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;
  // User? user;

  GetGiftCardsData(
      {this.id,
        this.userId,
        this.senderId,
        this.amount,
        this.code,
        this.redeemFlag,
        this.dateCreated,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
       });

  GetGiftCardsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    amount = json['amount'];
    code = json['code'];
    redeemFlag = json['redeem_flag'];
    dateCreated = json['date_created'];
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
  //   data['sender_id'] = this.senderId;
  //   data['amount'] = this.amount;
  //   data['code'] = this.code;
  //   data['redeem_flag'] = this.redeemFlag;
  //   data['date_created'] = this.dateCreated;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //
  //   return data;
  // }
}

