

import 'package:dio/dio.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class SearchServices {
  static viewSearchRequest(String? query) async {
    var url = '${BaseAPI.api}/website/products?query=&page=0&limit=0&sortby=&order=';

    var response = await Crud.getData(url,  options: Options(headers: {
      'x-access-token':
      SharedPrefs.instance.getString('token')
    }));
    return response.fold((l) => l, (r) => r);
  }

  static viewEditSearchRequest(String? query) async {
    var url = '${BaseAPI.api}/website/products?query=$query&page=0&limit=0&sortby=&order=';

    var response = await Crud.getData(url,  options: Options(headers:{
      'x-access-token':
      SharedPrefs.instance.getString('token')
    }));
    return response.fold((l) => l, (r) => r);
  }

  // static viewHomeCategoryRequest() async {
  //   var url = '${BaseAPI.api}/website/category';
  //
  //   var response = await Crud.getData(url);
  //   return response.fold((l) => l, (r) => r);
  // }

}