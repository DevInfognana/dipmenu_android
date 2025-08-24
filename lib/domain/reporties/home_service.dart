import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class HomeServices {
  static viewHomeBannersRequest() async {
    var url = '${BaseAPI.api}/website/banners';
    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  static viewHomeCategoryRequest() async {
    var url =  BaseAPI.category;
    print('==>homescreen: $url');
    // var url = Endpoints().httpUri(Endpoints.category);
    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  static generalSettingApi() async {
    var url =  BaseAPI.category;
    print('==>hoescreen2: $url');
    // var url = Endpoints().httpUri(Endpoints.cartListTaxGetApi);
    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  static viewColorPlateRequest() async {
    var url =  BaseAPI.colorPlate;
    // var url = Endpoints().httpUri(Endpoints.colorPlate);
    var response = await Crud.getData(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-access-token': SharedPrefs.instance.getString('token')
        }));
    return response.fold((l) => l, (r) => r);
  }

  checkInFeature(dynamic values) async {
    dynamic responseValues;
    var url =  BaseAPI.checkInApi;
    // var url = Endpoints().httpUri(Endpoints.checkInApi);
    try {
      await Dio()
          .post(
        url,
        data: jsonEncode({"payload": values}),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-access-token': SharedPrefs.instance.getString('token')
        }),
      )
          .then((response) {
        if (response.statusCode == 200) {
          responseValues = response.data;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
    return responseValues;
  }
}
