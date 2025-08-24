class ForgotpasswordModel {
  String? message;
  String? token;
  String? email;

  ForgotpasswordModel({this.message, this.token, this.email});

  ForgotpasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    email = json['email'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['message'] = this.message;
  //   data['token'] = this.token;
  //   data['email'] = this.email;
  //   return data;
  // }
}



class Drive {
  String? vehicleModel;
  String? vehicleColor;
  String? vehicleNo;

  Drive({this.vehicleModel, this.vehicleColor, this.vehicleNo});

  Drive.fromJson(Map<String, dynamic> json) {
    vehicleModel = json['vehicleModel'];
    vehicleColor = json['vehicleColor'];
    vehicleNo = json[' vehicleNo'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['vehicleModel'] = this.vehicleModel;
  //   data['vehicleColor'] = this.vehicleColor;
  //   data[' vehicleNo'] = this.vehicleNo;
  //   return data;
  // }
}
