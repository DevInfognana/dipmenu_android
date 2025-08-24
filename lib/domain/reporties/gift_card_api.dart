import 'dart:convert';

import 'package:dio/dio.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class GiftCardAPi {
  static addCouponApi(
      {required String amount,
      required String email,
      required String code,
      required String? message}) async {
    var url = BaseAPI.addCoupon;

    var success = jsonEncode({
      "payload": {
        "amount": amount,
        "email": '',
        "code": code,
        "redeem_flag": 0,
        "message": message
      }
    });
    var response = await Crud.postData(
      url,
      success,
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    // print('---review2---->$response');
    return response.fold((l) => l, (r) => r);
  }

  static addWalletApi(
      {required String amount,
      required String userId,
      required String code}) async {
    var url = BaseAPI.checkWallet;

    var success = jsonEncode({
      "payload": {
        "amount": amount,
        "user_id": userId,
        "code": code,
        "sender_id": userId,
        "redeem_flag": 0
      }
    });
    var response = await Crud.postData(
      url,
      success,
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    return response.fold((l) => l, (r) => r);
  }

  static checkCouponCodeApi(
      {required String code}) async {
    var url = BaseAPI.checkCoupon;

    var success = jsonEncode({
      "payload":{"redeem_code":code.toString()}
    });
    var response = await Crud.postData(
      url,
      success,
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );

    return response.fold((l) => l, (r) => r);
  }

  static getGiftCardAPi() async {
    var url = BaseAPI.getGiftCards;

    var success = jsonEncode({
    });
    var response = await Crud.postData(
      url,
      success,
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    return response.fold((l) => l, (r) => r);
  }
  static getGiftListAPi() async {
    var url = BaseAPI.getGiftList;

    var response = await Crud.getData(
      url,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );

    return response.fold((l) => l, (r) => r);
  }
}
