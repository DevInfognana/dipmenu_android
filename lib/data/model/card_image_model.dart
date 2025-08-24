class Cardimage {
  bool? status;
  String? message;
  Result? result;

  Cardimage({this.status, this.message, this.result});

  Cardimage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.result != null) {
  //     data['result'] = this.result!.toJson();
  //   }
  //   return data;
  // }
}

class Result {
  String? maskedPan;
  String? cardType;
  String? country;
  String? currency;
  bool? debit;

  Result(
      {this.maskedPan, this.cardType, this.country, this.currency, this.debit});

  Result.fromJson(Map<String, dynamic> json) {
    maskedPan = json['maskedPan'];
    cardType = json['cardType'];
    country = json['country'];
    currency = json['currency'];
    debit = json['debit'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['maskedPan'] = this.maskedPan;
  //   data['cardType'] = this.cardType;
  //   data['country'] = this.country;
  //   data['currency'] = this.currency;
  //   data['debit'] = this.debit;
  //   return data;
  // }
}
