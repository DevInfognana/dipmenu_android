class CustomMenuData {
  int? id;
  String? name;
  String? code;
  String? isHybrid;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;
  bool? isExpanded = false;
  int? minSelectValues = 0;
  List<CustomMenuItems>? customMenuItems;
  List<CustomProducts>? customProducts;
  List<CustomizeMenuValueItems> customizeMenuItems = [];
  List<SelectedItems> selectedItems = [];
  List<String> editSelectedItems = [];

  // List<String> defaulttems = [];

  CustomMenuData(
      {this.id,
      this.name,
      this.code,
      this.isHybrid,
      this.status,
      this.trash,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.customMenuItems,
      this.customProducts,
      this.isExpanded,
      this.minSelectValues,
      required this.customizeMenuItems,
      required this.selectedItems});

  CustomMenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    isHybrid = json['is_hybrid'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    if (json['custom_menu_items'] != null) {
      customMenuItems = <CustomMenuItems>[];
      json['custom_menu_items'].forEach((v) {
        customMenuItems!.add(CustomMenuItems.fromJson(v));
      });
    }
    if (json['custom_products'] != null) {
      customProducts = <CustomProducts>[];
      json['custom_products'].forEach((v) {
        customProducts!.add(CustomProducts.fromJson(v));
      });
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['code'] = this.code;
//   data['status'] = this.status;
//   data['trash'] = this.trash;
//   data['created_by'] = this.createdBy;
//   data['created_at'] = this.createdAt;
//   data['updated_by'] = this.updatedBy;
//   data['updated_at'] = this.updatedAt;
//   if (this.customMenuItems != null) {
//     data['custom_menu_items'] =
//         this.customMenuItems!.map((v) => v.toJson()).toList();
//   }
//   if (this.customProducts != null) {
//     data['custom_products'] =
//         this.customProducts!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class CustomMenuItems {
  int? id;
  int? orderNo;
  int? customMenuId;
  String? name;
  String? code;
  String? description;
  String? price;
  String? weight;
  String? image;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  bool? isChecked = false;

  CustomMenuItems(
      {this.id,
      this.customMenuId,
      this.name,
      this.code,
      this.description,
      this.price,
      this.weight,
      this.image,
      this.status,
      this.trash,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.isChecked,
      this.orderNo});

  CustomMenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customMenuId = json['custom_menu_id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    price = json['price'];
    weight = json['weight'];
    image = json['image'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    orderNo = json['order_no'] ?? 0;
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['custom_menu_id'] = this.customMenuId;
//   data['name'] = this.name;
//   data['code'] = this.code;
//   data['description'] = this.description;
//   data['price'] = this.price;
//   data['weight'] = this.weight;
//   data['image'] = this.image;
//   data['status'] = this.status;
//   data['trash'] = this.trash;
//   data['created_by'] = this.createdBy;
//   data['created_at'] = this.createdAt;
//   data['updated_by'] = this.updatedBy;
//   data['updated_at'] = this.updatedAt;
//   data['order_no']=this.orderNo;
//   return data;
// }
}

class CustomProducts {
  int? id;
  int? productId;
  int? customMenuId;
  String? itemName;
  int? customItemId;
  int? itemsizeId;
  String? price;
  String? points;
  int? defaultSelect;
  dynamic createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;

  CustomProducts(
      {this.id,
      this.productId,
      this.customMenuId,
      this.itemName,
      this.customItemId,
      this.itemsizeId,
      this.price,
      this.points,
      this.defaultSelect,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  CustomProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customMenuId = json['custom_menu_id'];
    itemName = json['item_name'];
    customItemId = json['custom_item_id'];
    itemsizeId = json['itemsize_id'];
    price = json['price'] ?? '0.0';
    points = json['points'] ?? '0.0';
    defaultSelect = json['default_select'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['product_id'] = this.productId;
//   data['custom_menu_id'] = this.customMenuId;
//   data['item_name'] = this.itemName;
//   data['custom_item_id'] = this.customItemId;
//   data['itemsize_id'] = this.itemsizeId;
//   data['price'] = this.price;
//   data['points'] = this.points;
//   data['default_select'] = this.defaultSelect;
//   data['created_by'] = this.createdBy;
//   data['created_at'] = this.createdAt;
//   data['updated_by'] = this.updatedBy;
//   data['updated_at'] = this.updatedAt;
//   return data;
// }
}

class SelectedItems {
  int? customProductMenuId;
  int? customProductId;
  String? itemName;
  int? weight;

  SelectedItems(
      {this.customProductMenuId,
      this.customProductId,
      this.itemName,
      this.weight});
}

class CustomizeMenuValueItems {
  int? id;
  int? customMenuId;
  String? name;
  String? image;
  int? defaultSelect;
  bool? isChecked;
  int? orderId;
  int? weight;

  CustomizeMenuValueItems(
      {this.id,
      this.customMenuId,
      this.name,
      this.image,
      this.defaultSelect,
      this.isChecked,
      this.orderId,
      this.weight});
}
