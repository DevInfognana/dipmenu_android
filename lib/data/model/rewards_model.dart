import 'package:dip_menu/data/model/price.dart';
import 'package:dip_menu/data/model/sub_category/category_product.dart';

import 'home/category/category_data_model.dart';

class RewardsproductsModel {
  int? count;
  List<RewardsProductsData>? data;

  RewardsproductsModel({this.count, this.data});

  RewardsproductsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <RewardsProductsData>[];
      json['data'].forEach((v) {
        data!.add( RewardsProductsData.fromJson(v));
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

class RewardsProductsData {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? itemCode;
  String? description;
  String? additionalInformation;
  int? defaultSize;
  String? image;
  int? uom;
  String? weight;
  String? reward;
  int? customMenus;
  String? customMenuIds;
  String? customMenuMin;
  String? customMenuMax;
  dynamic orderNo;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  CategoryModelData? category;
  Subcategories? subcategory;
  List<Price>? price;

  RewardsProductsData(
      {this.id,
        this.categoryId,
        this.subcategoryId,
        this.name,
        this.itemCode,
        this.description,
        this.additionalInformation,
        this.defaultSize,
        this.image,
        this.uom,
        this.weight,
        this.reward,
        this.customMenus,
        this.customMenuIds,
        this.customMenuMin,
        this.customMenuMax,
        this.orderNo,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.category,
        this.subcategory,
        this.price});

  RewardsProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    itemCode = json['item_code'];
    description = json['description'];
    additionalInformation = json['additional_information'];
    defaultSize = json['default_size'];
    image = json['image'];
    uom = json['uom'];
    weight = json['weight'];
    reward = json['reward'];
    customMenus = json['custom_menus'];
    customMenuIds = json['custom_menu_ids'];
    customMenuMin = json['custom_menu_min'];
    customMenuMax = json['custom_menu_max'];
    orderNo = json['order_no'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? CategoryModelData.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? Subcategories.fromJson(json['subcategory'])
        : null;
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add(Price.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['category_id'] = this.categoryId;
  //   data['subcategory_id'] = this.subcategoryId;
  //   data['name'] = this.name;
  //   data['item_code'] = this.itemCode;
  //   data['description'] = this.description;
  //   data['additional_information'] = this.additionalInformation;
  //   data['default_size'] = this.defaultSize;
  //   data['image'] = this.image;
  //   data['uom'] = this.uom;
  //   data['weight'] = this.weight;
  //   data['reward'] = this.reward;
  //   data['custom_menus'] = this.customMenus;
  //   data['custom_menu_ids'] = this.customMenuIds;
  //   data['custom_menu_min'] = this.customMenuMin;
  //   data['custom_menu_max'] = this.customMenuMax;
  //   data['order_no'] = this.orderNo;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   if (this.category != null) {
  //     data['category'] = this.category!.toJson();
  //   }
  //   if (this.subcategory != null) {
  //     data['subcategory'] = this.subcategory!.toJson();
  //   }
  //   if (this.price != null) {
  //     data['price'] = this.price!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}


/*
* category
* subCategory
* price they all depend*/



