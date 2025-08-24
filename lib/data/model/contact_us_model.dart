class ContactUsData {
  List<Data>? data;
  int? count;

  ContactUsData({this.data, this.count});

  ContactUsData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['count'] = this.count;
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
  dynamic createdBy;
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['content'] = this.content;
  //   data['image'] = this.image;
  //   data['status'] = this.status;
  //   data['trash'] = this.trash;
  //   data['created_by'] = this.createdBy;
  //   data['created_at'] = this.createdAt;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }
}
