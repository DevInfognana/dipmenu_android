class TaxValueData {
  Datas? datas;

  TaxValueData({this.datas});

  TaxValueData.fromJson(Map<String, dynamic> json) {
    datas = json['datas'] != null ? Datas.fromJson(json['datas']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.datas != null) {
  //     data['datas'] = this.datas!.toJson();
  //   }
  //   return data;
  // }
}

class Datas {
  List<Response>? response;

  Datas({this.response});

  Datas.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.response != null) {
  //     data['response'] = this.response!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Response {
  int? id;
  String? tax;
  String? printer;
  String? timezone;
  int? updatedBy;
  String? updatedAt;
  String? createdAt;
  dynamic disclaimer;
  dynamic shopLatitude;
  dynamic shopLongitude;
  dynamic shopRadius;
  dynamic discount;

  Response(
      {this.id,
      this.tax,
      this.printer,
      this.timezone,
      this.updatedBy,
      this.updatedAt,
      this.createdAt,
      this.disclaimer,
      this.shopLatitude,
      this.shopLongitude,
      this.shopRadius,
      this.discount});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tax = json['tax'];
    printer = json['printer'];
    timezone = json['timezone'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    disclaimer = json['disclaimer'];
    shopLatitude = json['latitude'];
    shopLongitude = json['longitude'];
    shopRadius = json['radius'];
    discount = json['discount'];
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['tax'] = tax;
  //   data['printer'] = printer;
  //   data['timezone'] = timezone;
  //   data['updated_by'] = updatedBy;
  //   data['updated_at'] = updatedAt;
  //   data['created_at'] = createdAt;
  //   data['disclaimer'] = disclaimer;
  //   data['latitude'] = shopLatitude;
  //   data['longitude'] = shopLongitude;
  //   data['radius'] = shopRadius;
  //   data['discount'] = discount;
  //   return data;
  // }
}
