import 'banner_data.dart';

class BannersModel {
  int? count;
  List<BannerData>? data;

  BannersModel({this.count, this.data});

  BannersModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add( BannerData.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  Map<String, dynamic>();
  //   data['count'] = this.count;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

