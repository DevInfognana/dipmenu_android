class favouriteModel {
  int? count;
  List<FavouriteDataValue>? data;

  favouriteModel({this.count, this.data});

  favouriteModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <FavouriteDataValue>[];
      json['data'].forEach((v) {
        data!.add(FavouriteDataValue.fromJson(v));
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

class FavouriteDataValue {
  int? id;
  int? productId;
  int? quantity;
  dynamic productPrice;
  String? description;
  String? defaultSizeName;
  String? itemNames;
  String? itemPrice;
  String? itemIds;
  dynamic? totalCost;
  dynamic defaultSize;
 dynamic reward;
  int? defaultCustom;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Product? product;


  FavouriteDataValue(
      {this.id,
        this.productId,
        this.quantity,
        this.productPrice,
        this.description,
        this.defaultSizeName,
        this.itemNames,
        this.itemPrice,
        this.itemIds,
        this.totalCost,
        this.defaultSize,
        this.reward,
        this.defaultCustom,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.product});

  FavouriteDataValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    description = json['description'];
    defaultSizeName = json['default_size_name'];
    itemNames = json['item_names'];
    itemPrice = json['item_price'];
    itemIds = json['item_ids'];
    totalCost = json['total_cost'];
    defaultSize = json['default_size'];
    reward = json['reward'];
    defaultCustom = json['default_custom'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['product_id'] = this.productId;
  //   data['quantity'] = this.quantity;
  //   data['product_price'] = this.productPrice;
  //   data['description'] = this.description;
  //   data['default_size_name'] = this.defaultSizeName;
  //   data['item_names'] = this.itemNames;
  //   data['item_price'] = this.itemPrice;
  //   data['item_ids'] = this.itemIds;
  //   data['total_cost'] = this.totalCost;
  //   data['default_size'] = this.defaultSize;
  //   data['reward'] = this.reward;
  //   data['default_custom'] = this.defaultCustom;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   if (this.product != null) {
  //     data['product'] = this.product!.toJson();
  //   }
  //   return data;
  // }
}

class Product {
  int? id;
  int? categoryId;
  int? subcategoryId;
  String? name;
  String? itemCode;
  String? description;
  int? defaultSize;
  String? image;
  int? uom;
  String? weight;
  String? reward;
  int? customMenus;
  String? customMenuIds;
  String? customMenuMin;
  String? customMenuMax;
  int? orderNo;
  int? status;
  int? trash;

  Product(
      {this.id,
        this.categoryId,
        this.subcategoryId,
        this.name,
        this.itemCode,
        this.description,
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
        this.trash});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    itemCode = json['item_code'];
    description = json['description'];
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

  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['category_id'] = this.categoryId;
  //   data['subcategory_id'] = this.subcategoryId;
  //   data['name'] = this.name;
  //   data['item_code'] = this.itemCode;
  //   data['description'] = this.description;
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
  //   return data;
  // }
}

