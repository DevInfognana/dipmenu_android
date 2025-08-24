import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dip_menu/domain/entities/crud_operation.dart';
import 'package:dip_menu/domain/local_handler/Local_handler.dart';
import 'package:dip_menu/domain/provider/http_request.dart';

class RecentOrder {
  static recentOrderApi({required String values}) async {
    var url = BaseAPI.createOrder;
    var response = await Crud.postData(
      url,
      json.encode({
        "payload": {"order_id": values}
      }),
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    // print('---review2---->$response');
    return response.fold((l) => l, (r) => r);
  }
}
