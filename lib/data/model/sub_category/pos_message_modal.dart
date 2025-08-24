class PosMessageData {
  List<PosMessagevalueData>? data;
  int? count;

  PosMessageData({this.data, this.count});

  PosMessageData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PosMessagevalueData>[];
      json['data'].forEach((v) {
        data!.add(PosMessagevalueData.fromJson(v));
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

class PosMessagevalueData {
  int? id;
  String? startTime;
  String? endTime;
  String? message;
  int? schedule;
  int? updatedBy;
  String? updatedAt;
  String? schDay;
  String? createdAt;

  PosMessagevalueData(
      {this.id,
        this.startTime,
        this.endTime,
        this.message,
        this.schedule,
        this.updatedBy,
        this.updatedAt,
        this.schDay,
        this.createdAt});

  PosMessagevalueData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    message = json['message'];
    schedule = json['schedule'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    schDay = json['sch_day'];
    createdAt = json['created_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['start_time'] = this.startTime;
  //   data['end_time'] = this.endTime;
  //   data['message'] = this.message;
  //   data['schedule'] = this.schedule;
  //   data['updated_by'] = this.updatedBy;
  //   data['updated_at'] = this.updatedAt;
  //   data['sch_day'] = this.schDay;
  //   data['created_at'] = this.createdAt;
  //   return data;
  // }
}
