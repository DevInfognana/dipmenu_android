// class ColorPlateModel {
//   List<Result>? result;
//
//   ColorPlateModel({this.result});
//
//   ColorPlateModel.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = <Result>[];
//       json['result'].forEach((v) {
//         result!.add(new Result.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ResultColorPlateValues {

  List<SavedColors>? savedColors;

  ResultColorPlateValues({this.savedColors});

  ResultColorPlateValues.fromJson(Map<String, dynamic> json) {

    if (json['colorList'] != null) {
      savedColors = <SavedColors>[];
      json['colorList'].forEach((v) {
        savedColors!.add( SavedColors.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //
  //   if (this.savedColors != null) {
  //     data['selected_colors'] = this.savedColors!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class SavedColors {
  String? colorCode;
  String? colorName;

  SavedColors({this.colorCode, this.colorName});

  SavedColors.fromJson(Map<String, dynamic> json) {
    colorCode = json['colorCode'];
    colorName = json['colorName'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['colorCode'] = this.colorCode;
  //   data['colorName'] = this.colorName;
  //   return data;
  // }
}
