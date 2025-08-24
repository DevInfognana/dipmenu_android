import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class ProductPreviewServices {
  static viewProductPreviewRequest(String? query) async {
    var url = '${BaseAPI.api}/website/product/$query';

    var response = await Crud.getData(
      url,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    // print('---review1---->$response');
    return response.fold((l) => l, (r) => r);
  }

//  https://dipmenu-api-dev.demomywebapp.com/api/v1/website/custommenu

  static itemSize({required String values}) async {
    var url = '${BaseAPI.api}/website/itemsize';
    var response = await Crud.postData(
      url,
      json.encode({"id": values}),
      Options(headers: {
        'Content-Type': 'application/json',
      }),
    );
    // print('---review2---->$response');
    return response.fold((l) => l, (r) => r);
  }

  static customMenu({required String values}) async {
    var url = '${BaseAPI.api}/website/custommenu';

     // print('---->${url}');
     // print('---->${json.encode({"id": values})}');
    var response = await Crud.postData(
      url,
      json.encode({"id": values}),
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    // print('---review3---->$response');
    return response.fold((l) => l, (r) => r);
  }

  static favouiteAdded(
      {required String productCode, required String status}) async {
    var url = '${BaseAPI.api}/website/addfavourite';
    var response = await Crud.postData(
      url,
      json.encode({
        "payload": {
          "product_id": int.parse(productCode),
          "status": int.parse(status)
        }
      }),
      Options(
          headers: {'x-access-token': SharedPrefs.instance.getString('token')}),
    );

    return response.fold((l) => l, (r) => r);
  }

  static newFavouriteAdded(
      {required String productId,
      required int quanity,
      required String productPrice,
      required String itemPrice,
      required String itemId,
      required double totalCost,
      required int status,
      required int defaultSize,
      required int defaultCustom,
      required String defaultSizeName,
        required String defaultSizeCode,
      required String itemNames,
      required bool rewards,
      required String description}) async {
    var url = BaseAPI.addFavourite;
    var body = json.encode({
      "payload": {
        "product_id": productId,
        "quantity": quanity,
        "product_price": productPrice,
        "item_price": itemPrice,
        "item_ids": itemId,
        "total_cost": totalCost,
        "status": 1,
        "default_size": defaultSize,
        "default_custom": defaultCustom,

        "default_size_name": defaultSizeCode,
        "size_description":defaultSizeName,
        "item_names": itemNames,
        "description": description,
        "reward": rewards == true ? "1" : "0"
      }
    });
    var response = await Crud.postData(
      url,
      body,
      Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );

    return response.fold((l) => l, (r) => r);
  }

  static removeFavourites({required String productCode}) async {
    var url = BaseAPI.removeFavourite;
    var body = json.encode({"id": int.parse(productCode)});
    var response = await Crud.postData(
        url,
        body,
        Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token')
        }));

    return response.fold((l) => l, (r) => r);
  }

  static addCart(
      {required String productId,
      required int quanity,
      required String productPrice,
       String? actualPrice,
      required String itemPrice,
      required String itemId,
      required double totalCost,
      required int status,
      required String tempToken,
      required int defaultSize,
      required int defaultCustom,
      required String defaultSizeName,
      required String defaultSizeCode,
      required String itemNames,
      required bool rewards,
      required String description}) async {
    var url = BaseAPI.addCart;
    var body;
    if(rewards== false){
      body = json.encode({
        "payload": {
          "product_id": productId,
          "quantity": quanity,
          "product_price": productPrice,
          "item_price": itemPrice,
          "item_ids": itemId,
          "total_cost": totalCost,
          "status": status,
          "temp_token": SharedPrefs.instance.getString('tempToken'),
          "default_size": defaultSize,
          "default_custom": defaultCustom,
          "default_size_name": defaultSizeCode,
      "size_description":defaultSizeName,
          "item_names": itemNames,
          "description": description,
          "created_by": "",
          "actual_price": actualPrice,
          "reward": rewards == true ? "1" : "0"
        }
      });
  }else{
      body = json.encode({
        "payload": {
          "product_id": productId,
          "quantity": quanity,
          "product_price": productPrice,
          "item_price": itemPrice,
          "item_ids": itemId,
          "total_cost": totalCost,
          "status": status,
          "temp_token": SharedPrefs.instance.getString('tempToken'),
          "default_size": defaultSize,
          "default_custom": defaultCustom,
          "default_size_name": defaultSizeCode,
          "size_description":defaultSizeName,
          "item_names": itemNames,
          "description": description,
          "actual_price": '0',
          "created_by": "",
          "reward": rewards == true ? "1" : "0"
        }
      });
    }
    // print("====>addcart_val: $body");

    log(body);
    log(BaseAPI.addCart);


    var response = await Dio().post(
      url,
      data: body,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    int? statusCode = response.statusCode;

    if (statusCode == 200) {
      String success = 'Success fully added';
      return success;
    } else {
      throw Exception('not added');
    }
  }

  static UpdateCart(
      {required String productId,
      required int quanity,
      required String CartUuid,
      required String productPrice,
        String? actualPrice,
      required String itemPrice,
      required String itemId,
      required double totalCost,
      required int status,
      required String tempToken,
      required int defaultSize,
      required int defaultCustom,
      required String defaultSizeName,
        required String defaultSizeCode,
        required String itemNames,
      required bool rewards,
      required String description}) async {
    var url = BaseAPI.updateCart;
    var body;
    if(rewards== false){
      body = json.encode({
        "payload": {
          "product_id": productId,
          "quantity": quanity,
          "product_price": productPrice,
          "item_price": itemPrice,
          "item_ids": itemId,
          "total_cost": totalCost,
          "status": status,
          "temp_token": SharedPrefs.instance.getString('tempToken'),
          "default_size": defaultSize,
          "default_custom": defaultCustom,
          "default_size_name": defaultSizeCode,
          "size_description":defaultSizeName,
          "item_names": itemNames,
          "description": description,
           "actual_price": actualPrice,
          "id": CartUuid,
          "reward": rewards == true ? "1" : "0"
        }
      });
    }else{
      body = json.encode({
        "payload": {
          "product_id": productId,
          "quantity": quanity,
          "product_price": productPrice,
          "item_price": itemPrice,
          "item_ids": itemId,
          "total_cost": totalCost,
          "status": status,
          "temp_token": SharedPrefs.instance.getString('tempToken'),
          "default_size": defaultSize,
          "default_custom": defaultCustom,
          "default_size_name": defaultSizeCode,
          "size_description":defaultSizeName,
          "item_names": itemNames,
          "description": description,
          "id": CartUuid,
          "actual_price": '0',
          "reward": rewards == true ? "1" : "0"
        }
      });
    }
    log(body);
    log(url);
    var response = await Dio().post(
      url,
      data: body,
      options: Options(headers: {
        'Content-Type': 'application/json',
         'x-access-token': SharedPrefs.instance.getString('token')
      }),
    );
    int? statusCode = response.statusCode;

    if (statusCode == 200) {
      String success = 'Success fully added';
      return success;
    } else {
      throw Exception('not added');
    }
  }
}
