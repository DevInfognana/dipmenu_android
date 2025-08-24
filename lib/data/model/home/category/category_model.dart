import 'category_data_model.dart';

class CategoryModel {
  int? count;
  List<CategoryModelData>? data;

  CategoryModel({this.count, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <CategoryModelData>[];
      json['data'].forEach((v) {
        data!.add( CategoryModelData.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['count'] = this.count;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}


