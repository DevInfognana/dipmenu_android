class Signin_values {
  int? id;
  String? email;
  String? accessToken;
  int? expiresIn;
  int? roleId;
  String? role;
  String? username;

  Signin_values(
      {this.id,
        this.email,
        this.accessToken,
        this.expiresIn,
        this.roleId,
        this.role,
        this.username});

  Signin_values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    accessToken = json['accessToken'];
    expiresIn = json['expiresIn'];
    roleId = json['roleId'];
    role = json['role'];
    username = json['username'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['email'] = this.email;
  //   data['accessToken'] = this.accessToken;
  //   data['expiresIn'] = this.expiresIn;
  //   data['roleId'] = this.roleId;
  //   data['role'] = this.role;
  //   data['username'] = this.username;
  //   return data;
  // }
}
