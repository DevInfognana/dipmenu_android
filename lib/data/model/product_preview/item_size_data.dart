class ItemSizeData {
  int? id;
  String? code;
  String? description;
  int? status;
  int? trash;
  int? createdBy;
  int? position;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  ItemSizeData(
      {this.id,
        this.code,
        this.description,
        this.status,
        this.trash,
        this.position,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  ItemSizeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    status = json['status'];
    trash = json['trash'];
    position = json['position'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['code'] = this.code;
  //   data['description'] = this.description;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}

