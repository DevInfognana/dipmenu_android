class TopUPValues {
  bool? status;
  String? message;
  List<TopUPValuesData>? data;
  // List<String>? userEmails;

  TopUPValues({this.status, this.message, this.data});

  TopUPValues.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TopUPValuesData>[];
      json['data'].forEach((v) {
        data!.add(TopUPValuesData.fromJson(v));
      });
    }
    // userEmails = json['userEmails'].cast<String>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   // data['userEmails'] = this.userEmails;
  //   return data;
  // }
}

class TopUPValuesData {
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
  User? user;

  TopUPValuesData(
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
        this.user});

  TopUPValuesData.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  //   if (this.user != null) {
  //     data['user'] = this.user!.toJson();
  //   }
  //   return data;
  // }
}

class User {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? location;
  String? password;
  String? profileImageurl;
  int? rewardPoints;
  int? wallet;
  int? status;
  String? driveThruDetails;
  dynamic accessToken;
  int? trash;
  dynamic token;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.location,
        this.password,
        this.profileImageurl,
        this.rewardPoints,
        this.wallet,
        this.status,
        this.driveThruDetails,
        this.accessToken,
        this.trash,
        this.token,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    location = json['location'];
    password = json['password'];
    profileImageurl = json['profile_imageurl'];
    rewardPoints = json['reward_points'];
    wallet = json['wallet'];
    status = json['status'];
    driveThruDetails = json['driveThru_details'];
    accessToken = json['access_token'];
    trash = json['trash'];
    token = json['token'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['role_id'] = this.roleId;
  //   data['first_name'] = this.firstName;
  //   data['last_name'] = this.lastName;
  //   data['mobile'] = this.mobile;
  //   data['email'] = this.email;
  //   data['location'] = this.location;
  //   data['password'] = this.password;
  //   data['profile_imageurl'] = this.profileImageurl;
  //   data['reward_points'] = this.rewardPoints;
  //   data['wallet'] = this.wallet;
  //   data['status'] = this.status;
  //   data['driveThru_details'] = this.driveThruDetails;
  //   data['access_token'] = this.accessToken;
  //   data['trash'] = this.trash;
  //   data['token'] = this.token;
  //   data['created_by'] = this.createdBy;
  //   data['updated_by'] = this.updatedBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
