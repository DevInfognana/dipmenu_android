import '../price.dart';
import 'item_size_data.dart';

class ItemSizeValues {
  List<ItemSizeData>? data;
  List<Price>? price;

  ItemSizeValues({this.data, this.price});

  ItemSizeValues.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ItemSizeData>[];
      json['data'].forEach((v) {
        data!.add( ItemSizeData.fromJson(v));
      });
    }
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add( Price.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.price != null) {
  //     data['price'] = this.price!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}


