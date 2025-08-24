import 'package:dip_menu/data/model/product_preview/product_preview_data.dart';

class ProductPreviewModel {
  List<ProductPreviewData>? data;
  int? cartExists;
  int? favourite;

  ProductPreviewModel({this.data, this.cartExists});

  ProductPreviewModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductPreviewData>[];
      json['data'].forEach((v) {
        data!.add( ProductPreviewData.fromJson(v));
      });
    }
    cartExists = json['cartExists'];
    favourite = json['favourite'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['cartExists'] = this.cartExists;
  //   data['favourite'] = this.favourite;
  //   return data;
  // }
}








