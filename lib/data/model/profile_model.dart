/*class ProfileData {
  ProfileDataValue? datas;

  ProfileData({this.datas});

  ProfileData.fromJson(Map<String, dynamic> json) {
    datas = json['datas'] != null ? new ProfileDataValue.fromJson(json['datas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datas != null) {
      data['datas'] = this.datas!.toJson();
    }
    return data;
  }
}

class ProfileDataValue {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? location;
  String? password;
  int? rewardPoints;
  int? status;
  dynamic accessToken;
  int? trash;
  dynamic token;
  Null? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;

  ProfileDataValue(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.location,
        this.password,
        this.rewardPoints,
        this.status,
        this.accessToken,
        this.trash,
        this.token,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  ProfileDataValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    location = json['location'];
    password = json['password'];
    rewardPoints = json['reward_points'];
    status = json['status'];
    accessToken = json['access_token'];
    trash = json['trash'];
    token = json['token'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['location'] = this.location;
    data['password'] = this.password;
    data['reward_points'] = this.rewardPoints;
    data['status'] = this.status;
    data['access_token'] = this.accessToken;
    data['trash'] = this.trash;
    data['token'] = this.token;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/



class ProfileData {
  ProfileDataValue? datas;

  ProfileData({this.datas});

  ProfileData.fromJson(Map<String, dynamic> json) {
    datas = json['datas'] != null ? ProfileDataValue.fromJson(json['datas']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.datas != null) {
  //     data['datas'] = this.datas!.toJson();
  //   }
  //   return data;
  // }
}

class ProfileDataValue {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  // String? location;
  String? password;
  dynamic profileImageurl;
  int? rewardPoints;
  num? wallet;
  int? status;
  dynamic driveThruDetails;
  dynamic accessToken;
  int? trash;
  dynamic token;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? updatedAt;

  ProfileDataValue(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        // this.location,
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

  ProfileDataValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    // location = json['location'];
    password = json['password'];
    profileImageurl = json['profile_imageurl'];
    rewardPoints = json['reward_points'];
    status = json['status'];
    wallet = json['wallet'];
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
  //   // data['location'] = this.location;
  //   data['password'] = this.password;
  //   data['profile_imageurl'] = this.profileImageurl;
  //   data['reward_points'] = this.rewardPoints;
  //   data['status'] = this.status;
  //   data['wallet'] = this.wallet;
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

