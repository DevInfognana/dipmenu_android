class Signup_values {
  int? rewardPoints;
  int? status;
  int? trash;
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? roleId;
  String? mobile;
  String? location;
  String? profileImageurl;
  String? updatedAt;
  String? createdAt;
  dynamic driveThruDetails;
  dynamic accessToken;
  dynamic token;
  dynamic createdBy;
  dynamic updatedBy;

  Signup_values(
      {this.rewardPoints,
        this.status,
        this.trash,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.roleId,
        this.mobile,
        this.location,
        this.profileImageurl,
        this.updatedAt,
        this.createdAt,
        this.driveThruDetails,
        this.accessToken,
        this.token,
        this.createdBy,
        this.updatedBy});

  Signup_values.fromJson(Map<String, dynamic> json) {
    rewardPoints = json['reward_points'];
    status = json['status'];
    trash = json['trash'];
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    roleId = json['role_id'];
    mobile = json['mobile'];
    location = json['location'];
    profileImageurl = json['profile_imageurl'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    driveThruDetails = json['driveThru_details'];
    accessToken = json['access_token'];
    token = json['token'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['reward_points'] = this.rewardPoints;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['id'] = this.id;
  //   data['first_name'] = this.firstName;
  //   data['last_name'] = this.lastName;
  //   data['email'] = this.email;
  //   data['password'] = this.password;
  //   data['role_id'] = this.roleId;
  //   data['mobile'] = this.mobile;
  //   data['location'] = this.location;
  //   data['profile_imageurl'] = this.profileImageurl;
  //   data['updated_at'] = this.updatedAt;
  //   data['created_at'] = this.createdAt;
  //   data['driveThru_details'] = this.driveThruDetails;
  //   data['access_token'] = this.accessToken;
  //   data['token'] = this.token;
  //   data['created_by'] = this.createdBy;
  //   data['updated_by'] = this.updatedBy;
  //   return data;
  // }
}
