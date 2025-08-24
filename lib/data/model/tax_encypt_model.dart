class TaxValueEncyptData {
  String? datas;

  TaxValueEncyptData({this.datas});

  TaxValueEncyptData.fromJson(Map<String, dynamic> json) {
    datas = json['datas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datas'] = datas;
    return data;
  }
}