class CategoryModelData {
  int? id;
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

  CategoryModelData(
      {this.id,
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

  CategoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  //   final Map<String, dynamic> CategoryModelData =  <String, dynamic>{};
  //   CategoryModelData['id'] = id;
  //   CategoryModelData['name'] = name;
  //   CategoryModelData['description'] = description;
  //   CategoryModelData['image'] = image;
  //   CategoryModelData['order_no'] = orderNo;
  //   CategoryModelData['status'] = status;
  //   CategoryModelData['trash'] = trash;
  //   CategoryModelData['created_by'] = createdBy;
  //   CategoryModelData['created_at'] = createdAt;
  //   CategoryModelData['updated_by'] = updatedBy;
  //   CategoryModelData['updated_at'] = updatedAt;
  //   return CategoryModelData;
  // }
}