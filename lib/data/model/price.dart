class Price {
  int? id;
  int? productId;
  int? itemsizeId;
  String? price;
  String? points;
  int? position;
  dynamic createdBy;
  String? createdAt;
  dynamic updatedBy;
  String? updatedAt;

  Price(
      {this.id,
        this.productId,
        this.itemsizeId,
        this.price,
        this.points,
        this.position,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  Price.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    itemsizeId = json['itemsize_id'];
    price = json['price'];
    points = json['points'];
    position = json['position'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['product_id'] = this.productId;
  //   data['itemsize_id'] = this.itemsizeId;
  //   data['price'] = this.price;
  //   data['points'] = this.points;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}