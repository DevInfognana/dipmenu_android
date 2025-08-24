import 'package:dio/dio.dart';
// import 'package:dip_menu/data/model/about_us_model.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class AboutUsViewServices {
  // Future<AboutUsData> aboutUsAPi({
  //   required String values,
  // }) async {
  //   var url = '${BaseAPI.api}/website/aboutus}';
  //   var response = await Dio().get(
  //       url,
  //       options: Options(headers: {
  //         'x-access-token':
  //         SharedPrefs.instance.getString('token')
  //       })
  //   );
  //   int? statusCode = response.statusCode;
  //   if (statusCode == 200) {
  //     AboutUsData result = AboutUsData.fromJson(response.data);
  //     return result;
  //   } else {
  //     throw Exception('not Login');
  //   }
  // }

}

class AboutUsServices {
  static aboutUsRequest() async {
    var url = '${BaseAPI.api}/website/aboutus';
    var response = await Crud.getData(url,        options: Options(headers: {
      'x-access-token':
      SharedPrefs.instance.getString('token')
    })
    );
    return response.fold((l) => l, (r) => r);
  }
}



class FavouiteServices{
  static viewFavouirteProductRequest() async {
    var url = '${BaseAPI.api}/website/getfavoritelist?query=&page=0&limit=0&sortby=&order=';



    var response = await Crud.getData(url, options: Options(headers: {
      'x-access-token':
      SharedPrefs.instance.getString('token')
    }));
    return response.fold((l) => l, (r) => r);
  }
}