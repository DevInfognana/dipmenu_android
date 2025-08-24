class BannerData {
  int? id;
  String? name;
  String? description;
  String? images;
  String? fromDate;
  String? toDate;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  BannerData(
      {this.id,
        this.name,
        this.description,
        this.images,
        this.fromDate,
        this.toDate,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> BannerData = <String, dynamic>{};
  //   BannerData['id'] = id;
  //   BannerData['name'] = name;
  //   BannerData['description'] = description;
  //   BannerData['images'] = images;
  //   BannerData['from_date'] = fromDate;
  //   BannerData['to_date'] = toDate;
  //   BannerData['status'] = status;
  //   BannerData['trash'] = trash;
  //   BannerData['created_by'] = createdBy;
  //   BannerData['created_at'] = createdAt;
  //   BannerData['updated_by'] = updatedBy;
  //   BannerData['updated_at'] = updatedAt;
  //   return BannerData;
  // }
}
