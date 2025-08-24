class AboutUsData {
  List<Data>? data;
  int? count;

  AboutUsData({this.data, this.count});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data =  <String, dynamic>{};
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['count'] = count;
  //   return data;
  // }
}

class Data {
  int? id;
  String? name;
  String? content;
  String? image;
  int? status;
  int? trash;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.content,
        this.image,
        this.status,
        this.trash,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    image = json['image'];
    status = json['status'];
    trash = json['trash'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['content'] = content;
    data['image'] = image;
    data['status'] = status;
    data['trash'] = trash;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}
