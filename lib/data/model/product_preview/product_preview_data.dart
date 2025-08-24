import '../home/category/category_data_model.dart';
import '../price.dart';
import '../sub_category/category_product.dart';

class ProductPreviewData {
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
  String? isWeight;
  String? reward;
  int? customMenus;
  String? customMenuIds;
  String? customMenuMin;
  String? customMenuMax;
  int? orderNo;
  int? hybridProduct;
  int? status;
  int? trash;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  CategoryModelData? category;
  Subcategories? subcategory;
  List<Price>? price;
  List<CustomSize>? customSize;
  List<CustomWeight>? customWeight;
  List<MerchImages>? merchimages;

  ProductPreviewData(
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
      this.isWeight,
      this.reward,
      this.customMenus,
      this.customMenuIds,
      this.customMenuMin,
      this.customMenuMax,
      this.orderNo,
      this.hybridProduct,
      this.status,
      this.trash,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.category,
      this.subcategory,
      this.merchimages,
      this.price,
      this.customSize,
      this.customWeight});

  ProductPreviewData.fromJson(Map<String, dynamic> json) {
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
    isWeight = json['is_weight'];
    reward = json['reward'];
    customMenus = json['custom_menus'];
    customMenuIds = json['custom_menu_ids'];
    customMenuMin = json['custom_menu_min'];
    customMenuMax = json['custom_menu_max'];
    orderNo = json['order_no'];
    hybridProduct = json['hybrid_product'];
    status = json['status'];
    trash = json['trash'];
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
    if (json['custom_size'] != null) {
      customSize = <CustomSize>[];
      json['custom_size'].forEach((v) {
        customSize!.add(CustomSize.fromJson(v));
      });
    }
    if (json['custom_weight'] != null) {
      customWeight = <CustomWeight>[];
      json['custom_weight'].forEach((v) {
        customWeight!.add(CustomWeight.fromJson(v));
      });
    }

    if (json['merchimages'] != null) {
      merchimages = <MerchImages>[];
      json['merchimages'].forEach((v) {
        merchimages!.add(MerchImages.fromJson(v));
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
//   data['is_weight'] = this.isWeight;
//   data['reward'] = this.reward;
//   data['custom_menus'] = this.customMenus;
//   data['custom_menu_ids'] = this.customMenuIds;
//   data['custom_menu_min'] = this.customMenuMin;
//   data['custom_menu_max'] = this.customMenuMax;
//   data['order_no'] = this.orderNo;
//   data['status'] = this.status;
//   data['trash'] = this.trash;
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
//   if (this.customSize != null) {
//     data['custom_size'] = this.customSize!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class CustomSize {
  int? id;
  int? productId;
  String? customMenuId;
  String? itemName;
  String? customItemId;
  String? itemSizeId;
  String? customMin;
  String? customMax;
  String? createdBy;
  String? createdAt;

  CustomSize(
      {this.id,
      this.productId,
      this.customMenuId,
      this.itemName,
      this.customItemId,
      this.itemSizeId,
      this.customMin,
      this.customMax,
      this.createdBy,
      this.createdAt});

  CustomSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customMenuId = json['custom_menu_id'];
    itemName = json['item_name'];
    customItemId = json['custom_item_id'];
    itemSizeId = json['itemsize_id'];
    customMin = json['custom_min'];
    customMax = json['custom_max'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = id;
//   data['product_id'] = productId;
//   data['custom_menu_id'] = customMenuId;
//   data['item_name'] = itemName;
//   data['custom_item_id'] = customItemId;
//   data['itemsize_id'] = itemSizeId;
//   data['custom_min'] = customMin;
//   data['custom_max'] = customMax;
//   data['created_by'] = createdBy;
//   data['created_at'] = createdAt;
//   return data;
// }
}

class CustomWeight {
  int? id;
  int? productId;
  String? itemsizeName;
  String? itemsizeId;
  int? weightValue;
  String? createdAt;
  String? updatedAt;

  CustomWeight(
      {this.id,
      this.productId,
      this.itemsizeName,
      this.itemsizeId,
      this.weightValue,
      this.createdAt,
      this.updatedAt});

  CustomWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    itemsizeName = json['itemsize_name'];
    itemsizeId = json['itemsize_id'];
    weightValue = json['weight_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class MerchImages {
  int? id;
  int? productId;
  String? images;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  MerchImages(
      {this.id,
      this.productId,
      this.images,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  MerchImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    images = json['images'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
