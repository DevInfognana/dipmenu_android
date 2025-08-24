class Subcategories {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? image;
  int? orderNo;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  Subcategories(
      {this.id,
        this.categoryId,
        this.name,
        this.description,
        this.image,
        this.orderNo,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    orderNo = json['order_no'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['category_id'] = this.categoryId;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['image'] = this.image;
  //   data['order_no'] = this.orderNo;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}