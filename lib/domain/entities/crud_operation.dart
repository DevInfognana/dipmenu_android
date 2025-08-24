import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dip_menu/domain/entities/status_reques.dart';
import 'check_internet.dart';
import 'dio_exception.dart';

class Crud {
  static Future<Either<StatusRequest, Map>> postData(
      String linkurl, String data, Options options) async {
    try {
      if (await checkInternet()) {
        Response response = await Dio().post(
          linkurl,
          data: data,
          options: options,
        );
        // print('-----');

        if (response.statusCode == 200 || response.statusCode == 201) {
          // print('------>Status${response.statusMessage}');
          // Map<String, dynamic> map = json.decode(response.data);
          // print('map---->${response.data}');

          return Right(response.data);
          // Map responsebody = jsonDecode(response.data);
          // return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } on DioError {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // print(errorMessage);
      return const Left(StatusRequest.timeoutfailure);
    }
  }

  static Future<Either<StatusRequest, Map>> getData(
    String linkurl, {
    Map<String, dynamic>? map,
    Options? options,
  }) async {
    try {
      if (await checkInternet()) {
        // checkInternetSpeed();
        Response response = await Dio().get(
          linkurl,
          queryParameters: map,
          options: options,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

          return Right(data);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } on DioError {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      return const Left(StatusRequest.serverfailure);
    }
  }

  static Future<Either<StatusRequest, Map>> deleteData(
      String linkurl, Options options) async {
    try {
      if (await checkInternet()) {
        Response response = await Dio().delete(
          linkurl,
          options: options,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
          return Right(data);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } on DioError {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      return const Left(StatusRequest.serverfailure);
    }
  }
}

class Crud1 {

   Future<Either<StatusRequest, Map>> getData(
      String linkUrl,{ String? data, Options? options}) async{
    var responseJson;
    try {
      final response =   await Dio().get(
          linkUrl);
      responseJson =Right(response);
    } on SocketException {
      return const Left(StatusRequest.offlinefailure);
    }
    return responseJson;
  }

  dynamic responseValues(dynamic response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
        return data;
      case 400:
        return const Left(StatusRequest.serverfailure);
      case 401:
        return const Left(StatusRequest.serverfailure);
      case 403:
        return const Left(StatusRequest.serverfailure);
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

/*  static Future<Either<StatusRequest, Map>> postData(
      String linkurl, String data, Options options) async {
    try {
      if (await checkInternet()) {
        // await checkInternetSpeed();
        Response response = await Dio().post(
          linkurl,
          data: data,
          options: options,
        );
        print('-----');

        if (response.statusCode == 200 || response.statusCode == 201) {
          // print('------>Status${response.statusMessage}');
          // Map<String, dynamic> map = json.decode(response.data);
          // print('map---->${response.data}');

          return Right(response.data);
          // Map responsebody = jsonDecode(response.data);
          // return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }*/