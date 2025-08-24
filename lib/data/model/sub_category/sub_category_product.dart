import 'package:dip_menu/data/model/sub_category/sub_category_product_data.dart';

class SubCatListModel {
  List<SubCategoryProductModelData>? data;
  int? count;


  SubCatListModel({this.data, this.count, });

  SubCatListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategoryProductModelData>[];
      json['data'].forEach((v) {
        data!.add( SubCategoryProductModelData.fromJson(v));
      });
    }
    count = json['count'];


  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['count'] = this.count;
  //
  //   return data;
  // }
}




